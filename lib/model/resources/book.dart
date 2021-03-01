import 'package:bible_app/constant/db_cons_key.dart';
import 'package:bible_app/enum/json_source.dart';
import 'package:bible_app/model/resources/base_resource.dart';
import 'package:bible_app/model/resources/reading_progress.dart';

class Book extends BaseResource {
  Book({
    this.id,
    this.bibleId,
    this.abbreviation,
    this.name,
    this.nameLong,
    this.totalChapter,
    this.isSelected = false,
    Map<String, dynamic> json,
    JsonSource jsonSource = JsonSource.SERVER
  }) : super(json,jsonSource);

  String id;
  String bibleId;
  String abbreviation;
  String name;
  String nameLong;
  int totalChapter;
  bool isSelected;

  ReadingProgress readingProgress;

  static Book factory({bool isSelected}){
    final bool selected =isSelected??false;
    return Book(
      id: 'GEN',
      bibleId: 'de4e12af7f28f599-01',
      abbreviation: 'GEN',
      name: 'Genesis',
      nameLong: 'Genesis',
      totalChapter: 50,
      isSelected: selected,
    );
  }
  @override
  void fromJson(Map<String, dynamic> json) {
    if(jsonSource ==JsonSource.SERVER){
      fromServerJson(json);
    }else{
      fromLocalDbJson(json);
    }
  }

  void fromServerJson(Map<String, dynamic> json) {
    id = json['id'];
    bibleId =json['bibleId'];
    abbreviation=json['abbreviation'];
    name=json['name'];
    nameLong=json['nameLong'];
    totalChapter=45;
    isSelected = false;
  }

  void fromLocalDbJson(Map<String, dynamic> json) {
    id = json[DBKey.FB_ID];
    bibleId = json[DBKey.FB_BIBLE_ID];
    abbreviation = json[DBKey.FB_ABBREVIATION];
    name = json[DBKey.FB_NAME];
    nameLong = json[DBKey.FB_NAME_LONG];
    totalChapter =45;
    isSelected = json['is_selected'] =='true';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String,dynamic> data = <String,dynamic>{};
    data[DBKey.FB_ID] = id;
    data[DBKey.FB_BIBLE_ID] = bibleId;
    data[DBKey.FB_ABBREVIATION] = abbreviation;
    data[DBKey.FB_NAME] = name;
    data[DBKey.FB_NAME_LONG] = nameLong;
    data[DBKey.FB_TOTAL_CHAPTER] = totalChapter;
    print('selected:$isSelected');
    data[DBKey.FB_IS_SELECTED] = isSelected;
    return data;
  }

  @override
  String toString() {
    return 'Book{id: $id, bibleId: $bibleId, abbreviation: $abbreviation, name: $name, nameLong: $nameLong, totalChapter: $totalChapter}';
  }
}
