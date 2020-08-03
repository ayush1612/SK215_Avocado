import numpy as np
from flask import Flask, request, jsonify, render_template

import datetime
from datetime import date
import requests
import jsonify
import random
from TravellingSalesman import travellingSalesmanProblem
random.seed(10)
# model = pickle.load(open('model.pkl', 'rb'))

app = Flask(__name__)


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
def home():
    return "hello"


@app.route('/predict', methods=['GET'])
def finddistance():
    from_ = request.args.get("from")
    to_ = request.args.get("to")
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

    # URL = "https://api.mapbox.com/directions-matrix/v1/mapbox/driving/77.55623,13.03328;77.55597,13.04159;77.57162,13.04853?access_token=pk.eyJ1IjoidWp3YWxrcGwiLCJhIjoiY2tkYTdvZG1kMGJlMjJybXpvaHJ0NDRieiJ9.mx5YB4-2ZKCXsLzOpC--og"
    return render_template("index.html", message="Hello Flask!", distance=distance, police_path=police_path, updated_distance=updated_distance)
    # return {"distance": distance, "police_path": police_path, "updated distace": updated_distance}


# @app.route('/predict',methods=['GET'])
# def predict():
#     first = "mathikere"
#     second = "malleswaram"
#     third = "hebbal"
#     places = [first,second,third]
#     distance = [[0 for i in range(3)] for j in range(3)]
#     for i in range(0,3):
#         for j in range(0,3):
#             if distance[j][i]!=0:
#                 distance[i][j] = distance[j][i]
#             else:
#                 distance[i][j] = finddistance(places[i],places[j])
#     TravellingSalesMan(distance)


if __name__ == "__main__":
    app.run(debug=True)
