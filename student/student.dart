import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:vision_project/student/table.dart';
import 'package:http/http.dart' as http;

import '../my_theme.dart';

class Student extends StatefulWidget {
  static const String routeName = 'student';

  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  String? userName;
  String? id;
  List<List<dynamic>> absenceData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        centerTitle: true,
        backgroundColor: MyTheme.primaryColor,
        title: Text(
          'Welcome Student',
          style: TextStyle(fontSize: 22),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Your Info:',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Enter your ID'),
                    onChanged: (value) {
                      setState(() {
                        id = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await fetchAbsenceData();
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            MyTable(absenceData: absenceData),
          ],
        ),
      ),
    );
  }

  Future<void> fetchAbsenceData() async {
    try {
      String apiUrl = 'http://127.0.0.1:5000/detect'; // Replace with your server URL
      var response = await http.post(Uri.parse(apiUrl), body: {'file': 'your_image_data_here'});

      if (response.statusCode == 200) {
        String csvData = response.body;

        // Process the CSV data as needed
        List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);

        // Update the UI with the fetched data
        setState(() {
          absenceData = csvTable;
        });
      } else {
        // Handle error
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> sendImage(XFile image) async {
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse('<YOUR_API_URL>'));

    // Attach the selected image file to the request
    var fileBytes = await image.readAsBytes();
    var base64Image = base64Encode(fileBytes);
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        fileBytes,
        filename: '${DateTime.now()}.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    // Send the request to the API
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      // If the request is successful, print the response body to the console
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image');
    }
  }
}

