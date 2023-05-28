import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_data_base/models/student_model.dart';
import 'package:student_data_base/widgets/main_screen.dart';

class StudentView extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 160;
  final double coverWidth = 500;

  StudentView({
    Key? key,
    required this.passValue,
    required this.passId,
  }) : super(key: key);

  StudentModel passValue;
  final int passId;

  //Widgets Used for displaying student list

  Widget content() {
    return Container(
      width: 200,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            ' ${passValue.name}',
            style: const TextStyle(fontSize: 28, fontFamily: 'Ubuntu'),
          ),
          Text('Age : ${passValue.age}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Text('Number : ${passValue.num}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget top() {
    final top = (coverHeight - profileHeight / 2) + 40;
    final bottom = profileHeight / 2;
    return Stack(clipBehavior: Clip.none, children: [
      Container(margin: EdgeInsets.only(bottom: bottom), child: CoverImage()),
      Positioned(
        top: top,
        left: 115,
        child: ProfileImage(),
      ),
    ]);
  }

  Widget CoverImage() => Container(
        width: coverWidth - 85,
        height: coverHeight + 60,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
          ),
        ),
      );

  Widget ProfileImage() => CircleAvatar(
        backgroundImage: FileImage(File(passValue.image)),
        radius: profileHeight / 1.8,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_circle_left_sharp,
              size: 40,
            ),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const MainScreen()),
                (route) => false)),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          top(),
          content(),
        ],
      ),
    );
  }
}
