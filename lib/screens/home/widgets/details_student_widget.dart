import 'dart:io';

import 'package:flutter/material.dart';

class DetailStudentWidget extends StatelessWidget {
  final String name;
  final String age;
  final String mobileNumber;
  final String course;
  final String photo;
  final int index;

  const DetailStudentWidget(
      {super.key,
      required this.name,
      required this.age,
      required this.mobileNumber,
      required this.course,
      required this.photo,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Student"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 125,
                backgroundImage: FileImage(File(photo)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Name           : $name",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Age               :$age",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Mobile No   :$mobileNumber",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Course         :$course",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
