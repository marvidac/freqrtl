import 'package:rtlfreq/dao/user_dao.dart';

class UserBusiness {

  getByLoginAndPassword(String login, String password) async {
    return await UserDao.getByLoginAndPassword(login, password);
  }

  /*saveAndReturnUser(String login, String password) {
    User user = User(login: login, password: password, dateTime: Utils.getCurrentDateTime("yyyy-MM-dd HH:mm:ss"));
    return UserDao.save(user)
    .then( (usr) {
      return usr;
    })
    .catchError((error) => Exception(error));
  }*/

}