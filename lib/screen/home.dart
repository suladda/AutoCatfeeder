import 'package:cat/screen/Authen.dart';
import 'package:cat/screen/my_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'register.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Widget name() {
    return Text(
      'Auto Feeder',
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.pink,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'PermanentMarker',
      ),
    );
  }

  Widget signin() {
    return RaisedButton(
      color: Colors.pink,
      child: Text(
        'sign in',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Authen());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget signup() {
    return OutlineButton(
      color: Colors.grey,
      child: Text('sign up'),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget bottom() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signin(),
        SizedBox(
          width: 6.0,
        ),
        signup()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
            colors: [Colors.white, Colors.pink],
            radius: 1.0,
          )),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                name(),
                SizedBox(
                  height: 10.0,
                ),
                bottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
