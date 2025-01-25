// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:lime_app/models/lime.dart';
import 'package:lime_app/models/user.dart';
import 'package:lime_app/utils/env.dart';
import 'package:http/http.dart' as http;

class CallAPI {
  //method เรียกใช้ api : check_login_api.php

  static Future<List<User>> checkLoginAPI(User user) async {
    //คำสั่งเรียกใช้งาน api
    //print('xxxxx');
    final ResponseData = await http.post(
      Uri.parse('${Env.baseUrl}/project_lime_api/apis/check_login_user_api.php'),
      body: jsonEncode(user.toJson()),
    );

    // print(ResponseData.body);

    //เอาค่าที่ส่งกลับมาแปลงจาก Json เพื่อเอาไปใช้ในแอป
    if (ResponseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาให้เป็น json เพื่อใช้ในแอป
      // print(ResponseData.body);
      final ResponseDataDecode = jsonDecode(ResponseData.body);
      List<User> data =
          await ResponseDataDecode.map<User>((jason) => User.fromJson(jason))
              .toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้ method
      // print('xxxxxxxxxxxxxxxxxxxxxx');
      // print(data[0].message);
      return data;
    } else {
      throw Exception('Failed to ....Eiei');
    }
  }
  // api register
  static Future<List<User>> registerNewUserAPI(User user) async {
    //คำสั่งเรียกใช้งาน API ทั้งนี้พร้อมกับกำหนดตัวแปรเพื่อรับค่าที่ส่งกลับมา
    final responseData = await http.post(
      Uri.parse('${Env.baseUrl}/project_lime_api/apis/register_newuser_api.php'),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<User> data = await responseDataDecode.map<User>((json) => User.fromJson(json)).toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... Eiei');
    }
  }
  // update user
  static Future<List<User>> updateUserAPI(User user) async {
    final responseData = await http.post(
      Uri.parse('${Env.baseUrl}/project_lime_api/apis/update_user_api.php'),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<User> data = await responseDataDecode.map<User>((json) => User.fromJson(json)).toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... Eiei');
    }
  }
  // api ดูมะนาวทั้งหมด
  static Future<List<Lime>> getAllLime() async {
    final responseData = await http.post(
      Uri.parse('${Env.baseUrl}/project_lime_api/apis/get_all_lime.php'),
      headers: {'Content-Type': 'application/json'},
    );
 
    //เอาค่าที่ส่งกลับมาแปลงจาก JSON เพื่อเอาไปใช้ในแอปฯ
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<Lime> data = await responseDataDecode.map<Lime>((json) => Lime.fromJson(json)).toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... Eiei');
    }
  }
  // api ดูมะนาวตามวันที่เลือก
  static Future<List<Lime>> getAllLimeByDate(String? addDate) async {
    Map<String, dynamic> data = {
      "addDate": addDate
    };
    final responseData = await http.post(
      Uri.parse('${Env.baseUrl}/project_lime_api/apis/get_all_lime_by_date.php'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<Lime> data = await responseDataDecode.map<Lime>((json) => Lime.fromJson(json)).toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... Eiei');
    }
  }
  
}








