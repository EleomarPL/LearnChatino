import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart' as path;
import '../database/ObjectTables.dart';

class MainDatabase {
  Database _db;
  List<String> tablesDB = [
    'CREATE TABLE user('
        'idUser INTEGER PRIMARY KEY autoincrement,'
        'nameUser VARCHAR(30) NOT NULL,'
        'userUser VARCHAR(30) NOT NULL,'
        'typeUser INTEGER NOT NULL);',
    'CREATE TABLE wordFavorites('
        'wordSpanish VARCHAR(30) NOT NULL,'
        'wordChatino VARCHAR(30) NOT NULL,'
        'pathImage TEXT NOT NULL,'
        'pathSound TEXT NOT NULL);',
    'CREATE TABLE progress('
        'idUser INTEGER NOT NULL,'
        'levelAdavance INTEGER NOT NULL,'
        'lessonAdavance INTEGER NOT NULL'
        'exercise INTEGER NOT NULL);',
  ];
  initDB() async {
    _db = await openDatabase(
      path.join(await getDatabasesPath(), 'created_database.db'),
      onCreate: (db, version) {
        for (String query in tablesDB) {
          return db.execute(query);
        }
      },
      version: 1,
    );
    print('Database inicializada');
  }

  Future<void> insertUser(User user) async {
    await _db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
