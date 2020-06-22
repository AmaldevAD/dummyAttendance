import 'package:attendance/home.dart';
import 'package:attendance/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './globals.dart' as globals;

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var responseBody;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance Manager"),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5),
                height: MediaQuery.of(context).size.width / 2.5,
                // child: Image.asset(
                //   "assets/images/TCRWA.png",
                // ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: width / 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 12,
                    right: MediaQuery.of(context).size.width / 12,
                    top: 6),
                child: TextField(
                  controller: email,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String email) {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',
                      labelStyle: TextStyle(
                        color: Colors.blue[900],
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 12,
                    right: MediaQuery.of(context).size.width / 12,
                    top: 16,
                    bottom: 20),
                child: TextField(
                  obscureText: true,
                  controller: password,
                  keyboardType: TextInputType.text,
                  onChanged: (String email) {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'password',
                      labelStyle: TextStyle(
                        color: Colors.blue[900],
                      )),
                ),
              ),
              InkWell(
                onTap: () async {
                  // print(response.asStream);
                  String url =
                      "https://sleepy-mesa-61751.herokuapp.com/api/users/login";
                  var response = await http.post(url, body: {
                    "email": "${email.text}",
                    "password": "${password.text}"
                  });

                  print(response.body);
                  responseBody=jsonDecode(response.body);
                  if (response.statusCode == 200) {
                    globals.token=responseBody["token"];
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            title: Text(
                              'Invalid details',
                              style: TextStyle(color: Color(0xff3a3a3a)),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                elevation: 5.0,
                                child: Text("ok"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 12),
                  height: MediaQuery.of(context).size.width / 7,
                  color: Colors.blue[400],
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 18),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ForgotPassord(),
                      //   ),
                      // );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: MediaQuery.of(context).size.width / 25),
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: 20, horizontal: width / 4),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Container(
                      child: Text(
                        " Signup",
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: MediaQuery.of(context).size.width / 25),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
