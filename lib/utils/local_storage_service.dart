import 'package:finndata_project/constants/app_constants.dart';
import 'package:finndata_project/models/settings.dart';
import 'package:hive/hive.dart';

import '../models/symbol_result.dart';

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

class StockSubscriptionsStorage {
  late Box<SymbolResultModel> _subscriptions;

  Future<void> init() async {
    Hive.registerAdapter(SymbolResultModelAdapter());
    _subscriptions = await Hive.openBox<SymbolResultModel>('mySubscriptions');
    myStocks = _subscriptions.values.toList();
  }

  Future<void> removeSubscription(SymbolResultModel newSubscription) async {
    _subscriptions = await Hive.openBox<SymbolResultModel>('mySubscriptions');

    await _subscriptions.delete(newSubscription.symbol);
  }

  Future<void> addSubscription(SymbolResultModel newSubscription) async {
    _subscriptions = await Hive.openBox<SymbolResultModel>('mySubscriptions');

    await _subscriptions.put(newSubscription.symbol, newSubscription);
  }
}
