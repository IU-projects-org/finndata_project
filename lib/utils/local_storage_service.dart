import 'package:finndata_project/constants/appConstants.dart';
import 'package:finndata_project/models/settings.dart';
import 'package:hive/hive.dart';

// class HiveService {
//     adapters.forEach((element) {
//       Hive.registerAdapter(adapter);
//
//     });
//     // }
//     _tasks = await Hive.openBox<Task>('tasks');
//   Future<void> init(List adapters) async {
//
//     // await _tasks.clear();
//     //
//     // await _tasks.add(Task('testuser1', 'Subscribe to Flutter From Scratch', true));
//     // await _tasks.add(Task('flutterfromscratch', 'Comment on the video', false));
//   }
//   isExists({required String boxName}) async {
//     final openBox = await Hive.openBox(boxName);
//     int length = openBox.length;
//     return length != 0;
//   }
//
//   addBoxes<T>(List<T> items, String boxName) async {
//     print("adding boxes");
//     final openBox = await Hive.openBox(boxName);
//
//     for (var item in items) {
//       openBox.add(item);
//     }
//   }
//
//   getBoxes<T>(String boxName) async {
//     List<T>? boxList = List<T>();
//
//     final openBox = await Hive.openBox(boxName);
//
//     int length = openBox.length;
//
//     for (int i = 0; i < length; i++) {
//       boxList.add(openBox.getAt(i));
//     }
//
//     return boxList;
//   }
// }

class SettingsStorage {
  late Box<SettingsModel> _settings;

  Future<void> init() async {
    Hive.registerAdapter(SettingsModelAdapter());
    _settings = await Hive.openBox<SettingsModel>('settings');
    if (_settings.values.isNotEmpty) {
      appSettings = _settings.values.toList()[0];
    } else {
      await _settings.put('settings', appSettings);
    }
  }

  Future<void> update() async {
    _settings = await Hive.openBox<SettingsModel>('settings');
    await _settings.put('settings', appSettings);
  }
}

// class StockSubscriptionsStorage {
//   late Box<SymbolResultModel> _tasks;
//
//   Future<void> init() async {
//     Hive.registerAdapter(TaskAdapter());
//     _tasks = await Hive.openBox<Task>('tasks');
//
//     // await _tasks.clear();
//     //
//     // await _tasks.add(Task('testuser1', 'Subscribe to Flutter From Scratch', true));
//     // await _tasks.add(Task('flutterfromscratch', 'Comment on the video', false));
//   }
//
//   List<Task> getTasks(final String username) {
//     final tasks = _tasks.values.where((element) => element.user == username);
//     return tasks.toList();
//   }
//
//   void addTask(final String task, final String username) {
//     _tasks.add(Task(username, task, false));
//   }
//
//   Future<void> removeTask(final String task, final String username) async {
//     final taskToRemove = _tasks.values.firstWhere((element) => element.task == task && element.user == username);
//     await taskToRemove.delete();
//   }
//
//   Future<void> updateTask(final String task, final String username) async {
//     final taskToEdit = _tasks.values.firstWhere((element) => element.task == task && element.user == username);
//     final index = taskToEdit.key as int;
//     await _tasks.put(index, Task(username, task, !taskToEdit.completed));
//   }
// }
