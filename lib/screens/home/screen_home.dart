import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localacademy/controller/controller.dart';
import 'package:localacademy/screens/home/widgets/add_student_widget.dart';
import 'package:localacademy/screens/home/widgets/list_student_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<ProviderStudent>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider.getAllStudents();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ProviderStudent>(
            builder: (context, value, Widget? child) {
              return Column(
                children: [
                  CupertinoSearchTextField(
                    padding: const EdgeInsets.all(15),
                    borderRadius: BorderRadius.circular(15),
                    prefixIcon:
                        const Icon(CupertinoIcons.search, color: Colors.black),
                    style: const TextStyle(color: Colors.black),
                    backgroundColor: Colors.grey.shade300,
                    controller: searchController,
                    onChanged: (value) {
                      Provider.of<ProviderStudent>(context, listen: false)
                          .runFilter(value);
                    },
                  ),
                  const Expanded(
                    child: ListStudentWidget(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProviderStudent>().uPhoto = null;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudentWidget(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
