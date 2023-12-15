/*import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'DatabaseHelper.dart';

class DatabaseInitializer {
  static late Database _database;
  static final DatabaseInitializer _instance = DatabaseInitializer._internal();

  factory DatabaseInitializer() => _instance;

  DatabaseInitializer._internal();

  Future<Database> initializeDatabase() async {
    if (_database.isOpen) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  Future<Database> _initDatabase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, 'user.db');
      var userDatabase = await openDatabase(path, version: 1, onCreate: _createDatabase);
      return userDatabase;
    } catch (e) {
      print('Error initializing database: $e');
      // Handle the error as needed
      throw e;
    }
  }

  void _createDatabase(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE user_table(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, surname TEXT, email TEXT, password TEXT)');
  }

  Future<DatabaseHelper> getDatabaseHelper() async {
    Database database = await initializeDatabase();
    return DatabaseHelper(database);
  }
}
*/