import 'package:flutter/material.dart';
import 'package:vision_project/my_theme.dart';
import 'package:vision_project/student/student.dart';
import 'package:vision_project/teacher/teacher.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.primaryColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.48,
              ),
              Image.asset(
                'assets/student.png',
                height: 70,
                width: 70,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyTheme.lightBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: MyTheme.lightBlue)))),
                  onPressed: () {
                    Navigator.pushNamed(context, Student.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Student',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                  ))
            ],
          ),
          SizedBox(
            width: 32,
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.48,
              ),
              Image.asset('assets/teacher.png',
                  height: 70, width: 70, fit: BoxFit.fill),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(MyTheme.lightBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: MyTheme.lightBlue)))),
                onPressed: () {
                  Navigator.pushNamed(context, Teacher.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Teacher',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
