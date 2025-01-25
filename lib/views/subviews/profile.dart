// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lime_app/models/user.dart';
import 'package:lime_app/services/call_api.dart';

class Profile extends StatefulWidget {

  User? user;

  Profile({super.key,this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  //TextEditingController user_IdCtrl = TextEditingController(text: '');
  TextEditingController userFullNameCtrl = TextEditingController(text: '');
  TextEditingController userNameCtrl = TextEditingController(text: '');
  TextEditingController userPasswordCtrl = TextEditingController(text: '');
  TextEditingController userPasswordConfirmCtrl =
      TextEditingController(text: '');
  TextEditingController userImageCtrl = TextEditingController(text: '');

  //สร้างเมธอดแสดง WarningMessage
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

  //สร้างเมธอดแสดง WarningMessage
  Future showSuccessMessage(context, msg) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'ผลการทำงาน',
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
  void initState() {
    //userFullnameCtrl.text = widget.user!.user_Id!;
    userFullNameCtrl.text = widget.user!.userFullName!;
    userNameCtrl.text = widget.user!.userName!;
    userImageCtrl.text = widget.user!.userImage!;
    userPasswordCtrl.text = widget.user!.userPassword!;
    userPasswordConfirmCtrl.text = widget.user!.userPassword!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          'Update User',
          style: TextStyle(
            color: Colors.green[800],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.green[800],
        ),
        bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0), // ความสูงของเส้น
        child: Container(
          color: const Color.fromARGB(255, 5, 70, 7), // สีของเส้น
          height: 2.0, // ความหนาของเส้น
        ),
      ),
      ),
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
            )
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  'ข้อมูลใช้งาน',
                  style: TextStyle(
                    fontFamily: 'kanit',
                    fontSize: 20,
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: TextFormField(
                    controller: userFullNameCtrl,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green[800]!, width: 2.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'ชื่อ-นามสกุล',
                        hintStyle: TextStyle(
                          fontFamily: 'kanit',
                          fontSize: 16,
                          color: Colors.green[800],
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.list,
                          color: Colors.green[900],
                        )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextFormField(
                    enabled: false,
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green[800]!, width: 2.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'ชื่อผู้ใช้',
                        hintStyle: TextStyle(
                          fontFamily: 'kanit',
                          fontSize: 16,
                          color: Colors.green[800],
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.person,
                          color: Colors.green[900],
                        )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextFormField(
                    enabled: false,
                    controller: userPasswordCtrl,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green[800]!, width: 2.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'รหัสผ่าน',
                        hintStyle: TextStyle(
                          fontFamily: 'kanit',
                          fontSize: 15,
                          color: Colors.green[800],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: Colors.green[800],
                          ),
                          onPressed: () {},
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.key,
                          color: Colors.green[900],
                        )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextFormField(
                    enabled: false,
                    controller: userPasswordConfirmCtrl,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green[800]!, width: 2.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        //ใส่เพื่อเวลากดช่องไหน กรอบจะไม่หาย
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'ยืนยันรหัสผ่าน',
                        hintStyle: TextStyle(
                          fontFamily: 'kanit',
                          fontSize: 15,
                          color: Colors.green[800],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: Colors.green[800],
                          ),
                          onPressed: () {},
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.key,
                          color: Colors.green[900],
                        )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.8,
                //   height: MediaQuery.of(context).size.height * 0.06,
                //   child: TextFormField(
                //     controller: userImageCtrl,
                //     decoration: InputDecoration(
                //         enabledBorder: OutlineInputBorder(
                //           borderSide:
                //               BorderSide(color: Colors.green[800]!, width: 2.0),
                //           borderRadius: BorderRadius.circular(5),
                //         ),
                //         hintText: 'อีเมล์',
                //         hintStyle: TextStyle(
                //           fontFamily: 'kanit',
                //           fontSize: 16,
                //           color: Colors.green[800],
                //         ),
                //         prefixIcon: Icon(
                //           FontAwesomeIcons.envelope,
                //           color: Colors.green[900],
                //         )),
                //   ),
                // ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    //validate ก่อนแล้วส่งข้อมูลที่ป้อนไปยัง api ผ่านเมดธอดที่ callapi
                    if (userFullNameCtrl.text.trim().length == 0) {
                      showWarningMessage(context, 'ป้อนชื่อ-นามสกุลด้วย');
                    } else {
                      //ส่งข้อมูลไปยัง api เพื่อบันทึกลง DB
                      User user = User(
                        user_Id: widget.user!.user_Id,
                        userFullName: userFullNameCtrl.text.trim(),
                        userName: userNameCtrl.text.trim(),
                        userPassword: userPasswordCtrl.text.trim(),
                        userImage: userImageCtrl.text.trim(),
                      );
                      //ส่งข้อมูลที่เตรียมไว้ไปยัง api ผ่านเมธอดที่ callapi ชื่อ RegisterNewUserAPI
                      CallAPI.updateUserAPI(user).then((value) => {
                            if (value[0].message == "1")
                              {
                                showSuccessMessage(context, "อัปเดตสำเร็จแล้วจ้า")
                                    .then((value) => {
                                          Navigator.pop(context, user),
                                        }),
                              }
                            else
                              {showWarningMessage(context, "อัปเดตไม่สำเร็จ")}
                          });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'บันทึกข้อมูลลงทะเบียนผู้ใช้',
                        style: TextStyle(
                            fontFamily: 'kanit',
                            fontSize: 16,
                            color: Colors.lightGreenAccent,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.green[800],
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.06,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}