import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_data_base/models/student_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');
  final _id = await studentDataB.add(value);
  value.id = _id;

  getAllStudents();
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDataB.values);

  studentListNotifier.notifyListeners();
}

//Deliting Student
Future<void> deleteStudent(int id) async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');
  studentDataB.deleteAt(id);
  getAllStudents();
}

//Updating Student
Future<void> updateNew(StudentModel value, int id) async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');

  //Updating student according to id
  studentDataB.putAt(id, value);
  studentListNotifier.value.clear();
  studentListNotifier.notifyListeners();
}
