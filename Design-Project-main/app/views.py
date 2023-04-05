from flask import Blueprint, render_template, request, flash, jsonify, url_for, redirect
from flask_login import login_required, current_user
from .models import Interest, User
from . import db
import json


views = Blueprint('views', __name__)


@views.route('/', methods=['GET', 'POST'])
@login_required
def home():
    if request.method == 'POST':
        return render_template("home.html", user=current_user)
    return render_template("home.html", user=current_user)


@views.route('/settings', methods=['GET', 'POST'])
@login_required
def settings():
    if request.method == 'POST':
        user = User.query.filter_by(id=current_user.id).first()
        updated_values_dict = request.form.to_dict()
        for k, v in updated_values_dict.items():
            if v.rstrip() != "":
                setattr(
                    user,
                    k.split('update_', 1)[-1],
                    v.rstrip(),
                )
        db.session.commit()
        return redirect(url_for('views.settings'))

    user_details = current_user.user_variables()
    return render_template("settings.html", user=current_user, user_details=user_details)


@views.route('/interests', methods=['GET', 'POST'])
@login_required
def interests():
    if request.method == 'POST':
        interest = request.form.get('interest_menu')  # Gets the new interest from the HTML

        new_interest = Interest(name=interest, user_id=current_user.id)  # providing the schema for the note
        db.session.add(new_interest)  # adding the note to the database
        db.session.commit()
        flash('Interest added!', category='success')

    f = open(r'app/static/hobbies.txt')

    try:
        # do stuff with f
        dic = f.readlines()
    finally:
        f.close()
    return render_template("interests.html", user=current_user, hobbies=dic)


@views.route('/delete-interest', methods=['POST'])
def delete_interest():
    interest = json.loads(request.data)  # this function expects a JSON from the INDEX.js file
    interestId = interest['interestId']
    note = Interest.query.get(interestId)
    if note:
        if note.user_id == current_user.id:
            db.session.delete(note)
            db.session.commit()

    return jsonify({})


