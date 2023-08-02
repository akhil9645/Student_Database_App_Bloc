// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_data_base/data/db/db_funtion.dart';
import 'package:student_data_base/data/model/student_model.dart';

import 'package:student_data_base/domain/imagepicking/imagepicking_bloc.dart';

// ignore: must_be_immutable
class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key, required this.indx, required this.student});
  StudentModel student;
  final int indx;
  String? imgPath;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final image = student.imagePath;
    nameController.text = student.name;
    ageController.text = student.age;
    phoneController.text = student.phone;
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
                      radius: 120,
                      backgroundImage: imgPath == null
                          ? FileImage(File(image))
                          : FileImage(File(imgPath ?? image)),
                    );
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
          formField(nameController, Icons.abc, TextInputType.name, 50),
          formField(ageController, Icons.place, TextInputType.number, 2),
          formField(phoneController, Icons.phone, TextInputType.phone, 10),
          ElevatedButton(
              onPressed: () {
                studentAdd(indx, image, context);

                Navigator.pop(context);
              },
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ))
        ],
      )),
    );
  }

  Padding formField(TextEditingController controlle, IconData icon,
      TextInputType input, int length) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        maxLength: length,
        keyboardType: input,
        controller: controlle,
        decoration: InputDecoration(
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

  Future<void> studentAdd(int index, imagePath, BuildContext context) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final phone = phoneController.text.trim();
    final image = imgPath;
    if (name.isEmpty || age.isEmpty || phone.isEmpty) {
      return;
    }

    StudentModel student = StudentModel(
      name: name,
      phone: phone,
      age: age,
      imagePath: image ?? imagePath,
    );

    updateStudents(index, context, student);
  }
}
