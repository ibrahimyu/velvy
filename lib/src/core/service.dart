import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velvy/src/core/codec.dart';
import 'query.dart';
import 'velvy.dart';

class Service {
  String url;
  Encoding encoding;
  EncodeCallback toMap;
  DecodeCallback fromMap;

  Service({
    this.url,
    this.encoding,
    this.toMap,
    this.fromMap,
  }) {
    toMap = (m) => m;
    fromMap = (map) => map;
  }

  Future<List> find({Query query}) async {
    var headers = Velvy.instance.defaultHeaders;
    var response = await http.get(url, headers: headers);

    if (response.statusCode < 300) {
      var res = json.decode(response.body);
      List body;

      // if it's paginated, the real data would be on the data property.
      if (res is List) {
        body = res;
      } else {
        body = res['data'];
      }

      List result = body.map((item) => fromMap(item)).toList();

      return result;
    } else {
      throw 'Failed to get data. Error HTTP ${response.statusCode}';
    }
  }

  Future create({data}) async {
    var headers = Velvy.instance.defaultHeaders;
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
      throw 'Failed to get data. Error HTTP ${response.statusCode}';
    }
  }

  Future get(dynamic id, {Map<String, String> headers}) async {
    var headers = Velvy.instance.defaultHeaders;
    var response = await http.get('$url/$id', headers: headers);

    if (response.statusCode < 300) {
      var map = json.decode(response.body);
      var result = fromMap(map);

      return result;
    } else {
      throw 'Failed to get data. Error HTTP ${response.statusCode}';
    }
  }

  Future update(dynamic id, {data}) async {
    var headers = Velvy.instance.defaultHeaders;
    var response = await http.put(
      '$url/$id',
      body: json.encode(data),
      headers: headers,
      encoding: encoding,
    );

    if (response.statusCode < 300) {
      var map = json.decode(response.body);
      var result = fromMap(map);

      return result;
    } else {
      throw 'Failed to get data. Error HTTP ${response.statusCode}';
    }
  }

  Future destroy(dynamic id, {Map<String, String> headers}) async {
    var headers = Velvy.instance.defaultHeaders;
    var response = await http.delete('$url/$id', headers: headers);

    if (response.statusCode < 300) {
      var map = json.decode(response.body);
      var result = fromMap(map);

      return result;
    } else {
      throw 'Failed to get data. Error HTTP ${response.statusCode}';
    }
  }
}
