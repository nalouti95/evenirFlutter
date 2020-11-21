

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {


static final _dbName = 'myDatabase.db';
static final _dbVersion = 1;
static final _tablename = 'myEvent';
static final columid = '_id';
static final columtitre = 'titre';
static final columimg = 'img';






//making it a singleton class

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

static Database _database ;

Future<Database> get database async{

  if(_database != null) {
    return _database ;
  }
  _database = await _initiateDatabase ();

  return _database ;

}

  _initiateDatabase () async{

  Directory directory = await getApplicationDocumentsDirectory();
  String path = join(directory.path,_dbName);

 return await openDatabase(path,version: _dbVersion,onCreate: _onCreate);

  }

  Future _onCreate(Database db, int version){
//new table

  db.execute(

      '''
      CREATE TABLE $_tablename( 
      $columid INTEGER PRIMARY KEY ,
      $columtitre TEXT NOT NULL,
      $columimg TEXT NOT NULL)
      
      '''

      );


  }



  Future<int> insert(Map<String,dynamic> row) async {
  Database db = await instance.database;
  return await db.insert(_tablename, row);

  }

  Future<List<Map<String,dynamic>>> QueryAll() async {
    Database db = await instance.database;
    return await db.query(_tablename);


  }

  Future<int> Update (Map<String,dynamic> row) async {
    Database db = await instance.database;
    int id = row[columid];
    return await db.update(_tablename, row,where: '$columid = ?',whereArgs: [id]);


  }

  Future<int> Delete(int id) async {
    Database db = await instance.database;

    return await db.delete(_tablename,where: '$columid = ?',whereArgs: [id]);


  }


}