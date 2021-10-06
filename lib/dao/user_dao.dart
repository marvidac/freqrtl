import 'package:rtlfreq/dao/provide_db.dart';
import 'package:rtlfreq/model/user.dart';

class UserDao {

  static Future getByLoginAndPassword(String login, String password) async {
    final db = await ProvideDB.instance.database;

    List maps = await db.rawQuery("SELECT * FROM 'user' WHERE login='$login' and password='$password'");

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }

    return null;
  }

  static Future<User> save(User user)  async {
    final db = await ProvideDB.instance.database;
    User freq = user;

    if (user.id == null) {
      freq = await db.insert(tableUser, user.toJson()).then((id) => user.copy(id: id));
    } else {
      db.update(
        tableUser,
        user.toJson(),
        where: '${UserFields.id} = ?',
        whereArgs: [user.id],
      );
    }

    return freq;
  }

  static Future<int> delete(int? id) async {
    final db = await ProvideDB.instance.database;

    return await db.delete(
      tableUser,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }
}
