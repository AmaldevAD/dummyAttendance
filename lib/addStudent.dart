import 'package:attendance/students.dart';
import 'package:flutter/material.dart';
import './globals.dart' as globals;

class AddStudent extends StatefulWidget {
  AddStudent({Key key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  String name;
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return Scaffold(
       appBar: AppBar(
        title: Text("Easy Attendance"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(

                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) {
                  setState(() {
                    name=value;
                  });
                },
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Roll No.',
                ),
                onChanged: (value) {},
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'required';
                  } else {
                    return null;
                  }
                },
              ),
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
                  setState(() {
                     globals.students.add(name);
                  globals.switchButton.add(false);
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Students()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
