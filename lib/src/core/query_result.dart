import 'package:velvy/velvy.dart';

class QueryResult {
  List<DocumentResult> documents;
  int status;
  int currentPage;
  int lastPage;

  QueryResult({
    this.documents,
    this.status,
    this.currentPage,
    this.lastPage,
  });
}
