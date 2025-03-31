// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lime_app/models/lime.dart';
import 'package:lime_app/services/call_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShowAllLimeUI extends StatefulWidget {
  const ShowAllLimeUI({super.key});

  @override
  State<ShowAllLimeUI> createState() => _ShowAllLimeUIState();
}

class _ShowAllLimeUIState extends State<ShowAllLimeUI> {
  Future<List<Lime>> getAllLime() async {
    return CallAPI.getAllLime(); // ดึงข้อมูลทั้งหมดจาก API
  }

  int statusClickButton = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Show Total Lime Grades'),
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
            children: [
              SizedBox(height: 40.0),
              //SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 10.0),
                child: FutureBuilder<List<Lime>>(
                  future: getAllLime(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == true) {
                      if (snapshot.data![0].message == '0') {
                        return Text('ไม่มีข้อมูล');
                      } else {
                        // คำนวณผลรวมสำหรับแต่ละเกรด
                        double totalAplus = snapshot.data!
                            .map((lime) => double.parse(lime.Aplus ?? '0'))
                            .reduce((a, b) => a + b);
                        double totalA = snapshot.data!
                            .map((lime) => double.parse(lime.A ?? '0'))
                            .reduce((a, b) => a + b);
                        double totalBplus = snapshot.data!
                            .map((lime) => double.parse(lime.Bplus ?? '0'))
                            .reduce((a, b) => a + b);
                        double totalB = snapshot.data!
                            .map((lime) => double.parse(lime.B ?? '0'))
                            .reduce((a, b) => a + b);
                        double totalCplus = snapshot.data!
                            .map((lime) => double.parse(lime.Cplus ?? '0'))
                            .reduce((a, b) => a + b);
                        double totalC = snapshot.data!
                            .map((lime) => double.parse(lime.C ?? '0'))
                            .reduce((a, b) => a + b);
                        double totalD = snapshot.data!
                            .map((lime) => double.parse(lime.D ?? '0'))
                            .reduce((a, b) => a + b);

                        // เตรียมข้อมูลสำหรับกราฟ
                        final gradeData = [
                          _GradeData('A+', totalAplus),
                          _GradeData('A', totalA),
                          _GradeData('B+', totalBplus),
                          _GradeData('B', totalB),
                          _GradeData('C+', totalCplus),
                          _GradeData('C', totalC),
                          _GradeData('D', totalD),
                        ];
                        return SfCircularChart(
                          title: ChartTitle(
                            text: 'Total Lime Grades Distribution',
                            textStyle: TextStyle(
                              fontSize: 20,
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                          ),
                          series: <PieSeries<_GradeData, String>>[
                            PieSeries<_GradeData, String>(
                              dataSource: gradeData,
                              xValueMapper: (_GradeData data, _) => data.grade,
                              yValueMapper: (_GradeData data, _) => data.total,
                              dataLabelMapper: (_GradeData data, _) =>
                                  '${data.grade}: ${data.total.toStringAsFixed(0)}',
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                labelPosition: ChartDataLabelPosition.outside,
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              explode: true,
                              explodeIndex: 0,
                              pointColorMapper: (_GradeData data, _) {
                                switch (data.grade) {
                                  case 'A+':
                                    return Colors.green; // เปลี่ยนสีสำหรับ A+
                                  case 'A':
                                    return Colors.blue; // เปลี่ยนสีสำหรับ A
                                  case 'B+':
                                    return Colors.orange; // เปลี่ยนสีสำหรับ B+
                                  case 'B':
                                    return Colors.yellow; // เปลี่ยนสีสำหรับ B
                                  case 'C+':
                                    return Colors.red; // เปลี่ยนสีสำหรับ C+
                                  case 'C':
                                    return Colors.purple; // เปลี่ยนสีสำหรับ C
                                  case 'D':
                                    return Colors.brown; // เปลี่ยนสีสำหรับ D
                                  default:
                                    return Colors
                                        .grey; // สีเริ่มต้นสำหรับกรณีอื่นๆ
                                }
                              },
                            ),
                          ],
                        );
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Image.asset(
                'assets/images/lime.png',
                width: 250,
                height: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// คลาสสำหรับเก็บข้อมูลเกรดและยอดรวม
class _GradeData {
  final String grade; // ชื่อเกรด เช่น 'A+', 'A', 'B+', ...
  final double total; // ยอดรวมของเกรด

  _GradeData(this.grade, this.total);
}
