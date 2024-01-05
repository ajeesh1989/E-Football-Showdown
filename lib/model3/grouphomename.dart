import 'dart:ui';

import 'package:hive/hive.dart';

part 'grouphomename.g.dart';

@HiveType(typeId: 3)
class Grouphomename {
  Grouphomename({
    required this.playernamegroup,
  });
  @HiveField(0)
  String playernamegroup;
}
