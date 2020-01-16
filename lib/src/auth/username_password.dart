import 'package:shared_preferences/shared_preferences.dart';
import 'package:velvy/velvy.dart';

class UsernamePasswordAuthenticator extends Authenticator {
  @override
  Future<User> createUser({data}) async {
    return User();
  }

  @override
  Future<Map<String, String>> getHeaders() async {
    // harusnya ada shared preferences untuk nyimpen token.
    // nanti ada confignya, tapi saat ini nama tokennya kita
    // set access_token di secure storage.
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('access_token');

    return {
      'Authentication': 'Bearer $token',
    };
  }

  @override
  Future<User> getUser({bool cache = false}) async {
    var result = await Velvy.instance.service('user').get('');

    return result;
  }

  @override
  Future<User> login({credentials}) async {
    var result =
        await Velvy.instance.service('login').create(data: credentials);

    var pref = await SharedPreferences.getInstance();
    pref.setString('access_token', result['api_token']);

    return User.fromMap(result);
  }

  @override
  Future<bool> logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('access_token');

    return true;
  }
}
