import 'dart:convert';

import 'package:bible_app/model/resources/reading_progress.dart';
import 'package:bible_app/provider/resource_provider.dart';
import 'package:bible_app/repositories/local_db.dart';
import 'package:http/http.dart' as http;

class ContentRepository {
  ResourceProvider provider = ResourceProvider();
  LocalDB db = LocalDB.getInstance();

  Future<String> getChapter(String bibleID, String chapterID) async {
    final http.Response response =
        await provider.api.get('bibles/$bibleID/chapters/$chapterID');
    
    final Map<String, dynamic> data = await jsonDecode(response.body);

    final String content =
        (data['data'] as Map<String, dynamic>)['content'].toString();
    return content;
  }
  
  Future<String> getAudioUrl(String audioID,String chapterID) async{
    final http.Response response = await provider.api.get(
        'audio-bibles/$audioID/chapters/MAT.17'
    );
    final Map<String,dynamic> data = await jsonDecode(response.body);
    print(data.toString());
    final String audioUrl = (data['data'] as Map<String, dynamic>)['resourceUrl'].toString();
    print(audioUrl);
    return audioUrl;
  }

  Future<void> saveReadingProgress(ReadingProgress progress) async {
    await db.upsert<ReadingProgress>(progress);
  }
}
