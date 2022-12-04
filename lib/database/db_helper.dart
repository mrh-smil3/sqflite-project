// dbhelper dibuat untuk membuat CRUD database

import 'dart:ffi';

import 'package:project_shared/model/mahasiswa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  //inisial beberapa variable yang digunakan
  final String tableName = 'tableMhs';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnNim = 'nim';
  final String columnEmail = 'email';
  final String columnProdi = 'prodi';

  DbHelper._internal();
  factory DbHelper() => _instance;

  // mengecek database
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mhs.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // membuat table dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
        "$columnNama TEXT, "
        "$columnNim TEXT, "
        "$columnEmail TEXT, "
        "$columnProdi TEXT )";
    await db.execute(sql);
  }

  // insert database
  Future<int?> saveMhs(Mahasiswa mhs) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, mhs.toMap());
  }

  // read database
  Future<List?> getAllMhs() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName,
        columns: [columnId, columnNama, columnProdi, columnNim, columnEmail]);
    return result.toList();
  }

  // update database
  Future<int?> updateMhs(Mahasiswa mhs) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, mhs.toMap(),
        where: '$columnId = ?', whereArgs: [mhs.id]);
  }

  // hapus database
  Future<int?> deleteMhs(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
