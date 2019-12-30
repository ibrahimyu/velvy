import 'package:flutter_test/flutter_test.dart';
import 'package:velvy/services/lines.dart';
import 'package:velvy/src/core/app.dart';
import 'package:velvy/src/core/mapper.dart';

import 'package:velvy/velvy.dart';

void main() {
  test('gets data', () async {
    var app = App(baseUrl: 'http://localhost:3030');
    var service = app.service<Line>('lines');

    expect(await service.find(), isNotNull);
  });

  test('coba insert data', () async {
    var app = App(baseUrl: 'http://localhost:3030');
    var service = app.service<Line>('lines');

    var result = await service.create(data: {'name': 'Line A'});

    expect(result, isNotNull);
  });
}
