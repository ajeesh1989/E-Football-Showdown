import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_pre_hive_sampleproject/box.dart';
import 'package:shared_pre_hive_sampleproject/model/task.dart';
import 'package:shared_pre_hive_sampleproject/model2/task2.dart';
import 'package:shared_pre_hive_sampleproject/splash.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  // task1
  Hive.registerAdapter(Task2Adapter());
  // task2
  boxTasks = await Hive.openBox<Task>('TaskBox');
  // open1
  boxTasks2 = await Hive.openBox<Task>('TaskBox2');
  // open2

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
