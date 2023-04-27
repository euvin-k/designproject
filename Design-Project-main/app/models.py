from . import db
from flask_login import UserMixin, current_user
from sqlalchemy.sql import func


class Interest(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(150))


# class for the relationship between interest and user
class Enlist(db.Model, UserMixin):
    uid = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)
    iid = db.Column(db.Integer, db.ForeignKey('interest.id'), primary_key=True)


class Match(db.Model, UserMixin):
    uid1 = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)
    uid2 = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)


class Reject(db.Model, UserMixin):
    uid1 = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)
    uid2 = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(150), unique=True)
    password = db.Column(db.String(150), nullable=False)
    first_name = db.Column(db.String(150), nullable=False)
    last_name = db.Column(db.String(150), nullable=False)
    phone_number = db.Column(db.Integer)
    desc = db.Column(db.String(500))

    def __init__(self, fname, lname, email, password, phone_number, desc):
        self.first_name = fname
        self.last_name = lname
        self.email = email
        self.password = password
        self.phone_number = phone_number
        self.desc = desc

    def user_variables(self):
        """
        :return: List of all user variables which are then used in account_details.html
        the Keys are what users see on the page, the list[0] is what it's called in this Class
        and the list[1] is grabbing the data from current_user
        """
        user_details = {
            'User ID': ['id', current_user.id],
            'First Name': ['first_name', current_user.first_name],
            'Last Name': ['last_name', current_user.last_name],
            'Email': ['email', current_user.email],
            'Phone Number': ['phone_number', current_user.phone_number],
            'About Me': ['desc', current_user.desc]
        }
        return user_details


# -------------------


class Group(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(150))


class GroupAdmin(db.Model, UserMixin):
    gid = db.Column(db.Integer, db.ForeignKey('group.id'), primary_key=True)
    uid = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)


class InGroup(db.Model, UserMixin):
    gid = db.Column(db.Integer, db.ForeignKey('group.id'), primary_key=True)
    uid = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)


# -----

class JoinRequest(db.Model, UserMixin):
    gid = db.Column(db.Integer, db.ForeignKey('group.id'), primary_key=True)
    uid = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)


class RejectGroup(db.Model, UserMixin):
    gid = db.Column(db.Integer, db.ForeignKey('group.id'), primary_key=True)
    uid = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)
