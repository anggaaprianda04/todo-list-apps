import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/todo_model.dart';

class DatabaseInstance {
  final String _databaseName = "my_database.db";
  final int _databaseVersion = 1;

  // Todo Table
  final String table = "todo";
  final String id = "id";
  final String title = "title";
  final String desc = "desc";
  final String createdAt = "created_at";
  final String updatedAt = "updated_at";

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $title TEXT, $desc TEXT NULL, $createdAt TEXT NULL, $updatedAt TEXT NULL)');
  }

  Future<List<TodoModel>> getAll() async {
    _database ??= await database();
    await Future.delayed(const Duration(seconds: 1));
    final data = await _database!.query(table);
    List<TodoModel> result = data.map((e) => TodoModel.fromJson(e)).toList();
    // print(result);
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(table, row);
    return query;
  }

  Future delete(int idParams) async {
    await _database!.delete(table, where: '$id = ?', whereArgs: [idParams]);
  }
}
