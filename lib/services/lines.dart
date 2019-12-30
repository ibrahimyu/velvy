import 'package:velvy/src/core/service.dart';

class Line {
  int id;
  String name;

  Line({this.id, this.name});
}

class LineService extends Service<Line> {
  String url = 'http://nanoline.test/api/lines';
}
