"""${message}

Revision ID: ${up_revision}
Revises: ${down_revision | comma,n}
Create Date: ${create_date}

"""
from alembic import op
import sqlalchemy as sa
${imports if imports else ""}

# revision identifiers, used by Alembic.
revision = ${repr(up_revision)}
down_revision = ${repr(down_revision)}
branch_labels = ${repr(branch_labels)}
depends_on = ${repr(depends_on)}


def upgrade():
    ${upgrades if upgrades else "pass"}

    op.execute('grant select, insert, update, delete on all tables in schema public to {{ cookiecutter.app_name }}')
    op.execute('grant usage, select on all sequences in schema public to {{ cookiecutter.app_name }}')


def downgrade():
    ${downgrades if downgrades else "pass"}
