import 'package:shared_preferences/shared_preferences.dart';
import 'package:velvy/src/core/service.dart';
import 'package:velvy/velvy.dart';

class Velvy {
  static Velvy instance = Velvy();

  String url;
  Map<String, String> defaultHeaders;

  Velvy() {
    reload();
  }

  Service<T> service<T>(
    String name, {
    Map<String, String> headers,
  }) {
    return Service<T>(
      url: '$url/$name',
    );
  }

  Authenticator auth;

  void reload() async {
    defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('access_token');

    if (token != null) {
      defaultHeaders['Authorization'] = 'Bearer $token';
    }
  }
}
