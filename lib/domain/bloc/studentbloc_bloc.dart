import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:student_data_base/data/model/student_model.dart';

part 'studentbloc_event.dart';
part 'studentbloc_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<AddStudent>((event, emit) {
      state.studentList!.add(event.newStudent);
      return emit(StudentState(studentList: state.studentList));
    });
    on<NavChange>((event, emit) {
      return emit(StudentState.forScreenNav(
          current: event.current, studentList: state.studentList));
    });
    on<Updatestudent>((event, emit) {
      state.studentList![event.index] = event.thisStudent;
      return emit(StudentState(studentList: state.studentList));
    });
    on<DeleteStudent>((event, emit) {
      state.studentList!.remove(event.index);
      return emit(StudentState(studentList: state.studentList));
    });
  }
}
