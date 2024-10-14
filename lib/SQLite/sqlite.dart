import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:baidyet/JsonModels/users.dart';

class DatabaseHelper {
  final String dbName = "baidyet.db";
  String users =
      "CREATE TABLE user (userId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT UNIQUE, userPassword TEXT, createdAt DATETIME DEFAULT CURRENT_TIMESTAMP)";

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(users);
      },
    );
  }

  Future<bool> login(Users user) async {
    try {
      final Database db = await initDB();
      var result = await db.rawQuery(
        "SELECT * FROM user WHERE userName = ? AND userPassword = ?",
        [user.userName, user.userPassword],
      );
      return result.isNotEmpty;
    } catch (e) {
      print("Error during login: $e");
      rethrow;
    }
  }

  Future<int> signUp(Users user) async {
    try {
      final Database db = await initDB();
      return await db.insert('user', user.toMap());
    } catch (e) {
      print("Error during sign up: $e");
      rethrow;
    }
  }
}
