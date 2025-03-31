// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lime_app/models/user.dart';
import 'package:lime_app/services/call_api.dart';
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

//สร้างตัวแปรควบคุม TesctField (อย่าลืมไปผูกกับ TextFiled)
  TextEditingController userNameCtrl = TextEditingController(text: '');
  TextEditingController userPasswordCtrl = TextEditingController(text: '');

  showWarningMessage(context, msg) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'คำเตือน',
          textAlign: TextAlign.center,
        ),
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'ตกลง',
            ),
          ),
        ],
      ),
    );
  }
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
                    controller: userNameCtrl,
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
                controller: userPasswordCtrl,
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
                            //validate หน้าจอ
                            if (userNameCtrl.text.trim().length == 0) {
                              showWarningMessage(
                                  context, 'ป้อนชื่อผู้ใช้ด้วย...');
                            } else if (userPasswordCtrl.text.trim().length ==
                                0) {
                              showWarningMessage(
                                  context, 'ป้อนรหัสผ่านด้วย...');
                            } else {
                              //ส่งข้อมูลที่ป้อนในที่นี้คือ ชื่อผู้ใช้ รหัสผ่าน ไปที่ API
                              //แล้วทำงานต่อไป
                              User user = User(
                                userName: userNameCtrl.text.trim(),
                                userPassword: userPasswordCtrl.text.trim(),
                              );
                              //
                              CallAPI.checkLoginAPI(user).then((value) => {
                                    if (value[0].message == "1")
                                      {
                                        //เปิดไปหน้า home_ui
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HomeLimeUI(user: value[0]),
                                          ),
                                        ),
                                      }
                                    else
                                      {
                                        //แสดง MSG ชื่อผ฿้ใช้รหัสผ่านไม่ถ฿กต้อง
                                        showWarningMessage(context,
                                            'ชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง')
                                      }
                                  });
                            }
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
                height: MediaQuery.of(context).size.height * 0.07,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
