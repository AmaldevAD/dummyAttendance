import 'package:attendance/addStudent.dart';

import './globals.dart' as globals;
import 'package:flutter/material.dart';

class Students extends StatefulWidget {
  Students({Key key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Easy Attendance"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudent()))
              .whenComplete(() {
            build(context);
          });
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: globals.students.length,
          itemBuilder: (context, i) {
            bool isSwitched = true;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${i + 1} : ${globals.students[i]}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                        Switch(
                          value: globals.switchButton[i],
                          inactiveTrackColor: Colors.grey,
                          onChanged: (value) {
                            print(isSwitched);
                            setState(() {
                              globals.switchButton[i] = value;
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
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
