import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localacademy/controller/controller.dart';
import 'package:localacademy/database/functions/db_functons.dart';
import 'package:localacademy/database/model/student_data_model.dart';
import 'package:localacademy/screens/home/screen_home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderStudent()),
        ChangeNotifierProvider(create: (context) => DBFunctions()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red,
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
