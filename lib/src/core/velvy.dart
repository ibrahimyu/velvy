import 'package:velvy/src/core/service.dart';

import 'velvy_config.dart';

class Velvy {
  static VelvyConfig config = VelvyConfig();

  String baseUrl;

  Velvy({this.baseUrl}) {
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
