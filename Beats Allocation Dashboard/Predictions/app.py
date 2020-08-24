import numpy as np
from flask import Flask,request,jsonify,render_template
import pickle
import datetime
from datetime import date


model = pickle.load(open('model.pkl', 'rb'))

app = Flask(__name__)

@app.route('/')
def home():
	return "hello"

@app.route('/predict',methods=['GET'])
def predict():
	result = model.predict([[2,4,10,1.0,32.0	]])
	mon = request.args.get("month")
	day = request.args.get("day")
	hour = request.args.get("hour")
	dis = request.args.get("district")
	comm_id = request.args.get("commu")
	result = model.predict([[mon,day,hour,dis,comm_id]])
	return str(result[0])







if __name__ == "__main__":
    app.run(debug=True)