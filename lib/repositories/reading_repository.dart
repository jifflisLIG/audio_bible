import 'dart:convert';

import 'package:bible_app/provider/resource_provider.dart';
import 'package:http/http.dart' as http;
class ReadingRepository{
  ResourceProvider provider = ResourceProvider();

  Future<int> getTotalChapters(String bibleID,String bookID) async {
    final String endpoint = 'bibles/$bibleID/books/$bookID/chapters';
    final http.Response response =await  provider.api.get(endpoint);
    final Map<String,dynamic> body  = jsonDecode(response.body);

    return (body['data']as List<dynamic>).length - 1;
  }
}