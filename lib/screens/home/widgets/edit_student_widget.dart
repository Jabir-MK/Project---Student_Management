import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localacademy/database/model/student_data_model.dart';

class EditStudentWidget extends StatefulWidget {
  final String name;
  final String age;
  final String mobileNumber;
  final String course;
  final String image;
  final int index;

  const EditStudentWidget({
    super.key,
    required this.name,
    required this.age,
    required this.mobileNumber,
    required this.course,
    required this.image,
    required this.index,
    required String photo,
  });

  @override
  State<EditStudentWidget> createState() => _EditStudentWidgetState();
}

class _EditStudentWidgetState extends State<EditStudentWidget> {
  TextEditingController _nameEditController = TextEditingController();
  TextEditingController _ageEditController = TextEditingController();
  TextEditingController _mobileNumberEditController = TextEditingController();
  TextEditingController _courseEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameEditController = TextEditingController(text: widget.name);
    _ageEditController = TextEditingController(text: widget.age);
    _mobileNumberEditController =
        TextEditingController(text: widget.mobileNumber);
    _courseEditController = TextEditingController(text: widget.course);
  }

  @override
  Widget build(BuildContext context) {
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
                        File(widget.image),
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
        photo: widget.image);
    editStudent(widget.index, studentEdit);

    if (_nameEditController.text.isEmpty ||
        _ageEditController.text.isEmpty ||
        _mobileNumberEditController.text.isEmpty ||
        _courseEditController.text.isEmpty ||
        widget.image.isEmpty) {
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
