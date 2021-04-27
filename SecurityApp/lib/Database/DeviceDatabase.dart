import 'package:flutter/foundation.dart';
import 'package:Metropolitane/model/DeviceModel.dart';
import 'package:sqflite/sqflite.dart';

enum DbPrefTableName { devices_list, event_list }

abstract class DeviceDatabase {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'Internationaltrafic';
      _db = await openDatabase(_path,
          version: _version, onCreate: _createDbListTables);
    } catch (ex) {
      print(ex);
    }
  }

  static void _createDbListTables(Database db, int newVersion) async {
    Batch batch = db.batch();
    batch.execute(
        "CREATE TABLE ${describeEnum(DbPrefTableName.devices_list)} (id INTEGER PRIMARY KEY AUTOINCREMENT, devicename STRING, deviceid STRING)");
    batch.execute(
        "CREATE TABLE ${describeEnum(DbPrefTableName.event_list)} (id INTEGER PRIMARY KEY AUTOINCREMENT, time STRING, devicename STRING , eventname STRING)");
    List<dynamic> res = await batch.commit();

//Insert your controls
  }

  static void onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE devices_list (id INTEGER PRIMARY KEY AUTOINCREMENT, devicename STRING, deviceid STRING)');

  static Future<List<Map<String, dynamic>>> query(
          DbPrefTableName dbPrefKey) async =>
      _db.query(describeEnum(dbPrefKey));

  static Future<int> insertDeviceModel(
          DbPrefTableName dbPrefKey, DeviceModel model) async =>
      await _db.insert(describeEnum(dbPrefKey), model.toMap());

  static Future<int> updateDeviceModel(String table, DeviceModel model) async =>
      await _db
          .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> deleteDeviceModel(
          DbPrefTableName dbPrefKey, DeviceModel model) async =>
      await _db.delete(describeEnum(dbPrefKey),
          where: 'id = ?', whereArgs: [model.id]);




}
