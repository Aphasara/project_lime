// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:lime_app/models/lime.dart';
import 'package:lime_app/services/call_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShowLimeByDateUI extends StatefulWidget {
  const ShowLimeByDateUI({super.key});

  @override
  State<ShowLimeByDateUI> createState() => _ShowLimeByDateUIState();
}

class _ShowLimeByDateUIState extends State<ShowLimeByDateUI> {
  String limeAddDate = 'ปี-เดือน-วัน';

  Future<void> openCalendar(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        limeAddDate = '${picked.year}-${picked.month}-${picked.day}';
        statusClickButton = 0;
      });
    }
  }

  Future<List<Lime>> getAllLimeByDate(String limeAddDate) async {
    return CallAPI.getAllLimeByDate(limeAddDate);
  }

  int statusClickButton = 1;
  initState() {
    super.initState();
    //กำหนดวันที่ปัจุบัน
    DateTime now = DateTime.now();
    limeAddDate = '${now.year}-${now.month}-${now.day}';
    getAllLimeByDate(limeAddDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('กราฟโชว์จำนวนมะนาวตามวันที่'),
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
      body: SingleChildScrollView(
        child: Container(
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
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 70.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('วันที่ ${limeAddDate}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        )),
                    IconButton(
                      onPressed: () {
                        openCalendar(context);
                      },
                      icon: Icon(Icons.calendar_month),
                      color: Colors.green[900],
                      iconSize: 40.0,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      statusClickButton = 1;
                    });
                    getAllLimeByDate(limeAddDate);
                  },
                  child: Text(
                    'โชว์กราฟ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900],),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 10.0),
                  child: statusClickButton == 0
                      ? Container()
                      : FutureBuilder<List<Lime>>(
                          future: getAllLimeByDate(limeAddDate),
                          builder: (context, snapshot) {
                            if (snapshot.hasData == true) {
                              if (snapshot.data![0].message == '0') {
                                return Text('ไม่มีข้อมูล');
                              } else {
                                // เตรียมข้อมูลเกรดสำหรับกราฟ
                                final gradeData = [
                                  _GradeData(
                                      'A+',
                                      double.parse(
                                          snapshot.data![0].Aplus ?? '0')),
                                  _GradeData('A',
                                      double.parse(snapshot.data![0].A ?? '0')),
                                  _GradeData(
                                      'B+',
                                      double.parse(
                                          snapshot.data![0].Bplus ?? '0')),
                                  _GradeData('B',
                                      double.parse(snapshot.data![0].B ?? '0')),
                                  _GradeData(
                                      'C+',
                                      double.parse(
                                          snapshot.data![0].Cplus ?? '0')),
                                  _GradeData('C',
                                      double.parse(snapshot.data![0].C ?? '0')),
                                  _GradeData('D',
                                      double.parse(snapshot.data![0].D ?? '0')),
                                ];
        
                                return SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                      text: 'เกรด',
                                      textStyle: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 18,
                                      ),
                                    ),
                                    labelRotation: 0,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                      text: 'จำนวนมะนาว',
                                      textStyle: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  series: <ColumnSeries<_GradeData, String>>[
                                    ColumnSeries<_GradeData, String>(
                                      dataSource: gradeData,
                                      xValueMapper: (_GradeData data, _) =>
                                          data.grade,
                                      yValueMapper: (_GradeData data, _) =>
                                          data.total,
                                      dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        labelAlignment:
                                            ChartDataLabelAlignment.outer,
                                            textStyle: TextStyle(
                                              color: Colors.green[900],
                                              fontSize: 16,
                                            )
                                      ),
                                      trackColor: Colors.green.shade900,
                                      pointColorMapper: (_GradeData data, _) {
                                        switch (data.grade) {
                                          case 'A+':
                                            return Colors
                                                .green; // เปลี่ยนสีสำหรับ A+
                                          case 'A':
                                            return Colors
                                                .blue; // เปลี่ยนสีสำหรับ A
                                          case 'B+':
                                            return Colors
                                                .orange; // เปลี่ยนสีสำหรับ B+
                                          case 'B':
                                            return Colors
                                                .yellow; // เปลี่ยนสีสำหรับ B
                                          case 'C+':
                                            return Colors
                                                .red; // เปลี่ยนสีสำหรับ C+
                                          case 'C':
                                            return Colors
                                                .purple; // เปลี่ยนสีสำหรับ C
                                          case 'D':
                                            return Colors
                                                .brown; // เปลี่ยนสีสำหรับ D
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
                SizedBox(
                    height: 550,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradeData {
  final String grade; // ชื่อเกรด เช่น 'A+', 'A', 'B+', ...
  final double total; // ยอดรวมของเกรด

  _GradeData(this.grade, this.total);
}
