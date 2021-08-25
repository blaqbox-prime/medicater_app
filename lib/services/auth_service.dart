import 'package:medicater_app/models/user.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

class AuthService {
  AuthService();
  final db = MysqlService();

  Future<User> login(String username, String password) async {
    final User user = await db.login(username, password);

    return user;
  }
}
