import 'package:attendance/home.dart';
import 'package:attendance/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTeacher extends StatefulWidget {
  AddTeacher({Key key}) : super(key: key);

  @override
  _AddTeacherState createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _departmentController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _divisionController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  addTeacher() async {
    String url = "https://sleepy-mesa-61751.herokuapp.com/api/class/";
    var response = await http.post(url, headers: {
      "Authorization": globals.token
    }, body: {
      "teacher": "${globals.id}",
      "department": "${_departmentController.text}",
      "year": "${_yearController.text}",
      "division": "${_divisionController.text}",
      "subject": "${_subjectController.text}"
    });
    print(response.body);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Easy Attendance"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  //restuarent name
                  TextFormField(
                    controller: _departmentController,
                    decoration: const InputDecoration(
                      labelText: 'Department',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return ' required';
                      } else {
                        _departmentController.text =
                            _departmentController.text.trim();
                        return null;
                      }
                    },
                  ),
                  //email
                  TextFormField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Year',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'required';
                      } else {
                        _yearController.text = _yearController.text.trim();
                        return null;
                      }
                    },
                  ),

                  TextFormField(
                    controller: _divisionController,
                    decoration: const InputDecoration(
                      labelText: 'division',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'required';
                      } else {
                        _divisionController.text =
                            _divisionController.text.trim();
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      labelText: 'subject',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'required';
                      } else {
                        _subjectController.text =
                            _subjectController.text.trim();
                        return null;
                      }
                    },
                  ),

                  //button
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width / 12, vertical: 20),
                      height: width / 7,
                      color: Colors.blue[400],
                      child: Center(
                        child: Text(
                          "submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 18),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        addTeacher();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
