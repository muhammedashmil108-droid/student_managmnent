import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('students');
  runApp(Studentapp());
}

class Studentapp extends StatelessWidget {
  const Studentapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Studentapp",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
