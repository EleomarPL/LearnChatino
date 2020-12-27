import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart' as path;
import '../database/ObjectTables.dart';

class MainDatabase {
  Database _db;
  List<String> tablesDB = [
    'CREATE TABLE wordFavorites('
        'idUser INTEGER NOT NULL,'
        'wordSpanish VARCHAR(30) NOT NULL,'
        'wordChatino VARCHAR(30) NOT NULL,'
        'pathImage TEXT NOT NULL,'
        'pathSound TEXT NOT NULL);',
    'CREATE TABLE progressUser('
        'idUser INTEGER NOT NULL,'
        'levelAdvance INTEGER NOT NULL,'
        'lessonAdvance INTEGER NOT NULL,'
        'exercise INTEGER NOT NULL);'
  ];
  initDB() async {
    _db = await openDatabase(
      path.join(await getDatabasesPath(), 'created_database.db'),
      onCreate: (db, version) {
        db.transaction((txn) async {
          for (String query in tablesDB) {
            await txn.execute(query);
          }
        });
        return db.execute('CREATE TABLE user('
            'idUser INTEGER PRIMARY KEY autoincrement,'
            'nameUser VARCHAR(30) NOT NULL,'
            'userUser VARCHAR(30) NOT NULL,'
            'typeUser INTEGER NOT NULL);');
        //}
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

  Future<int> queryUser(String user) async {
    List<Map<String, dynamic>> results =
        await _db.rawQuery('SELECT * FROM user WHERE  userUser = ?', ['$user']);
    return (results.length == 0) ? null : results[0]['idUser'];
  }

  Future<Map<String, dynamic>> listInformationUser(String user) async {
    List<Map<String, dynamic>> results =
        await _db.rawQuery('SELECT * FROM user WHERE  userUser = ?', ['$user']);
    return (results.length == 0) ? null : results[0];
  }

  Future<List<ProgressUser>> getProgressUser(int idUser) async {
    List<Map<String, dynamic>> data = await _db.rawQuery(
        'SELECT * FROM progressUser WHERE idUser = ? ORDER BY levelAdvance AND lessonAdvance',
        ['$idUser']);
    return data.map((map) => ProgressUser.toMap(map)).toList();
  }

  Future<void> registerInitialAdvanceLevel(int idUser, int numLevels) async {
    for (int i = 0; i < numLevels; i++) {
      await _db.insert(
          'progressUser', ProgressUser(idUser, i + 1, 1, 0).toMap());
      await _db.insert(
          'progressUser', ProgressUser(idUser, i + 1, 2, 0).toMap());
      await _db.insert(
          'progressUser', ProgressUser(idUser, i + 1, 3, 0).toMap());
    }
  }

  Future<List<WordFavorites>> getWordFavorites(int idUser) async {
    List<Map<String, dynamic>> data = await _db
        .rawQuery('SELECT * FROM wordFavorites WHERE idUser = ?', ['$idUser']);
    return data.map((map) => WordFavorites.toMap(map)).toList();
  }

  Future<void> insertWordFavorite(WordFavorites word) async {
    await _db.insert('wordFavorites', word.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<bool> existThisWordInFavorite(String word) async {
    List<Map<String, dynamic>> data = await _db.rawQuery(
        'SELECT * FROM wordFavorites WHERE wordSpanish = ?', ['$word']);
    return (data.length == 0) ? false : true;
  }

  Future<void> deleteWord(String wordInSpanish) async {
    await _db.delete(
      'wordFavorites',
      where: "wordSpanish = ?",
      whereArgs: ['$wordInSpanish'],
    );
  }
}
