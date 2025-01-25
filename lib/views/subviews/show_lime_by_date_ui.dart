// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ShowLimeByDateUI extends StatefulWidget {
  const ShowLimeByDateUI({super.key});

  @override
  State<ShowLimeByDateUI> createState() => _ShowLimeByDateUIState();
}

class _ShowLimeByDateUIState extends State<ShowLimeByDateUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Date'),
        titleTextStyle: TextStyle(
          color: const Color.fromARGB(255, 5, 70, 7),
          fontSize: 25,
          //fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0), // ความสูงของเส้น
        child: Container(
          color: const Color.fromARGB(255, 5, 70, 7), // สีของเส้น
          height: 2.0, // ความหนาของเส้น
        ),
      ),
      ),
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
      ),
    );
  }
}
