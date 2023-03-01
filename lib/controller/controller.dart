import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localacademy/database/functions/db_functons.dart';
import 'package:localacademy/database/model/student_data_model.dart';
import 'package:provider/provider.dart';

class ProviderStudent with ChangeNotifier {
  final List<StudentModel> studentList = DBFunctions.studentList;

  File? uPhoto;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      uPhoto = photoTemp;
    }
    notifyListeners();
  }

  List<StudentModel> foundUsers = [];
  Future<void> getAllStudents() async {
    final students = await DBFunctions().getAllStudents();
    foundUsers = students;
    notifyListeners();
  }

  void addStudent(data) {
    foundUsers.clear();
    foundUsers.addAll(data);
    notifyListeners();
  }

  void runFilter(String enteredKeyWord) {
    List<StudentModel> results = [];
    if (enteredKeyWord.isEmpty) {
      results = studentList;
    } else {
      results = studentList
          .where((element) =>
              element.name.toLowerCase().contains(enteredKeyWord.toLowerCase()))
          .toList();
    }
    foundUsers = results;
    notifyListeners();
  }

  static deleteItem(BuildContext context, id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Are you sure to delete this ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<DBFunctions>(context, listen: false)
                    .deleteStudent(id);
                Provider.of<ProviderStudent>(context, listen: false)
                    .getAllStudents();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Deleted Successfully'),
                    duration: Duration(seconds: 3),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
  }
}
