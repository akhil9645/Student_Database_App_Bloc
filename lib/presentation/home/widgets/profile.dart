import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_data_base/data/model/student_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.student});
  final StudentModel student;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          "Student Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Card(
          child: SizedBox(
            width: size.width * 0.75,
            height: size.height * 0.58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(student.imagePath)),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textPart("Name :${student.name}"),
                      textPart("Phone :${student.phone}"),
                      textPart("Age :${student.age}"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text textPart(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,
    );
  }
}
