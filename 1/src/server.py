from hashlib import sha256
from flask import Flask, request, abort, jsonify

app = Flask(__name__)

digests = {}

@app.route('/messages/<digest>', methods=['GET'])
def get_message(digest):
    if not digest in digests:
        abort(404)
    return jsonify({
        'message': digests[digest]
    })

@app.route('/messages', methods=['POST'])
def post_message():
    message = (request.get_json() or {}).get('message')
    if message is None:
        abort(400)

    digest = sha256(message.encode('utf-8')).hexdigest()
    digests[digest] = message
    return jsonify({
        'digest': digest
    }), 201
