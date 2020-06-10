import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();
  static final _dbfilename = 'drwhatson.db';
  static AppDatabase get instance => _singleton;
  Completer<Database> _dbOpenCompleter;

  AppDatabase._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    if (kIsWeb) {
      var factory = databaseFactoryWeb;
      Database db = await factory.openDatabase(_dbfilename);
      _dbOpenCompleter.complete(db);
    } else {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _dbfilename);
      final db = await databaseFactoryIo.openDatabase(dbPath);
      _dbOpenCompleter.complete(db);
    }
  }
}
