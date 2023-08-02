import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_data_base/domain/bloc/studentbloc_bloc.dart';
import 'package:student_data_base/presentation/home/widgets/profile.dart';
import 'package:student_data_base/presentation/home/widgets/search_widget.dart';
import 'package:student_data_base/presentation/home/widgets/update_student.dart';

import '../../data/db/db_funtion.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        title: const Text(
          "Student List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SearchWidget();
                  },
                ));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.studentList?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ProfileScreen(
                          student: state.studentList![index],
                        );
                      },
                    ));
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(
                        File(state.studentList?[index].imagePath ?? "")),
                  ),
                  title: Text(state.studentList![index].name),
                  subtitle: Text(state.studentList![index].age),
                  trailing: Wrap(children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return UpdateScreen(
                                indx: index,
                                student: state.studentList![index],
                              );
                            },
                          ));
                        },
                        icon: const Icon(Icons.update)),
                    IconButton(
                        onPressed: () {
                          context.read<StudentBloc>().add(
                              DeleteStudent(index: state.studentList![index]));
                          deleteStudent(index);
                        },
                        icon: const Icon(Icons.delete)),
                  ]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
