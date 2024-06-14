"""Initial migration

Revision ID: e3b6ef56f02f
Revises: 19ad1a1d919d
Create Date: 2024-06-14 15:09:12.305132

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'e3b6ef56f02f'
down_revision = '19ad1a1d919d'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('books', schema=None) as batch_op:
        batch_op.alter_column('year_release',
               existing_type=mysql.YEAR(display_width=4),
               type_=sa.Integer(),
               existing_nullable=False)

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('books', schema=None) as batch_op:
        batch_op.alter_column('year_release',
               existing_type=sa.Integer(),
               type_=mysql.YEAR(display_width=4),
               existing_nullable=False)

    # ### end Alembic commands ###
