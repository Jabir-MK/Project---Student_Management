import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localacademy/database/model/student_data_model.dart';

class DBFunctions with ChangeNotifier {
  static List<StudentModel> studentList = [];
  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(value.id, value);
    studentList.add(value);
    getAllStudents();
    notifyListeners();
  }

  Future<List<StudentModel>> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();
    studentList.addAll(studentDB.values);
    return studentList;
  }

  Future<void> deleteStudent(String id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(id);
    getAllStudents();
    notifyListeners();
  }

  Future<void> editStudent(int id, StudentModel value) async {
    final dataBaseStudent = await Hive.openBox<StudentModel>('student_db');
    dataBaseStudent.putAt(id, value);
    getAllStudents();
    notifyListeners();
  }
}
