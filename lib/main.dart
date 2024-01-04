import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_pre_hive_sampleproject/box.dart';
import 'package:shared_pre_hive_sampleproject/model/task.dart';
import 'package:shared_pre_hive_sampleproject/model2/task2.dart';
import 'package:shared_pre_hive_sampleproject/model3/grouphomename.dart';
import 'package:shared_pre_hive_sampleproject/splash.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(Task2Adapter());
  Hive.registerAdapter(GrouphomenameAdapter());

  // Open the first box
  boxTasks = await Hive.openBox<Task>('TaskBox');

  // Open the second box
  boxTasks2 = await Hive.openBox<Task>('TaskBox2');

  // Open the third box
  grouphomename = await Hive.openBox<Grouphomename>('TaskBox3');

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
