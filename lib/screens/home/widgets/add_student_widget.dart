// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localacademy/controller/controller.dart';
import 'package:localacademy/database/functions/db_functons.dart';
import 'package:localacademy/database/model/student_data_model.dart';
import 'package:provider/provider.dart';

class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  bool imageAlert = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<ProviderStudent>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        studentProvider.uPhoto = null;
      },
    );
    log('rebuild screen');
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
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<ProviderStudent>(
                    builder: (context, value, Widget? child) {
                      log('rebuild image');
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: value.uPhoto == null
                              ? const CircleAvatar(
                                  radius: 125,
                                  backgroundImage:
                                      AssetImage('assets/images/add_image.png'),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(
                                      value.uPhoto!.path,
                                    ),
                                  ),
                                  radius: 60,
                                ),
                        ),
                      );
                    },
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
                          studentProvider.getPhoto();
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
                    controller: _nameController,
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
                    controller: _ageController,
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
                    controller: _mobileNumberController,
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
                    controller: _courseController,
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
                      if (_formKey.currentState!.validate() &&
                          studentProvider.uPhoto != null) {
                        addStudentButtonClick(context);
                        Navigator.of(context).pop();
                      } else {
                        imageAlert = true;
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

  Future<void> addStudentButtonClick(ctx) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final mobileNUmber = _mobileNumberController.text.trim();
    final course = _courseController.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        mobileNUmber.isEmpty ||
        course.isEmpty ||
        Provider.of<ProviderStudent>(ctx, listen: false).uPhoto!.path.isEmpty) {
      return;
    } else {
      Provider.of<ProviderStudent>(ctx, listen: false).getAllStudents();
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Student Added Successfully"),
        ),
      );
    }

    final student = StudentModel(
      name: name,
      age: age,
      mobileNumber: mobileNUmber,
      course: course,
      photo: Provider.of<ProviderStudent>(ctx, listen: false).uPhoto!.path,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    log(student.name.toString());
    log('Ontap function');
    Provider.of<DBFunctions>(ctx, listen: false).addStudent(student);
    Provider.of<DBFunctions>(ctx, listen: false).getAllStudents();
  }
}
