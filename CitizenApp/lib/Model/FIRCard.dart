import 'package:citizen_app/Screens/viewFIR.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';


class FIRCard extends StatefulWidget {
  const FIRCard(
      {Key key,
        @required this.id,
        @required this.data,
        @required this.date,
        @required this.crime})
      : super(key: key);

  final String id;
  final DocumentSnapshot data;
  final String date;
  final String crime;
  @override
  _FIRCardState createState() => _FIRCardState();
}

class _FIRCardState extends State<FIRCard> {
  int currentStep = 0;
  bool ActiveState1 =  false;
  StepState state1 = StepState.indexed;
  bool ActiveState2 =  false;
  StepState state2 = StepState.indexed;

  Future<void> _showStatusDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('FIR Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) {
                    return Row(
                      children: <Widget>[
                        Container(
                          child: null,
                        ),
                        Container(
                          child: null,
                        ),
                      ],
                    );
                  },
                  steps: [
                    Step(
                        title: Text('Pending'),
                        content: Text('FIR sent successfully. Currently in pending state'),
                        state: state1,
                        isActive: ActiveState1
                    ),
                    Step(
                        title: Text('Approved'),
                        content: Text(
                            'FIR approved by the nearest police station. Action will be taken soon.'),
                        isActive: ActiveState2,
                        state: state2
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showContactDialog (BuildContext context) {
    return showDialog(context: context, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Officer Tripathi is available right now'),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => FIR(id: widget.id, data: widget.data)));
      },
      child: Card(
        color: kActiveCardColor,
        child: ListTile(
          leading: Image.asset('assets/img/FIRicon.png'),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${widget.id}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'Crime: ${widget.crime}',
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          subtitle: Text(
            'Filed on: ${widget.date}',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          trailing: PopupMenuButton(
            color: Color(0xFF282a3d),
            onSelected: (var value) {
              switch (value) {
                case 1:
                  setState(() {
                    if(widget.data['status'] == 'pending') {
                      currentStep = 0;
                      state1 = StepState.complete;
                      ActiveState1 = true;
                      ActiveState2 = false;
                      state2 = StepState.indexed;
                    } else if(widget.data['status'] == 'approved'){
                      currentStep = 1;
                      state1 = StepState.complete;
                      ActiveState1 = true;
                      ActiveState2 = true;
                      state2 = StepState.complete;
                    }
                  });
                  _showStatusDialog(context);
                  break;
                case 2:
                  _showContactDialog(context);
              }
            },
            icon: Icon(Icons.arrow_drop_down),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 1,
                child: Text('Status'),
              ),
              PopupMenuDivider(),
              PopupMenuItem(child: Text('Contact'),
                  value: 2)
            ],
          ),
        ),
      ),
    );
  }
}