from flask import Blueprint
from flask import render_template


views_blueprint = Blueprint('views', __name__)


@views_blueprint.route('/')
def index():
    return render_template('index.html')
