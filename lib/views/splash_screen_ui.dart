// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lime_app/views/login_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {

  @override

  void initState() {
    Future.delayed(
        Duration(seconds: 5),
        () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginUI(),
                ),
              ),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/images/logo2.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0015,
              ),
              CircularProgressIndicator(
                color: const Color.fromARGB(255, 22, 99, 24),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Text(
                'Computer Engineering',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  color: const Color.fromARGB(255, 22, 99, 24),
                ),
              ),
              Text(
                'Southeast Asia University',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  color: const Color.fromARGB(255, 22, 99, 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}