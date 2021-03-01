import 'dart:async';
import 'dart:convert';

import 'package:bible_app/model/resource_definition.dart';
import 'package:bible_app/model/resources/base_resource.dart';
import 'package:bible_app/model/resources/resource_list.dart';
import 'package:http/http.dart' as http;

import '../repositories/api.dart';
import '../utils/resource_helper.dart';

class ResourceProvider {
  ResourceProvider(){
    api = Api(
        token: 'cfce2e24cdb48c5bf08464fecbd7d65e'
    );
  }

  Api api;

  Future<T> get<T extends BaseResource>(
    dynamic id, {
    Map<String, dynamic> params,
  }) async {
    try {
      final ResourceDefinition def = ResourceHelper.get<T>();
      final http.Response response = await api.get(
        '${def.name}/$id',
        params: params,
      );
      return def.builder(json.decode(response.body)) as T;
    } catch (err) {
      print(err);
      return Future<T>.value(null);
    }
  }

  Future<ResourceList<T>> list<T extends BaseResource>(
      {Map<String, dynamic> params, String endpoint = ''}) async {
    try {

      print('hello there!');
      final http.Response response = await api.get(
        endpoint,
        params: params,
      );
      print('the response code:${response.statusCode}');

      print(response.body);
      final dynamic decodedBody = json.decode(response.body);

      return Future<ResourceList<T>>.value(ResourceList<T>(
          json: decodedBody is List
              ? <String, dynamic>{'data': decodedBody}
              : decodedBody
      ));

    } catch (err) {
      print(err);
      return Future<ResourceList<T>>.value(null);
    }
  }

  Future<T> post<T extends BaseResource>(
    Map<String, dynamic> body, {
    String ext = '',
  }) async {
    try {
      final ResourceDefinition def = ResourceHelper.get<T>();
      final http.Response response = await api.post(
        '${def.name}/$ext',
        body: body,
      );

      return def.builder(json.decode(response.body)) as T;
    } catch (err) {
      print(err);
      return Future<T>.value(null);
    }
  }

  Future<T> put<T extends BaseResource>(dynamic ext,
      {Map<String, dynamic> params, dynamic body}) async {
    try {
      final ResourceDefinition def = ResourceHelper.get<T>();
      final http.Response response = await api.put(
        '${def.name}/$ext',
        params: params,
        body: body,
      );
      return def.builder(json.decode(response.body)) as T;
    } catch (err) {
      print(err);
      return Future<T>.value(null);
    }
  }
}
