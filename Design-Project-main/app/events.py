from flask import request, render_template
from flask_login import current_user
from flask_socketio import emit, join_room

from .extensions import socketio

users = {}


@socketio.on('join')
def on_join(data):
    username = data['username']
    room = data['room']
    join_room(room)
    print('room:', room)
    users[username] = request.sid
    emit('joined', {'username': username, 'room': room}, room=room)

@socketio.on("new_message")
def handle_new_message(data):
    message = data['message']
    room = data['room']
    # print(f"New message: {message}")
    username = None
    for user in users:
        if users[user] == request.sid:
            username = user
    emit("chat", {"message": message, "username": username}, room=room)
