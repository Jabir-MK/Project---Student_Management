// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localacademy/database/model/student_data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final ids = await studentDB.add(value);
  value.id = ids;
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
  getAllStudents();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
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
