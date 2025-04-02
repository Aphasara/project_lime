// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lime_app/models/user.dart';
import 'package:lime_app/services/call_api.dart';
import 'package:lime_app/utils/env.dart';
import 'package:lime_app/views/login_ui.dart';
import 'package:lime_app/views/subviews/edit_profile_ui.dart';

class UserProfile extends StatefulWidget {
  User? user;
  UserProfile({Key? key, this.user}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('โปรไฟล์'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: Colors.yellowAccent,
            height: 2.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //       Colors.lightBlueAccent,
            //       Colors.lightGreenAccent,
            //       Colors.redAccent,
            //     ],
            //   ),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Stack(children: [
                  CircleAvatar(
                    radius: 150,
                    backgroundImage: NetworkImage(
                        '${Env.baseUrl}/Lime/PHP/uploading/user/${widget.user!.userImage}'),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 250,
                          top: 80,
                        ),
                        child: IconButton(
                            color: Colors.white,
                            style: ButtonStyle(
                              iconSize: MaterialStateProperty.all<double>(30),
                            ),
                            onPressed: () {
                              setState(() {
                                CallAPI.checkLoginAPI(widget.user!).then((value) {
                                  setState(() {
                                    widget.user!.userImage = value[0].userImage;
                                  });
                                });
                              });
                            },
                            icon: Icon(Icons.refresh)),
                      ),
                    ],
                  ),
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ชื่อ - สกุล : ${widget.user!.userFullname}',
                      style: TextStyle(
                        fontSize: 20, // ขนาดฟอนต์ที่ต้องการ
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,),
                    Text(
                      'ชื่อผู้ใช้ : ${widget.user!.userName}',
                      style: TextStyle(
                        fontSize: 20, // ขนาดฟอนต์ที่ต้องการ
                        fontWeight: FontWeight.bold, // เพิ่มน้ำหนักตัวอักษร
                        color: Colors.green[900], // สีตัวอักษร
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.20,
                  width: MediaQuery.of(context).size.width * 1.0,
                ),
                SizedBox(
                  height: 0.0001,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green.shade900,
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(170, 50),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileUi(
                                    user: widget.user,
                                  ))).then((value) {
                        setState(() {
                          widget.user!.userFullname = value.userFullname;
                          widget.user!.userName = value.userName;
                        });
                      });
                    });
                  },
                  child: Text('แก้ไขโปรไฟล์',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red,
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(170, 50),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginUI()));
                    });
                  },
                  child: Text('ออกจากระบบ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
