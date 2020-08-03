
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


@app.route('/gatherScheme', methods=['GET', 'POST'])
def gatherScheme():

    resp = VoiceResponse()

    if 'Digits' in request.values:
        # print(request.values)
        choice = request.values['Digits']

        if choice == '1':
            resp.say('प्रथम सूचना रिपोर्ट को चुनने के लिए धन्यवाद',voice='Polly.Aditi',language="hi-IN")
            url = '/gatherStatus/'+choice
            gather = Gather(num_digits=1, action=url)

            gather.say("एक प्रथम सूचना रिपोर्ट (एफआईआर) पुलिस संगठनों द्वारा तैयार किया गया एक दस्तावेज है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("आम तौर पर संज्ञेय अपराध के पीड़ित द्वारा या उसकी ओर से किसी के द्वारा पुलिस में दर्ज कराई गई शिकायत से उपजा है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("ये गंभीर आपराधिक अपराध हैं जो हत्या, बलात्कार या डकैती जैसे समाज के लिए तत्काल खतरा बनते हैं.",voice='Polly.Aditi',language="hi-IN")
            gather.say("थाने में एफआईआर दर्ज होने के बाद ही पुलिस अधिकांश प्रकार के मामलों की जांच करती है.",voice='Polly.Aditi',language="hi-IN")
            resp.append(gather)

        elif choice == '2':
            resp.say('गैर आपत्ति प्रमाण पत्र को चुनने के लिए धन्यवाद',voice='Polly.Aditi',language="hi-IN")
            url = '/gatherStatus/'+choice
            gather = Gather(num_digits=1, action=url)
            
            gather.say("सभी भारतीय नागरिक, जो नेपाल में रह रहे हैं या काम कर रहे हैं, उन्हें नेपाल से पहली बार किसी तीसरे देश के लिए उड़ान भरने से पहले एनओसी की आवश्यकता है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("आवेदक व्यक्तिगत रूप से मूल पासपोर्ट, मूल भारतीय पंजीकरण प्रमाण पत्र के साथ दूतावास में आना चाहिए, उसी की ज़ेरॉक्स प्रतियां",voice='Polly.Aditi',language="hi-IN")
            gather.say("टिकट की कॉपी और वैध वीजा.",voice='Polly.Aditi',language="hi-IN")
            gather.say("दो पासपोर्ट साइज फोटो.",voice='Polly.Aditi',language="hi-IN")
            gather.say("दाखिल करते समय हजार रुपये वसूले जाते हैं.",voice='Polly.Aditi',language="hi-IN")
            
            resp.append(gather)

        elif choice == '3':
            resp.say('पुलिस स्टेशन को चुनने के लिए धन्यवाद',voice='Polly.Aditi',language="hi-IN")
            url = '/gatherStatus/'+choice
            gather = Gather(num_digits=1, action=url)
            
            gather.say("भागलपुर क्षेत्र में चार पुलिस स्टेशन हैं.",voice='Polly.Aditi',language="hi-IN")
            gather.say("उनमें से एक एस पी रोड के पास तिलका मांझी में स्थित है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("दूसरा महात्मा गांधी रोड पर है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("तीसरा बरारी में काली मंदिर के पास है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("चौथा इंडियन पब्लिक स्कूल के पास है.",voice='Polly.Aditi',language="hi-IN")
            
            resp.append(gather)

        elif choice == '4':
            resp.say('साइबर बदमाशी को चुनने के लिए धन्यवाद',voice='Polly.Aditi',language="hi-IN")
            url = '/gatherStatus/'+choice
            gather = Gather(num_digits=1, action=url)
            
            gather.say("साइबरबुलिंग या साइबरहैसमेंट इलेक्ट्रॉनिक माध्यमों का उपयोग करके धमकाने या उत्पीड़न का एक रूप है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("यह तेजी से आम हो गया है, खासकर किशोरों में, क्योंकि डिजिटल क्षेत्र का विस्तार हुआ है और प्रौद्योगिकी उन्नत हुई है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("बार-बार व्यवहार और उत्पीड़न की पहचान बार-बार किए गए व्यवहार और नुकसान पहुंचाने के इरादे से की जा सकती है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("ऐसे मामलों में पीड़ित को साइबर विभाग से संपर्क करना चाहिए.",voice='Polly.Aditi',language="hi-IN")
            
            resp.append(gather)

        elif choice == '5':
            resp.say('इंटरनेट घोटाला को चुनने के लिए धन्यवाद',voice='Polly.Aditi',language="hi-IN")
            url = '/gatherStatus/'+choice
            gather = Gather(num_digits=1, action=url)
            
            gather.say("इंटरनेट फ्रॉड एक प्रकार का साइबर क्राइम फ्रॉड या धोखे है जो इंटरनेट का उपयोग करता है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("इसमें धन, संपत्ति और विरासत से पीड़ितों को बरगलाने के उद्देश्य से जानकारी छिपाना या गलत जानकारी देना शामिल हो सकता है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("नर्नेट धोखाधड़ी को एक एकल, विशिष्ट अपराध नहीं माना जाता है, लेकिन साइबरस्पेस में किए गए कई अवैध और अवैध कार्यों को शामिल किया गया है.",voice='Polly.Aditi',language="hi-IN")
            gather.say("ऐसे मामलों में पुलिस को तुरंत सूचित किया जाना चाहिए.",voice='Polly.Aditi',language="hi-IN")
            
            resp.append(gather)

        else:
            # If the caller didn't choose 1 or 2, apologize and ask them again
            resp.say("Sorry, I don't understand that choice.")
    resp.say("आयुष, अमन, कृतिका, इशांक, उज्ज्वल, ऋषभ और एवोकैडो की ओर से संपर्क करने के लिए धन्यवाद",voice='Polly.Aditi',language="hi-IN")
    # return str(resp)
    return str(resp)


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port, debug = True)
