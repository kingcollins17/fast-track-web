import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const statebox = 'states';

mixin SaveableState<T> on Object {
  /// Unique storage key
  String get key;

  T get value;

  T fromJson(json);

  Map<String, dynamic> toJson(T state);

  Box _getBox() => Hive.box(statebox);

  /// Load state synchronously from device storage
  T? load() {
    final data = _getBox().get(key);
    if (data != null) return fromJson(data);
    return null;
  }

  /// Save state to device storage
  Future<void> save() async {
    _getBox().put(key, toJson(value));
  }

  /// Delete a saved state
  void delete() {
    _getBox().delete(key);
  }
}
