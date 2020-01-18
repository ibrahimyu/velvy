import 'package:shared_preferences/shared_preferences.dart';
import 'package:velvy/velvy.dart';

class UsernamePasswordAuthenticator extends Authenticator {
  @override
  Future<User> createUser({data}) async {
    return User();
  }

  @override
  Future<User> getUser({bool cache = false}) async {
    var result = await Velvy.instance.service('user').get('');

    return User.fromMap(result.data);
  }

  @override
  Future<User> login({credentials}) async {
    var result =
        await Velvy.instance.service('login').create(data: credentials);

    var pref = await SharedPreferences.getInstance();
    pref.setString('access_token', result.data['api_token']);

    return User.fromMap(result.data);
  }

  @override
  Future<bool> logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('access_token');

    return true;
  }

  @override
  Future<bool> check() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('access_token');

    if (token != null && token.isNotEmpty) {
      var result = await Velvy.instance.service('user').get('');

      if (result.data['id'] != null) {
        return true;
      }
    }

    return false;
  }
}
