import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class SwitchPage extends StatefulWidget {
  static const String id = 'switch_screen';

  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  final DBref = FirebaseDatabase.instance.reference();

  bool isSwitched;
  bool newVal;


  void LedOn() async {
    await DBref.child("Variable Servo")
        .update({'ValueS': 'TRUE'});
  }

  void LedOFF() async {
    await DBref.child("Variable Servo")
        .update({'ValueS': 'FALSE'});
  }

  void getStatus() async {
    String newValue = (await FirebaseDatabase.instance
            .reference()
            .child("Variable Servo/ValueS")
            .once())
        .value;
    print(isSwitched);
    print(newValue);
    setState(() {
      if (newValue == 'TRUE') {
        isSwitched = true;
      } else {
        isSwitched = false;
      }
    });
  }


  @override
  void initState() {
    getStatus(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Device Center'),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              FlatButton(
                  onPressed: () async {
                    await getStatus();
                  },
                  child: Text('TEST STATUS')),
              FlatButton(
                  onPressed: () {
                    LedOn();
                    print('ON');
                  },
                  child: Text('LED ON')),
              FlatButton(
                  onPressed: () {
                    LedOFF();
                    print('OFF');
                  },
                  child: Text('LED OFF')),
            ],
          )),
    );
  }
}