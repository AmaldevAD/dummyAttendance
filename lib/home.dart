import 'package:attendance/addTeacher.dart';
import 'package:attendance/condonation.dart';
import 'package:attendance/login.dart';
import 'package:attendance/students.dart';
import 'package:flutter/material.dart';
import './globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var responseBody;
  bool loading = true;
  @override
  void initState() {
    print("HIiiii");
    print(globals.token);
    super.initState();
    getSubjects();
  }

  getSubjects() async {
    setState(() {
      loading = true;
    });
    String url = "https://sleepy-mesa-61751.herokuapp.com/api/class/";
    var response = await http.get(
      url,
      headers: {"Authorization": globals.token},
    );
    print(response.body);

    setState(() {
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        loading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Easy Attendance"),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left:15.0,top:28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                      (r) => false,
                    );
                  },
                    child: Text(
                  "LOGOUT",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
                Divider(),
                Container(
                  margin: EdgeInsets.only(top:10),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Condonation(),
                        ),
            
                      );
                    },
                      child: Text(
                    "CONDONATION",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTeacher()))
              .whenComplete(() {
            getSubjects();
          });
        },
        child: Icon(Icons.add),
      ),
      body: loading
          ? Container()
          : ListView.builder(
              itemCount: responseBody.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Students()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Subject :  ${responseBody[i]["subject"]}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Division : ${responseBody[i]["department"]} : ${responseBody[i]["division"]}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                        Text(
                          "Year: ${responseBody[i]["year"]}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                        Divider()
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
