import 'package:velvy/src/core/service.dart';

import 'app_config.dart';

class App {
  static AppConfig config = AppConfig();

  String baseUrl;

  App({this.baseUrl}) {
    if (baseUrl == null) {
      baseUrl = config.url;
    }
  }

  Service<T> service<T>(
    String name, {
    Map<String, String> headers,
  }) {
    return Service<T>(
      url: '$baseUrl/$name',
      defaultHeaders: config.defaultHeaders..addAll(headers),
    );
  }
}
