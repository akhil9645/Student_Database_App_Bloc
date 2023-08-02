// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_data_base/data/model/student_model.dart';
import 'package:student_data_base/domain/imagepicking/imagepicking_bloc.dart';
import 'package:student_data_base/presentation/mainpage/main_screen.dart';

import '../../data/db/db_funtion.dart';

// ignore: must_be_immutable
class StudentAddingPage extends StatelessWidget {
  StudentAddingPage({super.key});
  String? imgPath;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        title: const Text(
          "Add students",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: BlocBuilder<ImagePickingBloc, ImagePickingState>(
                    builder: (context, state) {
                      return CircleAvatar(
                          radius: 100,
                          backgroundImage: imgPath == null
                              ? const AssetImage("asset/1.jpg") as ImageProvider
                              : FileImage(
                                  File(state.image),
                                ));
                    },
                  ),
                ),
                Positioned(
                  right: 80,
                  bottom: 10,
                  child: IconButton(
                      iconSize: 35,
                      onPressed: () async {
                        await takePhoto();
                        context
                            .read<ImagePickingBloc>()
                            .add(ChangeImg(image: imgPath ?? ""));
                      },
                      icon: const Icon(Icons.camera_alt_outlined)),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            formField(
                nameController, "Name", Icons.abc, TextInputType.name, 50),
            formField(
                ageController, "Age", Icons.place, TextInputType.number, 2),
            formField(
                phoneController, "Phone", Icons.phone, TextInputType.phone, 10),
            ElevatedButton(
                onPressed: () {
                  if (imgPath != null &&
                      nameController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty &&
                      ageController.text.isNotEmpty) {
                    onAddStudentButtonClicked(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => MainScreen()),
                        (route) => false);
                  } else {
                    showSnackBar(context);
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  Padding formField(TextEditingController controller, String hint,
      IconData icon, TextInputType input, length) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        maxLength: length,
        keyboardType: input,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Icon(
              icon,
              color: const Color.fromARGB(255, 20, 136, 82),
            )),
      ),
    );
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imgPath = pickedFile.path;
    }
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final number = phoneController.text.trim();

    if (name.isEmpty || age.isEmpty || number.isEmpty || imgPath == null) {
      return;
    }

    final student = StudentModel(
      name: name,
      age: age,
      phone: number,
      imagePath: imgPath!,
    );

    addStudents(student, context).then((val) => studentAddSnackBar(context));
  }

  showSnackBar(BuildContext context) {
    var errMsg = "";

    if (imgPath == null &&
        nameController.text.isEmpty &&
        ageController.text.isEmpty &&
        phoneController.text.isEmpty) {
      errMsg = "Please Insert Valid Data In All Fields ";
    } else if (imgPath == null) {
      errMsg = "please choose profile pic to Continue";
    } else if (ageController.text.isEmpty) {
      errMsg = "Please enter the age to Continue";
    } else if (nameController.text.isEmpty) {
      errMsg = "Name  Must Be Filled";
    } else if (phoneController.text.isEmpty) {
      errMsg = "Phone Number Must Be Filled";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey,
        margin: const EdgeInsets.all(10.0),
        content: Text(errMsg),
      ),
    );
  }

  void studentAddSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 132, 110, 170),
        content: Text('This Student Inserted Into Database'),
      ),
    );
  }
}
