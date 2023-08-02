// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_data_base/data/model/student_model.dart';
import 'package:student_data_base/domain/bloc/studentbloc_bloc.dart';

Future<void> addStudents(StudentModel student, BuildContext context) async {
  final studentDb = Hive.box<StudentModel>("students_db");
  final studentId = await studentDb.add(student);
  context.read<StudentBloc>().add(AddStudent(newStudent: student));
  student.id = studentId;
}

Future<void> getAllstudnets() async {
  final studentDb = Hive.box<StudentModel>("students_db");
  theStudentList.clear();
  theStudentList.addAll(studentDb.values);
}

Future<void> updateStudents(
    int index, BuildContext context, StudentModel student) async {
  final studentDb = Hive.box<StudentModel>("students_db");
  studentDb.putAt(index, student);
  context
      .read<StudentBloc>()
      .add(Updatestudent(thisStudent: student, index: index));
  getAllstudnets();
}

Future<void> deleteStudent(int index) async {
  final studentDb = Hive.box<StudentModel>("students_db");
  studentDb.deleteAt(index);
  getAllstudnets();
}
