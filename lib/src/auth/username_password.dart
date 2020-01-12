import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    var token = FlutterSecureStorage().read(key: 'access_token');

    return {
      'Authentication': 'Bearer $token',
    };
  }

  @override
  Future<User> getUser({bool cache = false}) async {
    var result = await Velvy().service<User>('auth').get('');

    return result;
  }

  @override
  Future<User> login({credentials}) async {
    // TODO: implement login
    var result = await Velvy().service<User>('auth').find(query: credentials);

    if (result.length != 1) {
      throw 'Login error';
    } else {
      FlutterSecureStorage storage = FlutterSecureStorage();
      storage.write(key: 'access_token', value: result[0].accessToken);
    }
  }

  @override
  Future<bool> logout() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    storage.delete(key: 'access_token');

    return true;
  }
}
