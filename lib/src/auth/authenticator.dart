import 'package:velvy/src/auth/user.dart';

abstract class Authenticator {
  Future<Map<String, String>> getHeaders();
  Future<User> login({dynamic credentials});
  Future<bool> logout();
  Future<User> createUser({dynamic data});
  Future<User> getUser();
}
