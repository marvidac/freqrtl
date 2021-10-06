import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProvideDB {
  static final _databaseName    = "rtlfreq_20211006.db";
  static final _databaseVersion = 2;

  static final ProvideDB instance = ProvideDB._init();

  //Torna a classe singleton
  ProvideDB._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: (db, version) {
            _createAllTables(db, version);
        },
        onUpgrade: (db, oldVersion, newVersion) {
          if (oldVersion == 1) {
            _dropTables(db.batch());
            _createAllTables(db, 2);
            _insertTestRegisters(db);
          }
        }
    );
  }

  Future _createAllTables(Database db, int version) async {
    await db.execute ('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            login TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            dateTime TEXT NOT NULL,
            firstLogin INTEGER,
            synchronized INTEGER,
            synchronizedDateTime TEXT
          )
          ''');
    await db.execute ('''
          CREATE TABLE frequency (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user TEXT NOT NULL,
            dateTime TEXT NOT NULL,
            synchronized INTEGER,
            synchronizedDateTime TEXT,
            FOREIGN KEY (user) REFERENCES user(login)
          )
          ''');
    await db.execute ('''
          CREATE TABLE employee (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user TEXT NOT NULL,
            firstName TEXT NOT NULL,
            lastName TEXT,
            birthday TEXT,
            email TEXT,
            userAdm TEXT NOT NULL,
            dateTime TEXT NOT NULL,
            synchronized INTEGER,
            synchronizedDateTime TEXT,
            FOREIGN KEY (user) REFERENCES user(login)
          )
          ''');
    await _insertTestRegisters(db);
  }

  _dropTables(Batch batch) async {
    batch.execute('DROP TABLE frequency');
    await batch.commit();
  }

  _insertTestRegisters(db) async {
    await db.execute('''
     INSERT INTO user (login, password, dateTime, firstLogin, synchronized, synchronizedDateTime) 
     VALUES('marvidac', 'marvidac', '2021-10-01 14:36', 1, 0, '')    
    ''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
