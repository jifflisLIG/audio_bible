import 'package:bible_app/enum/json_source.dart';
import 'package:bible_app/model/resources/base_resource.dart';

class ReadingProgress extends BaseResource {
  ReadingProgress({
    this.chapterID,
    this.chapter,
    this.bookID,
    Map<String, dynamic> json,
    JsonSource jsonSource = JsonSource.SERVER,
  }) : super(json, jsonSource);

  String chapterID;
  int chapter;
  String bookID;

  @override
  void fromJson(Map<String, dynamic> json) {
    chapter = json['chapter'];
    chapterID = json['chapter_id'];
    bookID = json['book_id'];
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['chapter'] = chapter;
    map['chapter_id'] = chapterID;
    map['book_id'] = bookID;
    return map;
  }
}
