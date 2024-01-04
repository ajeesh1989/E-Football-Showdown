import 'dart:ui';

import 'package:hive/hive.dart';

part 'grouphomename.g.dart';

// ignore: camel_case_types
@HiveType(typeId: 3)
class Grouphomename {
  Grouphomename({
    required this.playernamegroup,
  });
  @HiveField(0)
  String playernamegroup;
}
