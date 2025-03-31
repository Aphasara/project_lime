// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[900],
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Column(
          mainAxisSize:
              MainAxisSize.min, // ป้องกัน Column ยืดขนาดเกินความจำเป็น
          children: [
            Text(
              'ยินดีต้อนรับ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8), // เพิ่มระยะห่างระหว่างข้อความ
            Text(
              'กรุณาลงชื่อเข้าใช้เพื่อดูข้อมูล',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.values.first,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    child: Image.asset(
                      'assets/images/logo2.png',
                      width: 230,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      controller: userNameCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: Colors.green[900],
                          size: 35,
                        ),
                        hintText: 'ชื่อผู้ใช้',
                        hintStyle: TextStyle(
                          color: Colors.green[900],
                          //fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green[900]!, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey!, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      controller: userPasswordCtrl,
                      obscureText: openpwd,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.green[900],
                        ),
                        hintText: 'รหัสผ่าน',
                        hintStyle: TextStyle(
                          color: Colors.green[900],
                          //fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green[900]!, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey!, width: 1.5),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              pwdStatus = !pwdStatus;
                              openpwd = !openpwd;
                            });
                          },
                          icon: Icon(pwdStatus == true
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Align(
                    child: ElevatedButton(
                      onPressed: () {
                        //validate หน้าจอ
                        if (userNameCtrl.text.trim().length == 0) {
                          showWarningMessage(context, 'ป้อนชื่อผู้ใช้ด้วย...');
                        } else if (userPasswordCtrl.text.trim().length == 0) {
                          showWarningMessage(context, 'ป้อนรหัสผ่านด้วย...');
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
                                    showWarningMessage(
                                        context, 'ชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง')
                                  }
                              });
                        }
                      },
                      child: Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),
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
                        'ลงทะเบียน',
                        style: TextStyle(
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: Colors.green,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.6,
                          MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
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
