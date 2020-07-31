const functions = require('firebase-functions');
const cors = require('cors')({ origin: true});
const admin = require('firebase-admin');
const serviceAccount = require('./service.json');

// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
//   databaseURL: "https://fireship-lessons.firebaseio.com"
// });
// admin.initializeApp();
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://policeapp-ec7d4.firebaseio.com"
});

const { SessionsClient } = require('dialogflow');

const { WebhookClient } = require('dialogflow-fulfillment');

exports.dialogflowWebhook = functions.https.onRequest(async (request, response) => {
    const agent = new WebhookClient({ request, response });

    console.log(JSON.stringify(request.body));

    const result = request.body.queryResult;
   
    function welcome(agent) {
      agent.add(`Welcome to my agent!`);
    }
   
    function fallback(agent) {
      agent.add(`Sorry, can you try again?`);
    }

    async function FIR(agent) {

        
        const { crime, place, name, age, evidence, identity, aadhar, phone, desc } = result.parameters;
        const db  = admin.firestore();
        const unitFIR = db.collection('FIR');
    //  print(name + age + phone+evidence + identity);
    //  const unitFIR = coll.child('FIR');

      await unitFIR.add({ event:crime,date: Date.now(), email:'test@gmail.com',status:'pending',place: place,name: name,age: age,witness: evidence,identification: identity, aadhar,phone: phone, desc , signature:'idxvtn'})
      agent.add(`Thanks for the information. We have already submitted your request in the nearest police station.`);
    }

    
    let intentMap = new Map();
    intentMap.set('Default Welcome Intent', welcome);
    intentMap.set('Default Fallback Intent', fallback);
    intentMap.set('FIR', FIR);
    agent.handleRequest(intentMap);
});