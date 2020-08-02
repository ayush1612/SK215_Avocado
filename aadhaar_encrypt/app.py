from flask import Flask, render_template, Response, request
from Engine import card as cardX, user as userX
import json
from flask_cors import CORS
import base64
import argparse

app = Flask(__name__)
CORS(app)


@app.errorhandler(404)
def page_not_found(e):
    return Response("{\"Error\" : \"404 Page Not Found.\"}", mimetype="application/json")


@app.route("/generate-token", methods=["POST", "GET"])
def generate_token():
    if request.method == "GET":
        return Response("{"Error": "Post data not sent"}", mimetype="application/json")
    elif request.method == "POST":
        data = request.data
        data = data.decode("utf-8")
        details = {
            "name": data[0],
            "email": data[1]
        }
        user = userX.User(details)
        resp = {
            "key": user.generate_key
        }
        return Response(json.dumps(resp), mimetype="application.json")
    else:
        return Response("{\"Error\":\"Request not allowed\"}", mimetype="application/json")


@app.route('/encrypt-data', methods=["POST", "GET"])
def encrypt_data():
    if request.method == "GET":
        return Response('{"Error" : "Post Data Not Sent"}', mimetype="application/json")
    elif request.method == "POST":
        data = request.data
        data = data.decode('utf-8')
        data = json.loads(data)
        key = data["key"]
        print("This is key:"+key)
        details = {
            "aadhaarno": data["aadhaarno"],
            "name": data["name"],
            "dob": data["dob"],
            "address": data["address"]
        }
        card = cardX.Card(key.encode('utf-8'), str(details))

        resp = {"encrypted_text": card.encrypt_data}
        return Response(json.dumps(resp), mimetype="application/json")
    else:
        return Response("{\"Error\" : \"Request Not Allowed\"}", mimetype="application/json")


@app.route('/decrypt-data', methods=["POST", "GET"])
def decrypt_data():
    if request.method == "GET":
        return Response('{"Error" : "Post Data Not Sent"}', mimetype="application/json")
    elif request.method == "POST":
        data = request.data
        data = data.decode('utf-8')
        data = json.loads(data)
        key = data["key"]
        card = cardX.Card(key.encode("utf-8"))
        resp = {"decrypted_text": card.decrypt_data(data["data"])}
        return Response(json.dumps(resp), mimetype="application/json")
    else:
        return Response("{\"Error\" : \"Request Not Allowed\"}", mimetype="application/json")


app.run(debug=True)
