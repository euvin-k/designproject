import os

from flask import Blueprint, render_template, request, flash, jsonify, url_for, redirect
from flask_login import login_required, current_user
from .models import *
from . import db, ALLOWED_EXTENSIONS

import json
import random
from werkzeug.utils import secure_filename

chat = Blueprint('chat', __name__)


@chat.route('/chatter_lst', methods=['GET', 'POST'])
@login_required
def chatters():
    individual_matches = db.session.query(Match.uid2). \
        filter(Match.uid1 == current_user.id).first()

    # combines the two
    if individual_matches is not None:

        individual_matches = db.session.query(Match.uid2). \
            filter(Match.uid1 == current_user.id).all()

        individual_matches_checker = db.session.query(Match.uid1). \
            filter(Match.uid2 == current_user.id).all()

        match_ids = []

        for id in individual_matches:
            id = str(id)
            nums = ''
            for i in range(len(id)):
                if id[i].isdigit():
                    nums += id[i]

            match_ids.append(int(nums))
            # print(nums)

        # REMOVE IDS THAT DO NOT RECIPROCATE
        if individual_matches_checker is not None:
            for i in range(len(individual_matches_checker)):
                id = str(individual_matches_checker[i])
                nums = ''
                for j in range(len(id)):
                    if id[j].isdigit():
                        nums += id[j]

                individual_matches_checker[i] = int(nums)

            temp = []
            for id in match_ids:
                if id not in individual_matches_checker:
                    temp.append(id)

            for id in temp:
                match_ids.remove(id)

        matches = []
        for match in match_ids:
            user = db.session.query(User). \
                filter(User.id == match).first()

            matches.append({
                'First Name': user.first_name,
                'Last Name': user.last_name,
                'id': user.id
            })

        print(matches)

    # get all groups
    temp_groups = db.session.query(Group) \
        .join(InGroup, Group.id == InGroup.gid) \
        .filter(InGroup.uid == current_user.id) \
        .first()

    groups = []

    if temp_groups is not None:
        temp_groups = db.session.query(Group) \
            .join(InGroup, Group.id == InGroup.gid) \
            .filter(InGroup.uid == current_user.id) \
            .all()

        for group in temp_groups:
            groups.append({
                'id': group.id,
                'name': group.name
            })

    return render_template("chatter_lst.html", user=current_user, matches=matches, groups=groups)


def allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@chat.route('/chat/<uid1>/<uid2>', methods=['GET', 'POST'])
@login_required
def individuals_chat(uid1, uid2):
    user = db.session.query(User). \
        filter(User.id == uid1).first()

    user2 = db.session.query(User). \
        filter(User.id == uid2).first()

    user_data = user.user_variablesjs()
    user2_data = user2.user_variablesjs()

    ids = [min(current_user.id, user2.id), max(current_user.id, user2.id)]

    data = {
        'uid1': uid1,
        'uname1': user.first_name,
        'uid2': uid2,
        'uname2': user2.first_name,
        'room': int(f"{ids[0]}{ids[1]}")
    }

    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(url_for('views.home'))
        file = request.files['file']

        if file.filename == '':
            flash('No selected file')
            return redirect(url_for('views.home'))
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)

            curr_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Files')
            file.save(os.path.join(curr_dir, filename))

    return render_template("chat.html", user=current_user, user_data=user_data, user2_data=user2_data, data=data)


@chat.route('/chat/groups/<gname>/<gid>', methods=['GET', 'POST'])
@login_required
def group_chat(gname, gid):
    group = db.session.query(Group). \
        filter(Group.id == gid).first()

    user = db.session.query(User). \
        filter(User.id == current_user.id).first()

    user_data = user.user_variablesjs()

    data = {
        'uid1': current_user.id,
        'uname': current_user.first_name,
        'gid': group.id,
        'uname2': group.name,
        'room': group.id
    }
    return render_template("chat.html", user=current_user, user_data=user_data, data=data)
