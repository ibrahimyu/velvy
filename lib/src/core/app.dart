import 'package:velvy/src/core/service.dart';

class App {
  String baseUrl;

  App({this.baseUrl});

  Service<T> service<T>(
    String name, {
    Map<String, String> headers,
  }) {
    return Service<T>(
      url: '$baseUrl/$name',
      defaultHeaders: headers,
    );
  }
}
