import 'package:velvy/velvy.dart';

class QueryResult {
  List<DocumentResult> documents;
  final int status;

  QueryResult({
    this.documents,
    this.status,
  });
}
