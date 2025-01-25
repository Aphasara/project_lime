// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:lime_app/models/lime.dart';
import 'package:lime_app/services/call_api.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ShowAllLimeUI extends StatefulWidget {
  const ShowAllLimeUI({super.key});

  @override
  State<ShowAllLimeUI> createState() => _ShowAllLimeUIState();
}

class _ShowAllLimeUIState extends State<ShowAllLimeUI> {
  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
        columnName: 'aplus',
        label: Container(
          child: Text(
            'A+',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
      ),
      GridColumn(
        columnName: 'a',
        label: Container(
          child: Text(
            'A',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
      ),
      GridColumn(
        columnName: 'bplus',
        label: Container(
          child: Text(
            'B+',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
      ),
      GridColumn(
        columnName: 'b',
        label: Container(
          child: Text(
            'B',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
      ),
      GridColumn(
        columnName: 'cplus',
        label: Container(
          child: Text(
            'C+',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
      ),
      GridColumn(
        columnName: 'c',
        label: Container(
          child: Text(
            'C',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
      ),
      GridColumn(
        columnName: 'd',
        label: Container(
          child: Text(
            'D',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
      ),
    ];
  }

  Future<ShowDataGridSource> getAllTemp() async {
    return ShowDataGridSource(await CallAPI.getAllLime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Home'),
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
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              'ข้อมูลการคัดแยกมะนาวทั้งหมด',
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.025,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: FutureBuilder(
                  future: CallAPI.getAllLime(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return snapshot.hasData
                        ? SfDataGrid(
                            source: snapshot.data,
                            columns: getColumns(),
                            columnWidthMode: ColumnWidthMode.fill,
                            gridLinesVisibility: GridLinesVisibility.both,
                            headerGridLinesVisibility: GridLinesVisibility.both,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

class ShowDataGridSource extends DataGridSource {
  late List<DataGridRow> _dataGridRows;
  late List<Lime> _dataShow;

  void buildDataGridRows() {
    _dataGridRows = _dataShow.map<DataGridRow>((dataShow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'aplus', value: dataShow.aplus),
        DataGridCell<String>(columnName: 'a', value: dataShow.a),
        DataGridCell<String>(columnName: 'bplus', value: dataShow.bplus),
        DataGridCell<String>(columnName: 'b', value: dataShow.b),
        DataGridCell<String>(columnName: 'cplus', value: dataShow.cplus),
        DataGridCell<String>(columnName: 'c', value: dataShow.c),
        DataGridCell<String>(columnName: 'd', value: dataShow.d),
      ]);
    }).toList(growable: false);
  }

  ShowDataGridSource(this._dataShow) {
    buildDataGridRows();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      color: effectiveRows.indexOf(row) % 2 == 0
          ? Colors.greenAccent
          : Colors.white,
      cells: [
        Container(
          child: Text(
            row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
        Container(
          child: Text(
            row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
        Container(
          child: Text(
            row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
        Container(
          child: Text(
            row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
        Container(
          child: Text(
            row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
        Container(
          child: Text(
            row.getCells()[5].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
        Container(
          child: Text(
            row.getCells()[6].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
        ),
      ],
    );
  }
}
