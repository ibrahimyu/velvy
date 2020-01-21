import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velvy/velvy.dart';
import 'query_result.dart';
import 'query.dart';
import 'velvy.dart';

class Service {
  String url;
  Encoding encoding;

  Service({
    this.url,
    this.encoding,
  });

  Future<QueryResult> find({String params}) async {
    var headers = Velvy.instance.defaultHeaders;
    var response = await http.get(url + params, headers: headers);

    if (response.statusCode < 300) {
      var res = json.decode(response.body);
      List body;

      // if it's paginated, the real data would be on the data property.
      if (res is List) {
        body = res;

        return QueryResult(
          documents: body
              .map((i) => DocumentResult(data: i, status: response.statusCode))
              .toList(),
          status: response.statusCode,
        );
      } else {
        body = res['data'];

        return QueryResult(
          currentPage: res['current_page'],
          lastPage: res['last_page'],
          documents: body
              .map((i) => DocumentResult(data: i, status: response.statusCode))
              .toList(),
          status: response.statusCode,
        );
      }
    } else {
      return QueryResult(
        documents: null,
        status: response.statusCode,
      );
    }
  }

  Future<DocumentResult> create({data}) async {
    var headers = Velvy.instance.defaultHeaders;
    var response = await http.post(
      url,
      body: json.encode(data),
      headers: headers,
      encoding: encoding,
    );

    if (response.statusCode < 300) {
      var map = json.decode(response.body);
      var result = map;

      return DocumentResult(
        data: result,
        status: response.statusCode,
      );
    } else {
      return DocumentResult(
        data: null,
        status: response.statusCode,
      );
    }
  }

  Future<DocumentResult> get(dynamic id, {Map<String, String> headers}) async {
    var headers = Velvy.instance.defaultHeaders;
    var response = await http.get('$url/$id', headers: headers);

    if (response.statusCode < 300) {
      var result = json.decode(response.body);

      return DocumentResult(
        data: result,
        status: response.statusCode,
      );
    } else {
      return DocumentResult(
        data: null,
        status: response.statusCode,
      );
    }
  }

  Future<DocumentResult> update(dynamic id, {data}) async {
    var headers = Velvy.instance.defaultHeaders;
    var response = await http.put(
      '$url/$id',
      body: json.encode(data),
      headers: headers,
      encoding: encoding,
    );

    if (response.statusCode < 300) {
      var result = json.decode(response.body);

      return DocumentResult(
        data: result,
        status: response.statusCode,
      );
    } else {
      return DocumentResult(
        data: null,
        status: response.statusCode,
      );
    }
  }

  Future<DocumentResult> destroy(dynamic id,
      {Map<String, String> headers}) async {
    var headers = Velvy.instance.defaultHeaders;
    var response = await http.delete('$url/$id', headers: headers);

    if (response.statusCode < 300) {
      var result = json.decode(response.body);

      return DocumentResult(
        data: result,
        status: response.statusCode,
      );
    } else {
      return DocumentResult(
        data: null,
        status: response.statusCode,
      );
    }
  }
}
