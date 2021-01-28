import 'package:cat/screen/my_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: camel_case_types
class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

// ignore: camel_case_types
class _registerState extends State<register> {
  final formkey = GlobalKey<FormState>();
  String usernameString, emailString, passwordString;

  Widget registerButtom() {
    return RaisedButton(
      color: Colors.pink,
      child: Text(
        'Sign up',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('you click upload');
        if (formkey.currentState.validate()) {
          formkey.currentState.save();
          print(
              'name = $usernameString, email = $emailString, password = $passwordString');
          registerThead();
        }
      },
    );
  }

  Future<void> registerThead() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Succes for email = $emailString');
      setupDisplayname();
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      print('title = $title, message = $message');
      myAert(title, message);
    });
  }

  Future<void> setupDisplayname() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.currentUser().then((response) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = usernameString;
      response.updateProfile(userUpdateInfo);

      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  void myAert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.grey,
                size: 48.0,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.pink),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  Widget username() {
    return TextFormField(
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          color: Colors.grey,
          size: 30.0,
        ),
        labelText: 'Display Name :',
        labelStyle: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 30.0),
        helperText: 'Type Your Nickname for Display',
        helperStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Your Name in the Blank';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        usernameString = value.trim();
      },
    );
  }

  Widget email() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.grey,
          size: 30.0,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 30.0),
        helperText: 'Type Your Email',
        helperStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please Type Email in Exp. you@email.com';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget password() {
    return TextFormField(
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          color: Colors.grey,
          size: 30.0,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 30.0),
        helperText: 'Type Your pasword',
        helperStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Password More 6 Charactor';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Register'),
        actions: <Widget>[registerButtom()],
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            SizedBox(
              height: 35.0,
            ),
            username(),
            SizedBox(
              height: 25.0,
            ),
            email(),
            SizedBox(
              height: 25.0,
            ),
            password(),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
