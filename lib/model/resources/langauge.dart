import 'package:bible_app/constant/db_cons_key.dart';
import 'package:bible_app/enum/json_source.dart';
import 'package:bible_app/model/resources/base_resource.dart';

class Language extends BaseResource {
  Language({
    this.id,
    this.name,
    this.language,
    this.country,
    this.isDefault = false,
    this.abbreviation,
    this.audioID,
    Map<String, dynamic> json,
    JsonSource jsonSource = JsonSource.SERVER,
  }) : super(json,jsonSource);

  String id;
  String name;
  String language;
  String country;
  String audioID;
  bool isDefault;
  String abbreviation;

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
    name = json['name'];
    language = json['language']['name'];
    abbreviation = json['abbreviation'];
    country = (json['countries'][0] as Map<String, dynamic>)['name'];

    try{
      audioID =(json['audioBibles'][0] as Map<String, dynamic>)['id'];
    }catch (_){
      audioID = '';
    }

  }

  void fromLocalDbJson(Map<String, dynamic> json) {
    id = json[DBKey.FL_ID];
    name = json[DBKey.FL_NAME];
    language = json[DBKey.FL_LANGUAGE];
    abbreviation = json[DBKey.FL_ABBREVIATION];
    country = json[DBKey.FL_COUNTRY];
    audioID =json[DBKey.FL_AUDIO_ID];
    isDefault = json[DBKey.FL_ISDEFAULT] == 'yes';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DBKey.FL_ID] = id;
    data[DBKey.FL_NAME] = name;
    data[DBKey.FL_LANGUAGE] = language;
    data[DBKey.FL_COUNTRY] = country;
    data[DBKey.FL_AUDIO_ID] = audioID;
    data[DBKey.FL_ABBREVIATION] = abbreviation;
    data[DBKey.FL_ISDEFAULT] = isDefault ? 'yes' : 'no';
    return data;
  }
}
