import 'package:flutter_application_2/features/tugas/tugas_14_API_using/models/ghibli_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService {
  DbService._internal();

  static final DbService instance = DbService._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'ghibli_film.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          ''' CREATE TABLE ghibli (
              id TEXT PRIMARY KEY,
              title TEXT,
              original_title TEXT,
              original_title_romanised TEXT,
              image TEXT,
              movie_banner TEXT,
              description TEXT,
              director TEXT,
              producer TEXT,
              release_date TEXT,
              running_time TEXT,
              rt_score TEXT,
              people TEXT,
              species TEXT,
              locations TEXT,
              vehicles TEXT,
              url TEXT ) '''
        );
      }
    );
  }

  Future<void> saveFilm(Ghibli film) async {
    final db = await database;

    await db.insert(
      'ghibli',
      film.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Ghibli>> getSavedFilms() async {
    final db = await database;
    final maps = await db.query('ghibli');
    return maps.map((map) => Ghibli.fromMap(map)).toList();
  }

  Future<bool> isSaved(String id) async {
    final db = await database;
    final result = await db.query('ghibli', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }

  Future<void> deleteFilm(String id) async {
    final db = await database;
    await db.delete('ghibli', where: 'id = ?', whereArgs: [id]);
  }
}
