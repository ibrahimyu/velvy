import 'package:flutter_test/flutter_test.dart';
import 'package:velvy/src/core/app.dart';

void main() {
  test('gets data', () async {
    var res = await (App(baseUrl: 'http://nanoline.test/api')
        .service('lines')
        .find());

    expect(res, isNotNull);
  });

  test('coba insert data', () async {
    var app = App(baseUrl: 'http://nanoline.test/api');
    var service = app.service('lines');

    var result = await service.create(data: {'name': 'Line A'});

    expect(result, isNotNull);
  });
}
