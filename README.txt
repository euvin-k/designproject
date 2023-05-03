Instructions for starting UnaDoctrina:

1. Load up pgadmin 4
2. Create a new database called “unadoctrina”
3. Open the project code (in PyCharm)
5. Execute run.py
  -> If an error regarding "allow_unsafe_werkzeug=True" occurs,
     change the code in run.py from:
        socketio.run(app, allow_unsafe_werkzeug=True)
        to
        socketio.run(app)
  -> For one of the members, the extra argument was needed in order to run
  -> For another member, the extra argument would cause an error
6. If terminal does not provide the link, type in browser:   http://127.0.0.1:5000/
