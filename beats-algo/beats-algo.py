from flask import Flask, render_template, request, redirect, url_for
from flask_wtf import Form
from wtforms import TextField
import numpy as np
from flask import jsonify
import datetime
from datetime import date
import requests
import jsonify
import random
# from TravellingSalesman import travellingSalesmanProblem
random.seed(10)
# model = pickle.load(open('model.pkl', 'rb'))

app = Flask(__name__)
app.config['SECRET_KEY'] = 'our very hard to guess secretfir'

def forward(place):
    forward_url = "https://api.mapbox.com/geocoding/v5/mapbox.places/" + place + \
        ".json?access_token=pk.eyJ1IjoidWp3YWxrcGwiLCJhIjoiY2tkYTdvZG1kMGJlMjJybXpvaHJ0NDRieiJ9.mx5YB4-2ZKCXsLzOpC--og"
    r = requests.get(url=forward_url)
    data = r.json()
    return (data["features"][0])


def reverse(cor_long, cor_lat):
    URL_Reverse = "https://api.mapbox.com/geocoding/v5/mapbox.places/"+str(cor_long)+","+str(
        cor_lat)+".json?access_token=pk.eyJ1IjoidWp3YWxrcGwiLCJhIjoiY2tkYTdvZG1kMGJlMjJybXpvaHJ0NDRieiJ9.mx5YB4-2ZKCXsLzOpC--og"
    r = requests.get(url=URL_Reverse)
    data = r.json()
    return data["features"][0]["context"][0]["text"]


def path(from_lat, from_long, to_lat, to_long):
    URL_Route = "https://api.mapbox.com/directions/v5/mapbox/cycling/"+str(from_lat)+","+str(from_long)+";"+str(to_lat)+","+str(
        to_long)+"?geometries=geojson&access_token=pk.eyJ1IjoidWp3YWxrcGwiLCJhIjoiY2tkYTdvZG1kMGJlMjJybXpvaHJ0NDRieiJ9.mx5YB4-2ZKCXsLzOpC--og"
    r = requests.get(url=URL_Route)
    data = r.json()
    return data["routes"][0]


def priority(locality):
    dict = {"mathikere": 2, "malleswaram": 3, "yesvantpur": 2, "hebbal": 3, "peenya": 3,
            "sanjaynagar": 1, "MSR Nagar": 2, "Armane nagar": 1, "RMV stage 2": 2, "sadashiva nagar": 1}
    priority = dict.get(locality, random.randint(1, 2))
    return priority


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/results')
def results():
    return render_template('results.html')

# Simple form handling using raw HTML forms
@app.route('/coordinates', methods=['GET', 'POST'])
def sign_up():
    error = ""
    if request.method == 'POST':
        # Form being submitted; grab data from form.
        first_name = request.form['firstname']
        last_name = request.form['lastname']

        # Validate form data
        if len(first_name) == 0 or len(last_name) == 0:
            # Form data failed validation; try again
            error = "Please supply both first and last name"
        else:
            # Form data is valid; move along

            from_ = first_name
            to_ = last_name
            # from_ = "mathikere"
            # to_ = "malleshwaram"
            from_cor = forward(from_)
            from_cor_lat = from_cor["center"][0]
            from_cor_long = from_cor["center"][1]

            to_cor = forward(to_)
            to_cor_lat = to_cor["center"][0]
            to_cor_long = to_cor["center"][1]

            pat = path(from_cor_lat, from_cor_long, to_cor_lat, to_cor_long)
            distance = pat["distance"]*0.001
            print()
            print("From " + from_+" to " + to_)
            print()
            coordinates = pat["geometry"]["coordinates"]
            # print(coordinates)
            police_path = []
            police_set = set()
            police_set.add(from_)
            police_set.add(to_)
            priority_sum = 0

            print("Initial Distance = " + str(distance))

            print()
            print("Intermediate Place          Priority")
            print()
            for i in coordinates:
                locality = reverse(i[0], i[1])
                locality = locality.lower()
                if locality not in police_set:

                    print(locality.ljust(30, " ") + " " + str(priority(locality)))
                    priority_sum = priority_sum + priority(locality)
                    police_path.append([locality, priority(locality)])
                    police_set.add(locality)

            updated_distance = distance/priority_sum
            print()
            print("updated distance = "+str(updated_distance))
            print()
            return render_template('results.html', distance=distance, police_path=police_path, updated_distance=updated_distance)

    # Render the sign-up page
    return render_template('coordinates.html', message=error)

# Run the application
app.run(debug=True)
