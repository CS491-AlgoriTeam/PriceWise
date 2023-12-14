import 'dart:async';
import 'dart:io';

import 'package:pwfe/classes/Product.dart';
import 'package:pwfe/classes/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static late Database _database;

  String userTable = 'userTable';
  String colUserId = 'userID';
  String colUserName = 'userName';
  String colUserSurname = 'userSurname';
  String colUserEmail = 'userEmail';
  String colUserPassword = 'userPassword';

  String productTable = 'productTable';
  String colProductName = 'productName';
  String colProductPrice = 'productPrice';

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    print("get database called");
    if (_database.isOpen) {
      return _database;
    } else {
      return await initDatabase();
    }
  }

  Future<Database> initDatabase() async {
    try {
      print("init database called");
      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, 'userTable.db');
      var userDatabase =
          await openDatabase(path, version: 1, onCreate: _createDatabase);
      _database = userDatabase;
      return _database;
    } catch (e) {
      print('Error initializing database: $e');
      // Handle the error as needed
      throw e;
    }
  }

  void _createDatabase(Database db, int newVersion) async {
    print("create database called");
    await db.execute(
        'CREATE TABLE $userTable($colUserId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserName TEXT, $colUserSurname TEXT, $colUserEmail TEXT, $colUserPassword TEXT);');
    await db.execute(
        'CREATE TABLE $productTable($colProductName TEXT, $colProductPrice REAL);');
  }

  // User table methods
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    final Database db = await database;
    return await db.query(userTable);
  }

  Future<int> insertUser(User user) async {
    var db = await database;
    return await db.insert(userTable, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateUser(User user) async {
    var db = await database;
    return await db.update(userTable, user.toMap(),
        where: '$colUserId = ?',
        whereArgs: [user.getUserID()],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteUser(int id) async {
    var db = await database;
    return await db
        .rawDelete('DELETE FROM $userTable WHERE $colUserId = ?', [id]);
  }

  // product table methods
  Future<List<Map<String, dynamic>>> getProductMapList() async {
    final Database db = await database;
    return await db.query(productTable);
  }

  Future<int> insertProduct(Product product) async {
    var db = await database;
    return await db.insert(productTable, product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateProduct(Product product) async {
    var db = await database;
    return await db.update(productTable, product.toMap(),
        where: '$colProductName = ?',
        whereArgs: [product.getProductName()],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
