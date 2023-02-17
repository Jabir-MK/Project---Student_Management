import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localacademy/controller/controller.dart';
import 'package:provider/provider.dart';

class AddStudentWidget extends StatelessWidget {
  const AddStudentWidget({super.key});

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _mobileNumberController = TextEditingController();
  // final TextEditingController _courseController = TextEditingController();

  // bool imageAlert = false;

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final providerController = Provider.of<ControllerDB>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Add Student"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: providerController.formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  providerController.uPhoto?.path == null
                      ? const CircleAvatar(
                          radius: 125,
                          backgroundImage:
                              AssetImage('assets/images/add_image.png'),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(
                              providerController.uPhoto!.path,
                            ),
                          ),
                          radius: 60,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 10,
                        ),
                        onPressed: () {
                          providerController.getPhoto();
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                        ),
                        label: const Text(
                          'Add An Image',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: providerController.nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Name"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name hasn't been filled";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: providerController.ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Age"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Age hasn't been filled";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: providerController.mobileNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Mobile Number"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mobile Number hasn't been filled";
                      } else if (value.length != 10) {
                        return "Incorrect Mobile Number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: providerController.courseController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Course"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Course hasn't been filled";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (providerController.formKey.currentState!.validate()) {
                        providerController.addStudentButtonClick(context);
                      } else {
                        providerController.imageAlert = true;
                      }
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text("Add"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> addStudentButtonClick() async {
  //   final name = _nameController.text.trim();
  //   final age = _ageController.text.trim();
  //   final mobileNUmber = _mobileNumberController.text.trim();
  //   final course = _courseController.text.trim();

  //   if (name.isEmpty ||
  //       age.isEmpty ||
  //       mobileNUmber.isEmpty ||
  //       course.isEmpty ||
  //       _photo!.path.isEmpty) {
  //     return;
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.green,
  //         behavior: SnackBarBehavior.floating,
  //         margin: EdgeInsets.all(20),
  //         content: Text("Student Added Successfully"),
  //       ),
  //     );
  //   }

  //   final student = StudentModel(
  //     name: name,
  //     age: age,
  //     mobileNumber: mobileNUmber,
  //     course: course,
  //     photo: _photo!.path,
  //   );
  //   addStudent(student);
  //   Navigator.of(context).pop();
  // }

  // File? _photo;
  // Future<void> getPhoto() async {
  //   final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (photo == null) {
  //     return;
  //   } else {
  //     final photoTemp = File(photo.path);
  //     setState(
  //       () {
  //         _photo = photoTemp;
  //       },
  //     );
  //   }
  // }
}
