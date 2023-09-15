import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbControllar{

  static final DbControllar _instance = DbControllar.internal();
  late Database _dataBase;

  DbControllar.internal();

  factory DbControllar(){
    return _instance;
  }

  Database get database => _dataBase;

  Future<void> initDatabase () async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path , 'app_db.sql');
    _dataBase = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version)async {
        await db.execute('CREATE TABLE contacts('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'phone TEXT NOT NULL'
            ')');
      },
      onUpgrade: (db, oldVersion, newVersion) {},
      onDowngrade: (db, oldVersion, newVersion) {},

    );
  }

}