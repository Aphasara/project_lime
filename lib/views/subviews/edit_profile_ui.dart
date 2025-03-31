// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lime_app/models/user.dart';
import 'package:lime_app/services/call_api.dart';
import 'package:lime_app/utils/env.dart';

class EditProfileUi extends StatefulWidget {
  User? user;
  EditProfileUi({Key? key, this.user}) : super(key: key);

  @override
  State<EditProfileUi> createState() => _EditProfileUiState();
}

class _EditProfileUiState extends State<EditProfileUi> {
  TextEditingController userFullnameCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();
  TextEditingController userPasswordConfirmCtrl = TextEditingController();
  TextEditingController userImageCtrl = TextEditingController();

  bool pwdStatus1 = true;
  bool openpwd1 = true;

  bool pwdStatus2 = true;
  bool openpwd2 = true;

  File? _imageSelected;
  String? _imageBase64Selected;

  Future<void> _openCamera() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected = File(_picker.path);
        _imageBase64Selected = base64Encode(_imageSelected!.readAsBytesSync());
      });
    }
  }

  Future<void> _openGallery() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected = File(_picker.path);
        _imageBase64Selected = base64Encode(_imageSelected!.readAsBytesSync());
      });
    }
  }

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

  //สร้างเมธอดแสดง SuccessMessage
  Future showSuccessMessage(context, msg) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'ลงทะเบียนสำเร็จ',
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
    super.initState();
    if (widget.user != null) {
      userFullnameCtrl.text = widget.user!.userFullname ?? '';
      userNameCtrl.text = widget.user!.userName ?? '';
      userPasswordCtrl.text = widget.user!.userPassword ?? '';
      userPasswordConfirmCtrl.text = widget.user!.userPassword ?? '';
      userImageCtrl.text = widget.user!.userImage ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Edit profile'),
        titleTextStyle: TextStyle(
          color: const Color.fromARGB(255, 5, 70, 7),
          fontSize: 25,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // ลูกศรย้อนกลับ
          color: const Color.fromARGB(255, 5, 70, 7),
          onPressed: () {
            Navigator.pop(context,widget.user); // กลับไปยังหน้าก่อนหน้า
          },
        ),
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
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.1,
                    backgroundColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 5, 70, 7),
                          width: 3,
                        ),
                      ),
                      child: Stack(
                        children: [
                          _imageSelected != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    _imageSelected!,
                                    width: MediaQuery.of(context).size.height *
                                        0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : widget.user != null &&
                                      widget.user!.userImage != null &&
                                      widget.user!.userImage!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        '${Env.baseUrl}/Lime/PHP/uploading/user/${widget.user!.userImage}',
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.person_outline,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        color: const Color.fromARGB(255, 5, 70, 7),
                                      ),
                                    ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: MediaQuery.of(context).size.height * 0.06,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.green[900]!,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.green[900]!,
                                  width: 2,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            _openCamera().then((value) {
                                              Navigator.pop(context);
                                            });
                                          },
                                          leading: Icon(
                                            Icons.camera_alt,
                                            color: Colors.red,
                                          ),
                                          title: Text('Open Camera...'),
                                        ),
                                        Divider(
                                            color: Colors.green, height: 5.0),
                                        ListTile(
                                          onTap: () {
                                            _openGallery().then((value) {
                                              Navigator.pop(context);
                                            });
                                          },
                                          leading: Icon(
                                            Icons.browse_gallery,
                                            color: Colors.green,
                                          ),
                                          title: Text('Open Gallery...'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextFormField(
                      controller: userFullnameCtrl,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green[900]!, width: 2.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 3.0),
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Userfullname',
                          hintStyle: TextStyle(
                            //fontFamily: 'kanit',
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.list,
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
                      controller: userNameCtrl,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green[900]!, width: 2.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 3.0),
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'username',
                          hintStyle: TextStyle(
                            //fontFamily: 'kanit',
                            fontSize: 16,
                            color: Colors.green[900]!,
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.user,
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
                      controller: userPasswordCtrl,
                      obscureText: pwdStatus1,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green[900]!, width: 2.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 3.0),
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'password',
                        hintStyle: TextStyle(
                          //fontFamily: 'kanit',
                          fontSize: 15,
                          color: Colors.green[900]!,
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              pwdStatus1 = !pwdStatus1;
                              openpwd1 = !openpwd1;
                            });
                          },
                          icon: Icon(pwdStatus1 == true
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextFormField(
                      controller: userPasswordConfirmCtrl,
                      obscureText: pwdStatus2,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green[900]!, width: 2.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 3.0),
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'confirm password',
                        hintStyle: TextStyle(
                          //fontFamily: 'kanit',
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.key,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              pwdStatus2 = !pwdStatus2;
                              openpwd2 = !openpwd2;
                            });
                          },
                          icon: Icon(pwdStatus2 == true
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Validate ก่อน แล้วจึงส่งข้อมูลที่ป้อนไปยัง API ผ่านเมธิตที่ CallAPI
                      if (userFullnameCtrl.text.trim().length == 0) {
                        showWarningMessage(
                            context, " ตรวจสอบการป้อนชื่อและนามสกุลด้วย...");
                      } else if (userNameCtrl.text.trim().length == 0) {
                        showWarningMessage(
                            context, " ตรวจสอบการป้อนชื่อผู้ใช้ด้วย...");
                      } else if (userPasswordCtrl.text.trim().length == 0) {
                        showWarningMessage(
                            context, " ตรวจสอบการป้อนรหัสผ่านด้วย...");
                      } else if (userPasswordCtrl.text.trim() !=
                          userPasswordConfirmCtrl.text.trim()) {
                        showWarningMessage(
                            context, " รหัสผ่านไม่ตรงกัน กรุณาตรวจสอบ...");
                      } else {
                        //ส่งข้อมูลไปบันทึกที่ database
                        User user = User(
                          userId: widget.user!
                              .userId, //*ระวังเวลาแก้ไขต้องส่ง ID ไปด้วย*/
                          userFullname: userFullnameCtrl.text.trim(),
                          userName: userNameCtrl.text.trim(),
                          userPassword: userPasswordCtrl.text.trim(),
                          userImage: _imageBase64Selected,
                        );
                        //ส่งข้อมูลเตรียมไว้ไปยัง API
                        CallAPI.updateUserAPI(user).then((value) {
                          if (value[0].message == "1") {
                            //เพิ่มสำเร็จ
                            showSuccessMessage(context, "แก้ไขสำเร็จ...").then(
                              (value) {
                                Navigator.pop(context, user);
                              },
                            );
                          } else {
                            showWarningMessage(
                                context, "แก้ไขไม่สำเร็จ กรุณาลองใหม่");
                          }
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'บันทึกแก้ไขข้อมูลผู้ใช้',
                          style: TextStyle(
                              //fontFamily: 'kanit',
                              fontSize: 16,
                              color: Colors.green[900]!,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: Colors.lightGreenAccent,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width * 0.8,
                        MediaQuery.of(context).size.height * 0.06,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
