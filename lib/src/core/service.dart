import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velvy/src/core/mapper.dart';
import 'query.dart';

class Service<T> {
  String url;
  Map<String, String> defaultHeaders;
  Encoding encoding;
  EncodeCallback toMap;
  DecodeCallback fromMap;

  Service({
    this.url,
    this.defaultHeaders,
    this.encoding,
    this.toMap,
    this.fromMap,
  }) {
    defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<List<T>> find({Query query, Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
    }
    headers.addAll(defaultHeaders);

    var response = await http.get(url, headers: headers);

    if (response.statusCode < 300) {
      Map<String, dynamic> res = json.decode(response.body);
      List body = res['data'];

      List<T> result = body.map((item) => fromMap(item)).toList();
      return result;
    } else {
      throw 'Failed to get data. Error HTTP ${response.statusCode}';
    }
  }

  Future<T> create({data, Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
    }
    headers.addAll(defaultHeaders);

    var response = await http.post(
      url,
      body: json.encode(data),
      headers: headers,
      encoding: encoding,
    );

    if (response.statusCode < 300) {
      var map = json.decode(response.body);
      var result = fromMap(map);

      return result;
    } else {
      throw 'Failed to get data';
    }
  }

  Future<T> get(dynamic id, {Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
    }
    headers.addAll(defaultHeaders);

    var response = await http.get('url/$id', headers: headers);

    if (response.statusCode < 300) {
      var map = json.decode(response.body);
      var result = fromMap(map);

      return result;
    } else {
      throw 'Failed to get data';
    }
  }

  Future<T> update(dynamic id, {data, Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
    }
    headers.addAll(defaultHeaders);

    var response = await http.put('url/$id',
        body: data, headers: headers, encoding: encoding);

    if (response.statusCode < 300) {
      var map = json.decode(response.body);
      var result = fromMap(map);

      return result;
    } else {
      throw 'Failed to get data';
    }
  }

  Future<T> destroy(dynamic id, {Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
    }
    headers.addAll(defaultHeaders);

    var response = await http.delete('url/$id', headers: headers);

    if (response.statusCode < 300) {
      var map = json.decode(response.body);
      var result = fromMap(map);

      return result;
    } else {
      throw 'Failed to get data';
    }
  }
}
