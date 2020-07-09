import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'todo.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTable';

  static final columnId = '_id';
  static final columnName = 'name';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  // this function returns the data base
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    //initilize the data base here. at this path
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_tableName (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL
      )
      ''');
  }
// we can communicate with data base only by json objects

/* 
eg :
{
  "_id": 1,
  "name": "sriram"
}

*/

  // CURD OPERATIONS

  Future<int> insert(Map<String, dynamic> row) async {
    // get the database
    //                           this is a getter for defination check above
    Database db = await instance.database;
    //returns the document id which is unique
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    // you will update a row
    Database db = await instance.database;
    int id = row[columnId];
    return db.update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);

    // this returns the number of rows updated
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
