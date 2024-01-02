import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  Task({
    required this.title,
  });
  @HiveField(0)
  String title;
}
