import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task2.g.dart';

@HiveType(typeId: 2)
class Task2 {
  Task2({
    required this.title,
  });
  @HiveField(0)
  String title;
}
