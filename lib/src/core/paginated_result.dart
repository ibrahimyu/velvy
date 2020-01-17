import 'dart:async';

import 'query_result.dart';

class PaginatedResult {
  StreamController<QueryResult> data;

  Stream<QueryResult> get stream => data.stream;
  Sink<QueryResult> get sink => data.sink;

  void goFirstPage() {}
}
