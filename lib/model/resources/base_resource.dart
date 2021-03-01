import 'package:bible_app/enum/json_source.dart';

abstract class BaseResource {
  BaseResource(Map<String, dynamic> json,this.jsonSource) {
    if (json != null) {
      fromJson(json);
    }
  }

  JsonSource jsonSource;

  void fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

}
