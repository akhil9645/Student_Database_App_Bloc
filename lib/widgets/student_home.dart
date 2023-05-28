import 'package:flutter/material.dart';
import 'package:student_data_base/widgets/widget_student_list.dart';

import '../db/db_funtion.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return const Scaffold(
      body: ListStudentWidget(),
    );
  }
}
