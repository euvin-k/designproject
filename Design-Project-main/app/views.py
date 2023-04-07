from flask import Blueprint, render_template, request, flash, jsonify, url_for, redirect
from flask_login import login_required, current_user
from .models import *
from . import db
import json
import random

views = Blueprint('views', __name__)
global random_user


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


@views.route('/delete_interest', methods=['GET','POST'])
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

    '''interest = json.loads(request.data)  # this function expects a JSON from the INDEX.js file
    interestId = interest['interestId']
    note = Interest.query.get(interestId)
    if note:
        if note.user_id == current_user.id:
            db.session.delete(note)
            db.session.commit()

    return jsonify({})'''


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

# @views.route('/view_reqs', methods=['GET','POST'])
# def view_requests():
#   to view requests based on updates in match table,
#   query for users where there is no two-way rows in the
#   match table
#
#   so, all users that requested a match with current_user
#   but current_user hasn't requested a match with them
#   so, if Match.uid1 == random_user, Match.uid2 == current_user
#   and Match.uid1 != current_user, Match.uid2 != random_user