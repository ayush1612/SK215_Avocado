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
