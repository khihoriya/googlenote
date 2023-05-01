import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class databaseclass {
  Future<Database> fordatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo1.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE detail (ID INTEGER PRIMARY KEY, title TEXT, notes text )');
    });
    return database;
  }

  Future<void> insertdata(String titlee, String notess ,Database database) async {
    String insert =
        "insert into detail (title,notes) values('$titlee','$notess')";
   int aa = await database.rawInsert(insert);
   print("====$aa");
  }

  Future<List<Map>> viewdata(Database database) async {
    String select = "select * from detail";
    List<Map> listt = await database.rawQuery(select);
    return listt;
  }

  Future<void> deletnote(int idd, Database database) async {
    String delete = "Delete from detail where id='$idd'";
   int abc= await database.rawDelete(delete);
  }

  void updatenote(String titlee, String notess, int iddd, Database database) {
    String update="update from detail set title='$titlee',notes='$notess' where ID='$iddd'";
    database.rawUpdate(update);
  }
}
