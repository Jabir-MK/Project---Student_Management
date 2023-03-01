// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localacademy/database/functions/db_functons.dart';
import 'package:localacademy/database/model/student_data_model.dart';
import 'package:provider/provider.dart';

class EditStudentWidget extends StatelessWidget {
  EditStudentWidget({
    super.key,
    required this.name,
    required this.age,
    required this.mobileNumber,
    required this.course,
    required this.image,
    required this.index,
    required String photo,
    required this.id,
  });

  final String name;
  final String age;
  final String mobileNumber;
  final String course;
  final String image;
  final int index;
  final String id;

  TextEditingController _nameEditController = TextEditingController();
  TextEditingController _ageEditController = TextEditingController();
  TextEditingController _mobileNumberEditController = TextEditingController();
  TextEditingController _courseEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _nameEditController = TextEditingController(text: name);
    _ageEditController = TextEditingController(text: age);
    _mobileNumberEditController = TextEditingController(text: mobileNumber);
    _courseEditController = TextEditingController(text: course);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Student Info"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 125,
                      backgroundImage: FileImage(
                        File(image),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameEditController,
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
                    controller: _ageEditController,
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
                    controller: _mobileNumberEditController,
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
                    controller: _courseEditController,
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
                      if (_formKey.currentState!.validate()) {
                        editStudentButtonClick(context);
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editStudentButtonClick(context) async {
    final studentEdit = StudentModel(
      name: _nameEditController.text,
      age: _ageEditController.text,
      mobileNumber: _mobileNumberEditController.text,
      course: _courseEditController.text,
      photo: image.toString(),
      id: id,
    );
    Provider.of<DBFunctions>(context, listen: false)
        .editStudent(index, studentEdit);
    Provider.of<DBFunctions>(context, listen: false).getAllStudents();

    if (_nameEditController.text.isEmpty ||
        _ageEditController.text.isEmpty ||
        _mobileNumberEditController.text.isEmpty ||
        _courseEditController.text.isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Updated Student Successfully"),
        ),
      );
    }
  }
}
