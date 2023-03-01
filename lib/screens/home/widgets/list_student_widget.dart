import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localacademy/controller/controller.dart';
import 'package:localacademy/screens/home/widgets/details_student_widget.dart';
import 'package:localacademy/screens/home/widgets/edit_student_widget.dart';
import 'package:provider/provider.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderStudent>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.foundUsers.isNotEmpty) {
          log('List of student if not empty');
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx, index) {
              final data = value.foundUsers[index];
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
                                  id: data.id,
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
                          ProviderStudent.deleteItem(
                              context, data.id.toString());
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
            itemCount: value.foundUsers.length,
          );
        } else {
          return const Center(
            child: Text(
              'Add some students',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        }
      },
    );
  }
}
