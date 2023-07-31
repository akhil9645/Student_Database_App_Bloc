import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_data_base/data/model/student_model.dart';
import 'package:student_data_base/domain/bloc/studentbloc_bloc.dart';

Future<void> addStudent(StudentModel value, BuildContext context) async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');
  final _id = await studentDataB.add(value);
  context.read<StudentblocBloc>().add(AddStudent(newStudent: value));
  value.id = _id;
}

Future<void> getAllStudents() async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');
  theStudentlist.clear();
  theStudentlist.addAll(studentDataB.values);
}

Future<void> deleteStudent(int id) async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');
  studentDataB.deleteAt(id);
  getAllStudents();
}

Future<void> updateNew(
    StudentModel student, int index, BuildContext context) async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');

  studentDataB.putAt(index, student);
  context
      .read<StudentblocBloc>()
      .add(Updatestudent(student: student, index: index));
}
