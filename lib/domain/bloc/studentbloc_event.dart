part of 'studentbloc_bloc.dart';

@immutable
abstract class StudentblocEvent {}

class AddStudent extends StudentblocEvent {
  final StudentModel newStudent;
  AddStudent({required this.newStudent});
}

class NavChange extends StudentblocEvent {
  final int current;
  NavChange({required this.current});
}

class Updatestudent extends StudentblocEvent {
  final StudentModel student;
  final int index;
  Updatestudent({required this.student, required this.index});
}

class DeleteStudent extends StudentblocEvent {
  final StudentModel index;
  DeleteStudent({required this.index});
}
