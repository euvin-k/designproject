import os

from flask import Blueprint, render_template, request, flash, jsonify, url_for, redirect
from flask_login import login_required, current_user
from .models import *
from . import db, ALLOWED_EXTENSIONS

import json
import random
from werkzeug.utils import secure_filename

views = Blueprint('views', __name__)
global random_user
global random_group
global random_req


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


@views.route('/view_interests')
@login_required
def view_interests():
    # fetch current_user's interests and send them to html file
    my_interests = db.session.query(Interest.name).join(Enlist). \
        filter(Enlist.uid == current_user.id, Interest.id == Enlist.iid).all()

    # fetch list of all other available interests not enlisted by current_user
    all_interests = db.session.query(Interest.name).all()
    other_interests = []
    for interest in all_interests:
        if interest not in my_interests:
            other_interests.append(interest)

    return render_template('interests.html', user=current_user,
                           my_interests=my_interests, other_interests=other_interests)


@views.route('/add_interest', methods=['GET', 'POST'])
def add_interest():
    if request.method == 'POST':
        interest = request.form.get('dropdown')

        # query for interest id to create new Enlist object
        iid = db.session.query(Interest.id).filter(Interest.name == interest).first()[0]

        new_enlist = Enlist(uid=current_user.id, iid=iid)
        db.session.add(new_enlist)
        db.session.commit()

        flash('Interest added!', category='success')

    return redirect(url_for('views.view_interests'))


@views.route('/delete_interest', methods=['GET', 'POST'])
def delete_interest():
    if request.method == 'POST':
        # remove the Enlist object holding the relationship between
        # current user and the selected Interest

        interest = request.form['delete_interest']
        iid = db.session.query(Interest.id).filter(Interest.name == interest).first()[0]
        enlist = db.session.query(Enlist).filter(Enlist.iid == iid, Enlist.uid == current_user.id).first()
        db.session.delete(enlist)
        db.session.commit()

        flash('Removed Interest!')

    return redirect(url_for('views.view_interests'))


@views.route('/create_interest', methods=['GET', 'POST'])
def create_interest():
    if request.method == 'POST':
        new_interest = request.form.get('new_interest')

        # check if new_interest already exists in database
        # if so, deny user's request to create it

        check = db.session.query(Interest).filter(Interest.name == new_interest).first()
        if check:
            flash('Cannot add an existing Interest!', category='error')
        else:
            # create the new interest and enlist current_user to it
            interest = Interest(name=new_interest)
            db.session.add(interest)
            db.session.commit()

            enlist = Enlist(uid=current_user.id, iid=interest.id)
            db.session.add(enlist)
            db.session.commit()

            flash('New Interest Created!')

    return redirect(url_for('views.view_interests'))


@views.route('/discovery')
@login_required
def discovery():
    rows = User.query.all()
    random_row = random.choice(rows)

    # validate the randomly chosen user to show the current user
    valid = False
    while (not valid) and rows:
        # check if random user is the current user
        # if so, try again
        if random_row.id == current_user.id:
            rows.remove(random_row)
            if rows:
                random_row = random.choice(rows)
            continue

        # check if current_user already match requested random_user
        # if so, try again
        check_match_id = db.session.query(Match). \
            filter(Match.uid1 == current_user.id,
                   Match.uid2 == random_row.id).first()
        if check_match_id:
            rows.remove(random_row)
            if rows:
                random_row = random.choice(rows)
            continue
        # check if current_user already rejected random_user
        # if so, try again
        check_reject_id = db.session.query(Reject). \
            filter(Reject.uid1 == current_user.id,
                   Reject.uid2 == random_row.id).first()
        if check_reject_id:
            rows.remove(random_row)
            if rows:
                random_row = random.choice(rows)
            continue

        # check if random_user already rejected current_user
        # if so, try again
        check_rejected_id = db.session.query(Reject). \
            filter(Reject.uid2 == current_user.id,
                   Reject.uid1 == random_row.id).first()
        if check_rejected_id:
            rows.remove(random_row)
            if rows:
                random_row = random.choice(rows)
            continue

        # by this point, the random user is valid. exit loop
        valid = True

    if rows:
        msg = None

        global random_user
        random_user = random_row

        # grab all interests
        interest_list = db.session.query(Interest.name).join(Enlist). \
            filter(Enlist.uid == random_row.id, Interest.id == Enlist.iid).all()

        random_user_details = {
            'First Name': random_row.first_name,
            'Last Name': random_row.last_name,
            'About': random_row.desc
        }

        return render_template("discovery.html", user=current_user, random_user_details=random_user_details,
                               interest_list=interest_list, msg=msg)
    else:
        msg = "There are no users left to see"
        return render_template("nulldiscovery.html", user=current_user, msg=msg)


@views.route('/group_discovery')
def group_discovery():
    rows = Group.query.all()
    if rows:
        random_row = random.choice(rows)

        valid = False
        while (not valid) and rows:

            # check if user is already part of the group
            # if so, skip it

            has_membership = db.session.query(InGroup). \
                filter(InGroup.uid == current_user.id, InGroup.gid == random_row.id).first()
            if has_membership:
                rows.remove(random_row)
                if rows:
                    random_row = random.choice(rows)
                continue

            # check if user already requested to join the group
            # if so, skip it

            requested_group = db.session.query(JoinRequest).filter(JoinRequest.uid == current_user.id,
                                                                   JoinRequest.gid == random_row.id).first()
            if requested_group:
                rows.remove(random_row)
                if rows:
                    random_row = random.choice(rows)
                continue

            # check if user already rejected the group
            # if so, skip it

            rejected_group = db.session.query(RejectGroup).filter(RejectGroup.uid == current_user.id,
                                                                  RejectGroup.gid == random_row.id).first()
            if rejected_group:
                rows.remove(random_row)
                if rows:
                    random_row = random.choice(rows)
                continue

            valid = True

        if not rows:
            msg = "There are no groups left to see"
            return render_template("group_discovery.html", user=current_user, msg=msg, random_group_details={})

        global random_group
        random_group = random_row

        random_group_details = {
            'Name': random_group.name
        }
        msg = None

        return render_template("group_discovery.html", user=current_user, msg=msg,
                               random_group_details=random_group_details)


@views.route('/match', methods=["GET", "POST"])
def match():
    # match is successful if both users have matched each other
    # if a user matches another user that has not matched back (yet),
    #    then user will just have to wait
    # the user that receives the match request can choose to match or not
    #   > probably have a match request list

    if request.method == 'POST':
        match_req = Match(uid1=current_user.id, uid2=random_user.id)
        db.session.add(match_req)
        db.session.commit()

        # check if random_user has already sent a match request
        #   if so, the current_user and random_user will officially match
        # note: don't need to check if random_user has rejected you
        #   since they won't show up in discovery in the first place

        check_existing_req = db.session.query(Match). \
            filter(Match.uid2 == current_user.id,
                   Match.uid1 == random_user.id).first()

        # if random_user already sent match req, flash message for successful matching
        if check_existing_req:
            flash('Match Successful!')
        else:
            flash('Sent a match request!')

    return redirect(url_for('views.discovery'))


@views.route('/join_request', methods=["GET", "POST"])
def join_request():
    if request.method == 'POST':
        join_req = JoinRequest(gid=random_group.id, uid=current_user.id)
        db.session.add(join_req)
        db.session.commit()

        flash('Sent a join request!')

    return redirect(url_for('views.group_discovery'))


@views.route('/reject', methods=["GET", "POST"])
def reject():
    if request.method == 'POST':
        new_reject_1 = Reject(uid1=current_user.id, uid2=random_user.id)
        new_reject_2 = Reject(uid1=random_user.id, uid2=current_user.id)
        db.session.add(new_reject_1)
        db.session.add(new_reject_2)

        # if random_user happened to request a match, remove
        # the row from match table so that the request doesn't
        # show in the current_user's request list anymore

        check_existing_req = db.session.query(Match). \
            filter(Match.uid2 == current_user.id,
                   Match.uid1 == random_user.id).first()
        if check_existing_req:
            db.session.delete(check_existing_req)

        db.session.commit()

        flash('User has been hidden from your discovery.')

    return redirect(url_for('views.discovery'))


@views.route('/reject_group', methods=["GET", "POST"])
def reject_group():
    if request.method == 'POST':
        rejection = RejectGroup(gid=random_group.id, uid=current_user.id)
        db.session.add(rejection)

        check_existing_req = db.session.query(JoinRequest).filter(JoinRequest.gid == random_group.id,
                                                                  JoinRequest.uid == current_user.id).first()
        if check_existing_req:
            db.session.delete(check_existing_req)

        db.session.commit()

        flash('Group has been hidden from your discovery.')

    return redirect(url_for('views.group_discovery'))


@views.route('/view_join_reqs')
def view_join_reqs():
    # first check if current_user is an admin for any groups
    if db.session.query(GroupAdmin).filter(GroupAdmin.uid == current_user.id).first():

        # query for all users that requested to join any of the servers that current_user is an admin for
        # display to the current_user one at a time by random

        # query for all groups that current_user is an admin for
        admin_for = db.session.query(GroupAdmin).filter(GroupAdmin.uid == current_user.id).all()

        # grab all join requests to any of these groups
        reqs = []
        for group in admin_for:
            extract = db.session.query(JoinRequest).filter(JoinRequest.gid == group.gid).all()
            reqs.extend(extract)

        # reqs = db.session.query(JoinRequest).filter(JoinRequest.gid == admin_for.gid).all()

        if reqs:

            # grab random request
            global random_req
            random_req = random.choice(reqs)
            random_uid = random_req.uid
            random_gid = random_req.gid

            # grab profile info about randomly selected user
            user = db.session.query(User).filter(User.id == random_uid).first()
            user_details = {
                'First Name': user.first_name,
                'Last Name': user.last_name,
                'About': user.desc
            }

            # grab interest list of randomly selected user
            user_interests = db.session.query(Interest.name).filter(Interest.id == user.id).all()

            # grab group name
            group = db.session.query(Group.name).filter(Group.id == random_gid).first()

            return render_template('my_group_reqs.html', user=current_user, user_details=user_details,
                                   user_interests=user_interests, group=group, admin_for=admin_for)
        else:
            msg = "You have no join requests at the moment."
            return render_template('null.html', user=current_user, msg=msg)
    else:
        msg = "You are not an admin for any servers."
        return render_template('null.html', user=current_user, msg=msg)


@views.route('/accept_req', methods=["GET", "POST"])
def accept_req():
    if request.method == 'POST':
        # create new entry in InGroup table
        new_member = InGroup(gid=random_req.gid, uid=random_req.uid)
        db.session.add(new_member)

        # remove entry from JoinRequest table
        req = db.session.query(JoinRequest).filter(JoinRequest.gid == random_req.gid,
                                                   JoinRequest.uid == random_req.uid).first()
        db.session.delete(req)
        db.session.commit()

        flash('Request Accepted!')

    return redirect(url_for('views.view_join_reqs'))


@views.route('/decline_req', methods=["GET", "POST"])
def decline_req():
    # when declining a request, add an entry to RejectGroup (user that requested a join won't see it again in discovery)
    if request.method == 'POST':
        # create new entry in RejectGroup table
        new_reject = RejectGroup(gid=random_req.gid, uid=random_req.uid)
        db.session.add(new_reject)

        # remove entry from JoinRequest table
        req = db.session.query(JoinRequest).filter(JoinRequest.gid == random_req.gid,
                                                   JoinRequest.uid == random_req.uid).first()
        db.session.delete(req)
        db.session.commit()

        flash('Request Declined!')

    return redirect(url_for('views.view_join_reqs'))


@views.route('/search_group', methods=["GET", "POST"])
def search_group():
    if request.method == 'POST':
        search = request.form.get('search')

        if search.isnumeric():
            group_id = search

            check_existing_group = db.session.query(Group). \
                filter(Group.id == group_id).first()
        else:
            group_name = search
            check_existing_group = db.session.query(Group). \
                filter(Group.name == group_name).first()

        if check_existing_group:
            flash(f"Request to join the group{group_id} has been made!", category="success")
            pass
        else:
            flash("Group is either private or does not exist!", category="error")

    return redirect(url_for('views.discovery'))
    # return render_template("search_group.html", group_id=group_id)


def allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@views.route('/upload_file', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(url_for('views.home'))
        file = request.files['file']
        # If the user does not select a file, the browser submits an
        # empty file without a filename.
        if file.filename == '':
            flash('No selected file')
            return redirect(url_for('views.home'))
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)

            curr_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Files')
            file.save(os.path.join(curr_dir, filename))
    return render_template("upload_file.html", user=current_user)


@views.route('/group_creation', methods=['GET', 'POST'])
def group_creation():
    if request.method == 'POST':
        group_name = request.form.get('group_name')

        # new group added to Group
        new_group = Group(name=group_name)
        db.session.add(new_group)
        db.session.commit()

        # add user and group to InGroup
        group = Group.query.filter_by(name=group_name).first()
        new_ingroup = InGroup(gid=group.id, uid=current_user.id)
        db.session.add(new_ingroup)
        db.session.commit()

        new_groupadmin = GroupAdmin(gid=group.id, uid=current_user.id)
        db.session.add(new_groupadmin)
        db.session.commit()

        flash('Group Created!')

        return redirect(url_for('views.home'))

    return render_template("group_creation.html", user=current_user)
