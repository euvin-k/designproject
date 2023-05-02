import os

from flask import Blueprint, render_template, request, flash, jsonify, url_for, redirect, send_file, send_from_directory
from flask_login import login_required, current_user
from .models import *
from . import db, ALLOWED_EXTENSIONS

import json
import random
from werkzeug.utils import secure_filename

chat = Blueprint('chat', __name__)


@chat.route('/static/<path:path>')
def send_static(path):
    return send_from_directory('static', path)


@chat.route('/chatter_lst', methods=['GET', 'POST'])
@login_required
def chatters():
    individual_matches = db.session.query(Match.uid2). \
        filter(Match.uid1 == current_user.id).first()

    matches = []
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

    return render_template("chatter_lst2.html", user=current_user, matches=matches, groups=groups)


def allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@chat.route('/chat/<uid1>/<uid2>', methods=['GET', 'POST'])
@login_required
def individuals_chat(uid1, uid2):
    # print('called: ', uid1, uid2, current_user.id)
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

    return render_template("chat2.html", user=current_user, user_data=user_data, user2_data=user2_data, data=data,
                           ctype='ind')


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
    return render_template("chat2.html", user=current_user, user_data=user_data, data=data, ctype='gro')


@chat.route('/library/<uid1>/<uid2>', methods=['GET', 'POST'])
@login_required
def individuals_chat_library(uid1, uid2):
    print(uid1, uid2)
    user = db.session.query(User). \
        filter(User.id == uid1).first()

    user2 = db.session.query(User). \
        filter(User.id == uid2).first()

    user_data = user.user_variablesjs()
    user2_data = user2.user_variablesjs()

    files = db.session.query(Individuals_File_Association.file_name). \
        filter(
        (Individuals_File_Association.uid1 == uid2 and Individuals_File_Association.uid2 == uid1)).all()

    flip_files = db.session.query(Individuals_File_Association.file_name). \
        filter(
        (Individuals_File_Association.uid1 == uid1 and Individuals_File_Association.uid2 == uid2)).all()

    print(files, flip_files)

    for file in flip_files:
        files.append(file)

    print('all: ', files)

    curr_directory = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Files')
    if files:
        file_lst = []
        for file in files:
            file_lst.append({
                'name': file.file_name,
                'url': os.path.join(curr_directory, file.file_name)
            })

        return render_template("library2.html", user=current_user, files=file_lst, user1=user_data, user2=user2_data)

    return render_template("library2.html", user=current_user, files=None, user1=user_data, user2=user2_data)


@chat.route('/upload_file/<uid1>/<uid2>', methods=['POST'])
def upload_file(uid1, uid2):
    file = request.files['file']
    print('UPLOAD: ', file)
    if file.filename == '':
        flash('No selected file', category='error')
        return redirect(url_for('chat.individuals_chat_library', uid1=uid1, uid2=uid2))
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)

        curr_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Files')
        file.save(os.path.join(curr_dir, filename))

        if Individuals_File_Association.query.filter_by(uid1=uid1, uid2=uid2, file_name=filename).first() or \
                Individuals_File_Association.query.filter_by(uid1=uid2, uid2=uid1, file_name=filename).first():
            print('File with such name already exists!')
            flash('File with such name already exists!', category='error')
        else:
            new_file = Individuals_File_Association(uid1=uid1, uid2=uid2, file_name=filename)
            db.session.add(new_file)
            db.session.commit()
            flash('File added!', category='success')
    else:
        flash('File type not allowed!', category='error')
    return redirect(url_for('chat.individuals_chat_library', uid1=uid1, uid2=uid2))


@chat.route('/download/<file_name>')
def download_file(file_name):
    curr_directory = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Files')
    # Replace "/path/to/file.pdf" with the path to your file
    file_location = os.path.join(curr_directory, file_name)
    return send_file(file_location, as_attachment=True)


@chat.route('/delete_file', methods=['DELETE'])
def delete_file():
    file_name = request.json['filename']
    print('DELETE: ', file_name)
    curr_directory = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Files')
    # Replace "/path/to/file.pdf" with the path to your file
    file_path = os.path.join(curr_directory, file_name)

    if os.path.exists(file_path):
        os.remove(file_path)

        file = db.session.query(Individuals_File_Association). \
            filter(Individuals_File_Association.file_name == file_name).first()

        db.session.delete(file)
        db.session.commit()
        flash('File deleted!', category='success')
        return jsonify({'message': f'{file_name} has been deleted.'}), 200
    else:
        return jsonify({'error': f'{file_name} does not exist.'}), 404


##################GROUP LIBRARY################################


@chat.route('/library/groups/<gid>', methods=['GET', 'POST'])
@login_required
def group_chat_library(gid):
    group = db.session.query(Group). \
        filter(Group.id == gid).first()

    files = db.session.query(Group_File_Association). \
        filter(Group_File_Association.gid == gid).first()

    if files:
        files = db.session.query(Group_File_Association). \
            filter(Group_File_Association.gid == gid).all()

        curr_directory = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Files')

        file_lst = []
        for file in files:
            file_lst.append({
                'name': file.file_name,
                'url': os.path.join(curr_directory, file.file_name)
            })

        print(file_lst)
        return render_template("group_library2.html", user=current_user, files=file_lst, gid=gid, gname=group.name)

    return render_template("group_library2.html", user=current_user, files=None, gid=gid, gname=group.name)


@chat.route('/upload_file/<gid>', methods=['POST'])
def group_upload_file(gid):
    file = request.files['file']
    if file.filename == '':
        flash('No selected file', category='error')
        return redirect(url_for('chat.group_chat_library', gid=gid))
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)

        curr_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Files')
        file.save(os.path.join(curr_dir, filename))

        if Group_File_Association.query.filter_by(gid=gid, file_name=filename).first():
            print('File with such name already exists!')
            flash('File with such name already exists!', category='error')
        else:
            new_file = Group_File_Association(gid=gid, file_name=filename)
            db.session.add(new_file)
            db.session.commit()
            flash('File added!', category='success')
    else:
        flash('File type not allowed!', category='error')
    return redirect(url_for('chat.group_chat_library', gid=gid))


@chat.route('/group_delete_file', methods=['DELETE'])
def group_delete_file():
    file_name = request.json['filename']
    curr_directory = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Files')
    # Replace "/path/to/file.pdf" with the path to your file
    file_path = os.path.join(curr_directory, file_name)
    print('here')
    if os.path.exists(file_path):
        os.remove(file_path)

        file = db.session.query(Group_File_Association). \
            filter(Group_File_Association.file_name == file_name).first()

        db.session.delete(file)
        db.session.commit()
        flash('File deleted!', category='success')
        return jsonify({'message': f'{file_name} has been deleted.'}), 200
    else:
        return jsonify({'error': f'{file_name} does not exist.'}), 404


@chat.route('/unmatch/<uid1>/<uid2>', methods=['GET'])
@login_required
def individuals_unmatch(uid1, uid2):
    user = db.session.query(User). \
        filter(User.id == uid1).first()

    user2 = db.session.query(User). \
        filter(User.id == uid2).first()

    match = db.session.query(Match). \
        filter(Match.uid1 == uid1, Match.uid2 == uid2).first()

    match_reverse = db.session.query(Match). \
        filter(Match.uid1 == uid2, Match.uid2 == uid1).first()
    print('here')
    db.session.delete(match)
    db.session.delete(match_reverse)
    db.session.commit()

    return redirect(url_for('chat.chatters'))


@chat.route('/unmatch/groups/<uid1>/<gid>', methods=['POST'])
@login_required
def groups_unmatch(uid, gid):
    user = db.session.query(User). \
        filter(User.id == uid).first()

    group = db.session.query(Group). \
        filter(Group.id == gid).first()

    # remove from groupadmin
    groupadmin = db.session.query(GroupAdmin). \
        filter(GroupAdmin.gid == gid, GroupAdmin.uid == uid).first()

    if groupadmin:
        db.session.delete(groupadmin)

    ingroup = db.session.query(InGroup). \
        filter(InGroup.gid == gid, InGroup.uid == uid).first()

    db.session.delete(ingroup)
    db.session.commit()

    return redirect(url_for('chat.chatters'))


@chat.route('/settings/groups/<gid>', methods=['GET', 'POST'])
@login_required
def group_chat_settings(gid):
    group = db.session.query(Group). \
        filter(Group.id == gid).first()

    if request.method == 'POST':
        new_group_name = request.form.get('update_name')
        group.name = new_group_name
        db.session.commit()
        flash('Group name change successful!', category='success')

    return render_template("group_settings2.html", user=current_user, gid=gid, gname=group.name)


@chat.route('/group_delete_file/<gid>', methods=['DELETE'])
def group_name_change(gid):
    group = db.session.query(Group). \
        filter(Group.id == gid).first()
    new_group_name = request.form.get('update_name')
    group.name = new_group_name
    db.session.commit()
    flash('Group name change successful!', category='success')

    return jsonify({'message': f'Group name has been changed.'}), 200


@chat.route('/view_interests/<gid>', methods=['GET', 'POST'])
@login_required
def group_interests(gid):
    group = db.session.query(Group). \
        filter(Group.id == gid).first()

    interests = db.session.query(Interest.name).join(Group_Enlist). \
        filter(Group_Enlist.gid == gid, Interest.id == Group_Enlist.iid).all()

    all_interests = db.session.query(Interest.name).all()
    other_interests = []
    for interest in all_interests:
        if interest not in interests:
            other_interests.append(interest)

    return render_template('group_interests.html', user=current_user,
                           interests=interests, other_interests=other_interests, gid=gid, gname=group.name)


@chat.route('/add_interest/<gid>', methods=['GET', 'POST'])
def add_group_interest(gid):
    if request.method == 'POST':
        interest = request.form.get('dropdown')

        # query for interest id to create new Enlist object
        iid = db.session.query(Interest.id).filter(Interest.name == interest).first()[0]

        new_group_enlist = Group_Enlist(gid=gid, iid=iid)
        db.session.add(new_group_enlist)
        db.session.commit()

        flash('Interest added!', category='success')

    return redirect(url_for('chat.group_interests', gid=gid))


@chat.route('/delete_interest/<gid>', methods=['GET', 'POST'])
def delete_group_interest(gid):
    if request.method == 'POST':
        # remove the Enlist object holding the relationship between
        # current user and the selected Interest

        interest = request.form['delete_interest']
        iid = db.session.query(Interest.id).filter(Interest.name == interest).first()[0]
        group_enlist = db.session.query(Group_Enlist).filter(Group_Enlist.iid == iid, Group_Enlist.gid == gid).first()
        db.session.delete(group_enlist)
        db.session.commit()

        flash('Removed Interest!', category='success')

    return redirect(url_for('chat.group_interests', gid=gid))
