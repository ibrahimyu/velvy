class Query {
  String searchTerm;
  bool paginate;
  int page;
  List<WhereOp> _where;

  Query({
    this.searchTerm,
    this.paginate,
    this.page,
  }) {
    _where = List<WhereOp>();
  }

  void where(String field, dynamic value, {String op = '='}) {
    _where.add(WhereOp(field: field, value: value, op: op));
  }
}

class WhereOp {
  String field;
  String op;
  dynamic value;

  WhereOp({this.field, this.op, this.value});
}
