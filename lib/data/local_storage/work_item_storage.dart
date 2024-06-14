import 'dart:convert';

import 'package:invoice_calculator/data/local_storage/storage.dart';
import 'package:invoice_calculator/domain/models/work_item.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkItemStorage implements Storage<List<WorkItem>> {
  WorkItemStorage(this._sharedPreferences);

  final _valueSubject = BehaviorSubject<List<WorkItem>>.seeded([]);

  final SharedPreferences _sharedPreferences;

  @override
  Future<List<WorkItem>> get value async {
    final json = _sharedPreferences.getString('work_items');
    if (json == null) {
      return [];
    }
    final workItems = (jsonDecode(json) as List?)
            ?.map((e) => WorkItem.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    _valueSubject.add(workItems);
    return workItems;
  }

  @override
  Stream<List<WorkItem>> get valueStream => _valueSubject.stream;

  @override
  Future<void> save(List<WorkItem> items) async {
    await _sharedPreferences.setString(
      'work_items',
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
    _valueSubject.add(items);
  }

  @override
  Future<void> delete() async {
    await _sharedPreferences.remove('work_items');
    _valueSubject.add([]);
  }
}
