from flask import Flask, render_template, request, redirect, session, url_for, flash, abort, send_from_directory
from flask_login import login_required, current_user
from sqlalchemy import MetaData, or_
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import os
from datetime import datetime, timedelta

app = Flask(__name__)
application = app

app.config.from_pyfile('config.py')

convention = {
    "ix": 'ix_%(column_0_label)s',
    "uq": "uq_%(table_name)s_%(column_0_name)s",
    "ck": "ck_%(table_name)s_%(constraint_name)s",
    "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
    "pk": "pk_%(table_name)s"
}

metadata = MetaData(naming_convention=convention)
db = SQLAlchemy(app, metadata=metadata)
migrate = Migrate(app, db)

from models import Book, Genre, Image, Review
from auth import init_login_manager, check_rights, bp as auth_bp
from reviews import bp as reviews_bp

init_login_manager(app)

app.register_blueprint(auth_bp)
app.register_blueprint(reviews_bp)

@app.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    query = Book.query

    title = request.args.get('title')
    if title:
        query = query.filter(Book.name.ilike(f'%{title}%'))
    
    author = request.args.get('author')
    if author:
        query = query.filter(Book.author.ilike(f'%{author}%'))
    
    genres = request.args.getlist('genres')
    if genres:
        query = query.filter(Book.genres.any(Genre.id.in_(genres)))
    
    year = request.args.get('year')
    if year:
        query = query.filter(Book.year_release == int(year))
    
    volume_from = request.args.get('volume_from')
    if volume_from:
        query = query.filter(Book.pages_volume >= int(volume_from))
    
    volume_to = request.args.get('volume_to')
    if volume_to:
        query = query.filter(Book.pages_volume <= int(volume_to))
    
    pagination = query.order_by(Book.id.desc()).paginate(page=page, per_page=app.config['PER_PAGE'])
    books = pagination.items

    # Get all genres for the filter form
    genres = Genre.query.all()

    # Get all distinct years from the books for the filter form
    years = [book.year_release for book in Book.query.with_entities(Book.year_release).distinct().all()]

    return render_template("index.html", pagination=pagination, books=books, genres=genres, years=years)


@app.route('/images/<image_id>')
def image(image_id):
    img = Image.query.get(image_id)
    if img is None:
        abort(404)
    return send_from_directory(app.config['UPLOAD_FOLDER'],
                               img.file_name)

from tool import ImageSaver

def extract_params(dict):
    return {p: request.form.get(p) for p in dict}

BOOKS_PARAMS = [
    'name', 'author', 'publisher', 'year_release', 'pages_volume',
    'short_desc',
]

@app.route('/new', methods=["POST", "GET"])
@login_required
@check_rights('create')
def new():
    if request.method == "POST":
        f = request.files.get('background_img')
        if f and f.filename:
            img = ImageSaver(f).save()
            params = extract_params(BOOKS_PARAMS)
            params['year_release'] = int(params['year_release'])
            params['pages_volume'] = int(params['pages_volume'])
            genres = request.form.getlist('genres')
            genres_list = []
            for i in genres:
                genre = Genre.query.filter_by(id=i).first()
                genres_list.append(genre)

            book = Book(**params, image_id=img.id)
            book.prepare_to_save()
            book.genres = genres_list
            try:
                db.session.add(book)
                db.session.commit()
                flash('Книга успешно добавлена', 'success')
                return redirect(url_for('index'))
            except:
                db.session.rollback()
                flash(
                    'При сохранении данных возникла ошибка. Проверьте корректность введённых данных.', 'success')

        if not (f and f.filename):
            flash('У книги должна быть обложка', 'danger')
    
    '''
    Сохранение книги в базу данных
    '''
    
    genres = Genre.query.all()
    return render_template('books/create_edit.html',
                        action_category='create',
                        genres=genres,
                        book={})


@app.route('/<int:book_id>/edit', methods=["POST", "GET"])
@login_required
@check_rights('edit')
def edit(book_id):
    if request.method == "POST":
        params = extract_params(BOOKS_PARAMS)
        params['year_release'] = int(params['year_release'])
        params['pages_volume'] = int(params['pages_volume'])
        genres = request.form.getlist('genres')
        genres_list = []
        book = Book.query.get(book_id)
        book.name = params['name']
        book.author = params['author']
        book.publisher = params['publisher']
        book.year_release = params['year_release']
        book.pages_volume = params['pages_volume']
        book.short_desc = params['short_desc']

        for i in genres:
            genre = Genre.query.filter_by(id=i).first()
            genres_list.append(genre)
        book.genres = genres_list
        try:
            db.session.add(book)
            db.session.commit()
            flash('Книга успешно обновлена', 'success')
            return redirect(url_for('index'))
        except:
            db.session.rollback()

        flash('При обновления данных возникла ошибка. Проверьте корректность введённых данных.', 'danger')

    book = Book.query.get(book_id)
    genres = Genre.query.all()
    return render_template('books/create_edit.html',
                           action_category='edit',
                           genres=genres,
                           book=book,)

# Удаление книги
@app.route('/<int:book_id>/delete', methods=['POST'])
@login_required
@check_rights('delete')
def delete(book_id):
    book = Book.query.get(book_id)
    # Проверка зависимости у обложки
    references = len(Book.query.filter_by(image_id=book.image.id).all())
       
    try:
         # Удаление всех зависимостей
        for item in Review.query.filter_by(book_id=book_id):
            db.session.delete(item)

        db.session.delete(book)
        # Если зависимость единственная, то обложку можно удалить
        if references == 1:
            image = Image.query.get(book.image.id)
            delete_path = os.path.join(
                app.config['UPLOAD_FOLDER'],
                image.file_name)
            db.session.delete(image)
            os.remove(delete_path)
        db.session.commit()
        flash('Удаление книги прошло успешно', 'success')
    except:
        db.session.rollback()
        flash('Во время удаления книги произошла ошибка', 'danger')

    return redirect(url_for('index'))

# Просмотр книги
@app.route('/<int:book_id>')
def show(book_id):
    book = Book.query.get(book_id)
    book.prepare_to_html()
    # Получаем все рецензии
    reviews = Review.query.filter_by(book_id=book_id)
    # Каждую из рецензий подготавливаем для отображения
    for review in reviews:
        review.prepare_to_html()
    # Заглушка, т.к. у пользователя может не быть рецензии
    user_review = None
    # Если у пользователя есть идентификатор
    if current_user.get_id():
        # Извлекаем рецензии пользователя
        user_review = reviews.filter_by(user_id=current_user.id).first()
    # Получаем все рецензии
    reviews.all()
    
    return render_template('books/show.html',
                           book=book,
                           reviews=reviews,
                           user_review=user_review)