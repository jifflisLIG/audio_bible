import 'package:flutter/material.dart';

class ResourceDefinition {
  ResourceDefinition({
    @required this.type,
    @required this.builder,
    @required this.name,
    @required this.toMap,
    this.tableName,
  });
  
  Type type;
  Function builder;
  String name;
  String tableName;
  Function toMap;
}
