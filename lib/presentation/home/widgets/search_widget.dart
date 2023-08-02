import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_data_base/data/model/student_model.dart';
import 'package:student_data_base/domain/searchbloc/bloc/search_bloc.dart';
import 'package:student_data_base/presentation/home/widgets/profile.dart';
import 'package:student_data_base/presentation/mainpage/main_screen.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  TextEditingController searchController = TextEditingController();
  late List<StudentModel> searchList = List<StudentModel>.from(theStudentList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                serchfuntion(value, context);
              },
              decoration: InputDecoration(
                hintText: "Search Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (searchController.text.isEmpty) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return MainScreen();
                        }), (route) => false);
                      } else {
                        searchController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.clear,
                    )),
              ),
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Expanded(
                child: state.searchStudents.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ProfileScreen(
                                    student: state.searchStudents[index],
                                  );
                                },
                              ));
                            },
                            title: Text(state.searchStudents[index].name),
                            subtitle: Text(state.searchStudents[index].age),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(
                                  File(state.searchStudents[index].imagePath)),
                            ),
                          ));
                        },
                        itemCount: state.searchStudents.length,
                      )
                    : const Center(
                        child: Text(
                          "No Students are found",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  void serchfuntion(String value, BuildContext context) {
    searchList = theStudentList
        .where((element) =>
            element.name.toLowerCase().startsWith(value.toLowerCase()) ||
            element.age.startsWith(value))
        .toList();
    context.read<SearchBloc>().add(ForSearch(students: searchList));
  }
}
