import 'package:bible_app/constant/db_cons_key.dart';
import 'package:bible_app/enum/json_source.dart';
import 'package:bible_app/model/resource_definition.dart';
import 'package:bible_app/model/resources/book.dart';
import 'package:bible_app/model/resources/langauge.dart';
import 'package:bible_app/model/resources/reading_progress.dart';

class ResourceHelper {
  static final List<ResourceDefinition> _resources = <ResourceDefinition>[
    ResourceDefinition(
      type: Book,
      name: DBKey.TBL_BOOK,
      tableName: DBKey.TBL_BOOK,
      builder: (Map<String, dynamic> json,
              {JsonSource jsonSource = JsonSource.SERVER}) =>
          Book(json: json,jsonSource: jsonSource),
      toMap: (Book book) => book.toJson(),
    ),
    ResourceDefinition(
      type: Language,
      name: 'bibles',
      tableName: DBKey.TBL_LANGUAGE,
      builder: (Map<String, dynamic> json,
              {JsonSource jsonSource = JsonSource.SERVER}) =>
          Language(json: json, jsonSource: jsonSource),
      toMap: (Language lang) => lang.toJson(),
    ),
    ResourceDefinition(
      type: ReadingProgress,
      name: DBKey.TBL_READING_PROGRESS,
      tableName: DBKey.TBL_READING_PROGRESS,
      builder: (Map<String, dynamic> json,
              {JsonSource jsonSource = JsonSource.SERVER}) =>
          ReadingProgress(json: json),
      toMap: (ReadingProgress last) => last.toJson(),
    ),
  ];

  static ResourceDefinition get<T>() => _resources
      .singleWhere((ResourceDefinition resource) => resource.type == T);

  dynamic preventLintError;
}
