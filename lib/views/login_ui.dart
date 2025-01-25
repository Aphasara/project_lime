// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lime_app/views/register_ui.dart';
import 'package:lime_app/views/subviews/home_lime_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {

  //สร้างตัวแปรช่องรหัสผ่าน
  bool pwdStatus = true;
  bool openpwd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlueAccent,
              Colors.lightGreenAccent,
              Colors.redAccent,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                'Welcome!',
                style: GoogleFonts.kanit(
                  fontSize: MediaQuery.of(context).size.height * 0.05,
                  color: Colors.green[900],
                ),
              ),
              Text(
                'Lime Grading',
                style: GoogleFonts.kanit(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo2.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.green[900],
                      ),
                      hintText: 'Username',
                      hoverColor: Colors.green[900],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              TextField(
                obscureText: openpwd,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.fingerprint,
                    color: Colors.green[900],
                  ),
                  hintText: 'Password',
                  hoverColor: Colors.green[900],
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        pwdStatus = !pwdStatus;
                        openpwd = !openpwd;
                      });
                    },
                    icon: Icon(pwdStatus == true
                        ? Icons.visibility_off
                        : Icons.visibility
                      ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeLimeUI(),
                      ),
                    );
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.lightGreenAccent),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.green[900],
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.height * 0.06,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterUI(),
                      ),
                    );
                  },
                  child: Text(
                    'REGISTER',
                    style: TextStyle(color: Colors.green[900]),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.lightGreenAccent,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.height * 0.06,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
