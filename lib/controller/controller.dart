import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localacademy/database/model/student_data_model.dart';

class ControllerDB with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController courseController = TextEditingController();

  bool imageAlert = false;

  final formKey = GlobalKey<FormState>();
  // ----------------------------------------------------
  File? uPhoto;

  // ====================================================

  List<StudentModel> studentList = [];

  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    final ids = await studentDB.add(value);
    value.id = ids;
    studentList.add(value);
    notifyListeners();
    getAllStudents();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();
    studentList.addAll(studentDB.values);
    notifyListeners();
  }

  Future<void> deleteStudent(index) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.deleteAt(index);
    getAllStudents();
  }

  Future<void> editStudent(int id, StudentModel value) async {
    final dataBaseStudent = await Hive.openBox<StudentModel>('student_db');
    dataBaseStudent.putAt(id, value);
    getAllStudents();
  }

  // -----------------------------------------------------------------------
  Future<void> addStudentButtonClick(context) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final mobileNUmber = mobileNumberController.text.trim();
    final course = courseController.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        mobileNUmber.isEmpty ||
        course.isEmpty ||
        uPhoto!.path.isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
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
      photo: uPhoto!.path,
    );
    addStudent(student);
    Navigator.of(context).pop();
  }

  // -----------------------------------------------------
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);

      uPhoto = photoTemp;
      notifyListeners();
    }
  }
}
