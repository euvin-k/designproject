from flask import Flask, session, render_template, request, flash, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_user, login_required, logout_user, current_user, UserMixin
import os
import psycopg2
from random import *

app = Flask(__name__)

# app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:thgb13@localhost/unadoctrina'
# db = SQLAlchemy(app)

conn = psycopg2.connect(
    host="localhost",
    port="5432",
    database="unadoctrina",
    user="postgres",
    password="root")

'''class User(db.Model, UserMixin):
    __tablename__ = 'user'
    user_id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(150), unique=True)
    username = db.Column(db.String(150))
    password = db.Column(db.String(150))
    learning_topic = db.Column(db.String(150))
    match_type = db.Column(db.String(150))

    def __init__(self, email, username, password, learning_topic, match_type):
        self.email = email
        self.username = username
        self.password = password
        self.learning_topic = learning_topic
        self.match_type = match_type'''


@app.route('/')
def base():
    # leads to either login or register page
    return render_template('base.html')


@app.route('/login')
def login():
    return render_template('login.html')


@app.route('/register')
def register():
    return render_template('register.html')


@app.route('/home')
def home():
    return render_template('home.html')


@app.route('/loginAuth', methods=['GET', 'POST'])
def loginAuth():
    email = request.form['email']
    password = request.form['password']

    cursor = conn.cursor()
    query = 'SELECT email FROM public.user WHERE email = %s and password = md5(%s)'
    cursor.execute(query, (email, password))
    user = cursor.fetchone()
    cursor.close()
    error = None
    if user:
        session['email'] = email
        return redirect(url_for('home'))
    else:
        error = 'Invalid login'
        return render_template('login.html', error=error)


@app.route('/registerAuth', methods=['GET', 'POST'])
def registerAuth():
    email = request.form['email']
    username = request.form['username']
    password = request.form['password']
    confirm_password = request.form['confirm_password']
    learning_topic = request.form['learning_topic']
    match_type = request.form['match_type']

    cursor = conn.cursor()
    query = 'SELECT email FROM public.user WHERE email = %s'
    cursor.execute(query, (email,))
    user = cursor.fetchone()
    error = None
    if user:
        error = 'This user already exists.'
    elif password != confirm_password:
        error = 'Passwords do not match.'
    else:
        insertQuery = 'INSERT INTO public.user (email, username, password, learning_topic, match_type) VALUES (%s, %s, md5(%s), %s, %s)'
        cursor.execute(insertQuery, (email, username, password, learning_topic, match_type))
        conn.commit()  # allows Python to modify the tables in the database
        cursor.close()
        return redirect(url_for('login'))
    return render_template('register.html', error=error)


app.secret_key = 'some key that you will never guess'

if __name__ == '__main__':
    app.run(debug=True)
