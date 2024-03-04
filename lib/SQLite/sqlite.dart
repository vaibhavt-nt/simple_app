import 'package:path/path.dart';
import 'package:simple_app/jsonModels/users.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "notes.db";

  //Now we must create our user table into our sqlite db
  String users = "create table users ("
      "usrId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " userName TEXT ,"
      "userEmail TEXT UNIQUE,"
      "userPassword TEXT)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
    });
  }

  //Now we create login and sign up method
  //Login Method

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    // I forgot the password to check
    var result = await db.rawQuery("select * from users where userEmail ="
        " '${user.userEmail}' AND userPassword = '${user.userPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDB();

    return db.insert('users', user.toJson());
  }

// check user exixt to avoid duplicate entry

  Future<bool> checkUserExist(String username) async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> res =
        await db.query("users", where: "userEmail = ?", whereArgs: [username]);
    return res.isNotEmpty;
  }
}
