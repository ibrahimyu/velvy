class Query {
  String searchTerm;
  List<String> eagerLoads;
  bool paginate;
  int page;
  List<WhereOp> _where;
  String sort;
  bool descending;

  Query({
    this.searchTerm,
    this.paginate,
    this.page,
    this.eagerLoads,
  }) {
    _where = List<WhereOp>();
  }

  void where(String field, dynamic value, {String op = '='}) {
    _where.add(WhereOp(field: field, value: value, op: op));
  }

  void eagerLoad(String relation) {
    eagerLoads.add(relation);
  }

  String build(String prefix, String service) {}
}

class WhereOp {
  String field;
  String op;
  dynamic value;

  WhereOp({this.field, this.op, this.value});
}
