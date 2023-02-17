import 'package:flutter/material.dart';
import 'package:localacademy/database/functions/db_functons.dart';
import 'package:localacademy/screens/home/widgets/add_student_widget.dart';
import 'package:localacademy/screens/home/widgets/list_student_widget.dart';
import 'package:localacademy/screens/home/widgets/search_students.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // @override
  // void initState() {
  //   super.initState();
  //   getAllStudents();
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // getAllStudents();
    });
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchStudent(),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: const SafeArea(
        child: ListStudentWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudentWidget(),
            ),
          );
        },
      ),
    );
  }
}
