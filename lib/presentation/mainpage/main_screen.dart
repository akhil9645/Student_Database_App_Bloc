import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_data_base/domain/bloc/studentbloc_bloc.dart';
import 'package:student_data_base/presentation/home/student_home.dart';
import 'package:student_data_base/presentation/student_add/widget_student_add.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final _screens = [const MyHomePage(), StudentAddingPage()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        int currentScreen = state.current ?? 0;
        return Scaffold(
            body: _screens[currentScreen],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.blue,
              currentIndex: state.current ?? 0,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: "Student List"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_add), label: "Add Student")
              ],
              onTap: (value) {
                context.read<StudentBloc>().add(NavChange(current: value));
                currentScreen = state.current ?? 0;
              },
            ));
      },
    );
  }
}
