part of 'studentbloc_bloc.dart';

class StudentState {
  List<StudentModel>? studentList;
  int? current;

  StudentState({required this.studentList, this.current});
  StudentState.forScreenNav({required this.current, this.studentList});
}

class StudentblocInitial extends StudentState {
  StudentblocInitial() : super(studentList: theStudentlist, current: 0);
}
