
import os
from flask import Flask,request
from twilio.twiml.voice_response import VoiceResponse,Gather
from twilio.rest import Client

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello World"


@app.route("/answer", methods=['GET', 'POST'])
def answer_call():
    
    resp = VoiceResponse()
    print(resp)
    resp.say("OnDuty में आयुष उज्जवल और एवोकैडो की ओर से आपका स्वागत है", voice='Polly.Aditi',language="hi-IN")

    gather = Gather(num_digits=1, action='/gatherScheme')

    gather.say("प्रथम सूचना रिपोर्ट के बारे में जानने के लिए एक दबाएं.",voice='Polly.Aditi',language="hi-IN")
    gather.say("गैर आपत्ति प्रमाण पत्र के बारे में जानने के लिए, दो दबाएं.",voice='Polly.Aditi',language="hi-IN")
    gather.say("पुलिस स्टेशन के बारे में जानने के लिए, तीन दबाएं.",voice='Polly.Aditi',language="hi-IN")
    gather.say("साइबर बदमाशी के बारे में जानने के लिए चार दबाएं.",voice='Polly.Aditi',language="hi-IN")
    gather.say("इंटरनेट घोटाला के बारे में जानने के लिए पांच दबाएं.",voice='Polly.Aditi',language="hi-IN")

    resp.append(gather)

    resp.redirect('/voice')

    return str(resp)

