from app import create_app, socketio

app = create_app()

socketio.run(app, allow_unsafe_werkzeug=True)
