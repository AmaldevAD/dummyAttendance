import 'package:attendance/home.dart';
import 'package:attendance/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  signin() async {
    String url = "https://sleepy-mesa-61751.herokuapp.com/api/users/register";
    var response = await http.post(url, body: {
      "name": "${_nameController.text}",
      "email": "${_emailController.text}",
      "password": "${_passwordController.text}"
    });

    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Name is required';
                      } else {
                        _nameController.text = _nameController.text.trim();
                        return null;
                      }
                    },
                  ),
                  //email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (String value) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Enter Valid Email';
                      } else {
                        _emailController.text =
                            _emailController.text.trim().toLowerCase();
                        return null;
                      }
                    },
                  ),

                  //phone
                  TextFormField(
                    maxLength: 10,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      counterText: "",
                      labelText: 'phone',
                    ),
                    validator: (String value) {
                      if (_phoneController.text.trim().length < 10) {
                        return 'Enter valid phone';
                      } else {
                        _phoneController.text = _phoneController.text.trim();
                        return null;
                      }
                    },
                  ),

                  //password
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'password',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Enter valid password';
                      } else {
                        _passwordController.text =
                            _passwordController.text.trim();
                        return null;
                      }
                    },
                  ),
                  //confirm password
                  TextFormField(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'confirm password',
                    ),
                    validator: (String value) {
                      if (value.trim() != _passwordController.text.trim()) {
                        return 'Password did not match ';
                      }
                      return null;
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
                          "Signup",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 18),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        signin();
                      }
                    },
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 20, horizontal: width / 4),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        child: Container(
                          child: Text(
                            " Login",
                            style: TextStyle(
                                color: Colors.blue[400],
                                fontSize:
                                    MediaQuery.of(context).size.width / 25),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
