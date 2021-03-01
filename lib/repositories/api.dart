import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../environment.dart';

class Api {
  Api({
    @required String token,
  }) {
    headers = <String, String>{
      'api-key': token,
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
  }

  final String baseUrl = Env.apiUrl;
  Map<String, String> headers;

  String _toQueryString(Map<String, dynamic> params) {
    if (params != null && params.isNotEmpty) {
      final List<String> list = <String>[];
      params.forEach((String k, dynamic v) => list.add('$k=$v'));
      return '?' + list.join('&');
    } else {
      return '';
    }
  }

  Future<http.Response> get(String endpoint, {Map<String, dynamic> params}) async {
    final String query = _toQueryString(params);
      print('$baseUrl/$endpoint$query');
      print(headers);
    final http.Response res = await http.get('$baseUrl/$endpoint$query', headers: headers);
    return res;
  }

  Future<http.Response> delete(String endpoint, {Map<String, dynamic> params}) async {
    final String query = _toQueryString(params);
    final http.Response res = await http.post(
      '$baseUrl/$endpoint$query',
      body: jsonEncode(<String, String>{'_method': 'delete'}),
      headers: headers,
    );
    return res;
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic> params,
    dynamic body,
  }) async {
    final String query = _toQueryString(params);
    final http.Response res = await http.post(
      '$baseUrl/$endpoint$query',
      body: body == null ? '' : jsonEncode(body),
      headers: headers,
    );
    return res;
  }

  Future<http.Response> patch(
    String endpoint, {
    Map<String, dynamic> params,
    dynamic body,
  }) async {
    final String query = _toQueryString(params);
    final http.Response res = await http.post(
      '$baseUrl/$endpoint$query',
      body: body == null ? null : jsonEncode(body),
      headers: headers,
    );
    return res;
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic> params,
    dynamic body,
  }) async {
    final String query = _toQueryString(params);
    final http.Response res = await http.post(
      '$baseUrl/$endpoint$query',
      body: body == null ? '' : jsonEncode(body),
      headers: headers,
    );
    return res;
  }
}
