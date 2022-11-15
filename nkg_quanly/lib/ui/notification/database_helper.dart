import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'notification_model_db.dart';


class DatabaseHelper{
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();
  static Database? _database;
  final String db_name = "notification.db";
  final String db_table = "notification_table";

  Future<Database> get database async {
    if (_database != null) {
      Directory dr = await getApplicationDocumentsDirectory();
      print("db loca: ${dr.path}");
      return _database!;
    } else {
      _database = await initDb();
      return _database!;
    }
  }

  initDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), db_name),
      onCreate: (db, version) {
        return db.execute(
        'CREATE TABLE $db_table(id TEXT PRIMARY KEY, workbookId TEXT, workName TEXT, status TEXT, action TEXT, isDeleted TEXT, createdDate TEXT, lastModifiedDate TEXT, createdBy TEXT, lastModifiedBy TEXT, isClick TEXT)',
        );
      },
      version: 1,
    );
  }

  insertDB(NotificationModelDB databaseModel) async {
    final db = await database;
    await db.insert(
      db_table,
      databaseModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NotificationModelDB>> getDataDB() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(db_table);
    return List.generate(maps.length, (i) {
      return NotificationModelDB(
        id: maps[i]['id'],
        workbookId: maps[i]['workbookId'],
        workName: maps[i]['workName'],
        status: maps[i]['status'].toString(),
        action: maps[i]['action'],
        isDeleted: maps[i]['isDeleted'].toString(),
        createdDate: maps[i]['createdDate'],
        lastModifiedDate: maps[i]['lastModifiedDate'],
        createdBy: maps[i]['createdBy'],
        lastModifiedBy: maps[i]['lastModifiedBy'],
        isClick: maps[i]['isClick'].toString(),
      );
    }).toList();
  }

  updateDB(NotificationModelDB databaseModel) async {
    final db = await database;
    await db.update(
      db_table,
      databaseModel.toMap(),
      where: 'id = ?',
      whereArgs: [databaseModel.id],
    );
  }
  updateIclickStatusDB(NotificationModelDB databaseModel) async {
    final db = await database;
    await db.update(
      db_table,
      databaseModel.toMap(),
      where: 'id = ?',
      whereArgs: [databaseModel.id],
    );
  }

  deleteDB(String id) async {
    final db = await database;
    await db.delete(
      db_table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}