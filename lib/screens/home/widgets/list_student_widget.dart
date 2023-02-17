import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localacademy/database/functions/db_functons.dart';
import 'package:localacademy/database/model/student_data_model.dart';
import 'package:localacademy/screens/home/widgets/details_student_widget.dart';
import 'package:localacademy/screens/home/widgets/edit_student_widget.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext context, List<StudentModel> studentList,
          Widget? child) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = studentList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailStudentWidget(
                      age: data.age,
                      index: index,
                      mobileNumber: data.mobileNumber,
                      name: data.name,
                      photo: data.photo,
                      course: data.course,
                    ),
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    File(data.photo),
                  ),
                  radius: 30,
                ),
                title: Text(data.name),
                subtitle: Text(data.mobileNumber),
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditStudentWidget(
                                name: data.name,
                                age: data.age,
                                mobileNumber: data.mobileNumber,
                                course: data.course,
                                image: data.photo,
                                index: index,
                                photo: data.photo,
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteStudent(index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.green,
              thickness: 3,
              indent: 20,
              endIndent: 30,
            );
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}
