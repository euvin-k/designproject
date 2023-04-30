from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from os import path
from flask_login import LoginManager
from .events import socketio

db = SQLAlchemy()
ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}


def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'dasdahkdkhjdasdb adbaskjdghadgakljhdbas'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:thgb13@localhost/postgres'

    UPLOAD_FOLDER = 'Design-Project-main/app/Files'

    app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

    db.init_app(app)
    socketio.init_app(app)

    from .views import views
    from .auth import auth
    from .chat import chat
    app.register_blueprint(views, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')
    app.register_blueprint(chat, url_prefix='/')

    from .models import User

    with app.app_context():
        db.create_all()

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(uid):
        return User.query.get(int(uid))

    return app
