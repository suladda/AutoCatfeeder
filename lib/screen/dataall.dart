import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cat/alldata/dataallmodel.dart';
import 'dart:async';

class Dataall extends StatefulWidget {
  @override
  _DataallState createState() => _DataallState();
}

class _DataallState extends State<Dataall> {
  DataallModelFromJson _dataallModeljson;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://autofeed-9f7ab.firebaseio.com/.json"),
        headers: {"Accept": "application/json"});
    //debugPrint(response.body);
    print(response.body);
    setState(() {
      _dataallModeljson = dataallModelFromJsonFromJson(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.pinkAccent,
        title: new Text('Show Realtime Database'),
      ),
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
              colors: [Colors.white, Colors.pink[50]],
              radius: 1.0,
            )),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.check_box),
                  title: Text(
                    'Status Auto Feeder',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${_dataallModeljson?.variableFeederF.value ?? "..."} ',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.pink,
                ),
                ListTile(
                  leading: Icon(Icons.check_box),
                  title: Text('Status Servo',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    '${_dataallModeljson?.variableServo.valueS ?? "..."}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Divider(
                  color: Colors.pink,
                ),
                ListTile(
                  leading: Icon(Icons.check_box),
                  title: Text('Space of Food',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    '${_dataallModeljson?.variableUltrasonic.cm ?? "..."}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Divider(
                  color: Colors.pink,
                ),
              ],
            )),
      ),
    );
  }
}
