import 'package:bible_app/enum/json_source.dart';

import './base_resource.dart';
import '../../utils/resource_helper.dart';
import '../resource_definition.dart';

class ResourceList<T extends BaseResource> extends BaseResource {
  ResourceList(
      {this.items,
      Map<String, dynamic> json,
      JsonSource jsonSource = JsonSource.SERVER})
      : super(json, jsonSource);

  List<T> items = <T>[];

  @override
  void fromMapList(List<Map<String, dynamic>> mapList) {
    if (mapList != null) {
      items = <T>[];
      mapList.forEach((dynamic v) {
        final ResourceDefinition def = ResourceHelper.get<T>();
        items.add(def.builder(v) as T);
      });
    }
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    if (json != null && json['data'] != null) {
      items = <T>[];
      json['data'].forEach((dynamic v) {
        final ResourceDefinition def = ResourceHelper.get<T>();
        items.add(def.builder(v) as T);
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items.map((T v) => v.toJson()).toList();
    }
    return data;
  }
}
