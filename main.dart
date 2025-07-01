import 'package:flutter/material.dart';
import 'package:vision_project/home_page.dart';
import 'package:vision_project/student/student.dart';
import 'package:vision_project/teacher/teacher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        Student.routeName: (context) => Student(),
        Teacher.routeName: (context) => Teacher()
      },
    );
  }
}
