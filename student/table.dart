import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  final List<List<dynamic>> absenceData;

  MyTable({required this.absenceData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('Course', style: TextStyle(fontSize: 20)),
          ),
          DataColumn(
            label: Text('Absence', style: TextStyle(fontSize: 20)),
          ),
          DataColumn(
            label: Text('Warnings', style: TextStyle(fontSize: 20)),
          ),
        ],
        rows: List<DataRow>.generate(
          1,
              (index) => DataRow(
            cells: [
              DataCell(Text(
                'Computer Vision',
                style: TextStyle(fontSize: 20),
              )),
              DataCell(Text(
                '0',
                style: TextStyle(fontSize: 20),
              )),
              DataCell(Text(
                '0',
                style: TextStyle(fontSize: 20),
    )),
    ],
    )
    )
      )
    );

}
}