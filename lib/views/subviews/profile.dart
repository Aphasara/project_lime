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
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Profile'),
        titleTextStyle: TextStyle(
          color: const Color.fromARGB(255, 5, 70, 7),
          fontSize: 25,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: const Color.fromARGB(255, 5, 70, 7),
            height: 2.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
                      'Name: ${widget.user!.userName}',
                      style: TextStyle(
                        fontSize: 20, // ขนาดฟอนต์ที่ต้องการ
                        //fontWeight: FontWeight.bold, // เพิ่มน้ำหนักตัวอักษร
                        color: Colors.black, // สีตัวอักษร
                      ),
                    ),
                    Text(
                      'User: ${widget.user!.userFullname}',
                      style: TextStyle(
                        fontSize: 20, // ขนาดฟอนต์ที่ต้องการ
                        //fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 1.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green,
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(150, 50),
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
                  child: Text('Edit Profile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
                      Size(150, 50),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginUI()));
                    });
                  },
                  child: Text('Logout',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
