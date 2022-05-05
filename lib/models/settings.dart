import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 0)
class SettingsModel {
  // zero for light and 1 for black
  SettingsModel({required this.theme, required this.language});
  @HiveField(0)
  bool theme;
  @HiveField(1)
  String language;
}
