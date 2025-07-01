import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class DataTab extends StatefulWidget {
  @override
  _DataTabState createState() => _DataTabState();
}

class _DataTabState extends State<DataTab> {
  List<List<dynamic>> csvData = [];

  @override
  void initState() {
    super.initState();
    loadCSVData();
  }

  Future<void> loadCSVData() async {
    try {
      String data = await rootBundle.loadString('assets/data.csv');
      csvData = CsvToListConverter().convert(data);
      setState(() {});
    } catch (e) {
      print('Error loading CSV data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: csvData.isNotEmpty
          ? ListView.builder(
        itemCount: csvData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(csvData[index].join(', ')),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
