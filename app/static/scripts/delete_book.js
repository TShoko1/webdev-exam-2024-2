document.addEventListener('DOMContentLoaded', (event) => {
    let deleteBookModal = document.querySelector('#deleteBook');
    deleteBookModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;
        let url = button.getAttribute('data-url');
        let bookTitle = button.getAttribute('data-book-title');

        let form = deleteBookModal.querySelector('form');
        form.action = url;

        let bookLogin = deleteBookModal.querySelector('#bookLogin');
        bookLogin.innerHTML = bookTitle;
    });
});
