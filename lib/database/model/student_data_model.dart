import 'package:hive_flutter/adapters.dart';
part 'student_data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String mobileNumber;

  @HiveField(4)
  final String course;

  @HiveField(5)
  final String photo;

  StudentModel(
      {required this.name,
      required this.age,
      required this.mobileNumber,
      required this.course,
      required this.photo,
      this.id});
}
