import 'package:bible_app/constant/db_cons_key.dart';
import 'package:bible_app/enum/json_source.dart';
import 'package:bible_app/model/resource_definition.dart';
import 'package:bible_app/model/resources/langauge.dart';
import 'package:bible_app/model/resources/resource_list.dart';
import 'package:bible_app/provider/resource_provider.dart';
import 'package:bible_app/repositories/local_db.dart';
import 'package:bible_app/utils/resource_helper.dart';

class LanguageRepository {
  ResourceProvider provider = ResourceProvider();
  LocalDB db = LocalDB.getInstance();

  ///Server queries ------------------------------------------------------------

  ///Get Languages
  ///
  ///
  Future<List<Language>> getLanguages() async {
    final ResourceDefinition def = ResourceHelper.get<Language>();

    final ResourceList<Language> list = await provider.list(
      endpoint: def.name,
    );

    return list.items;
  }

  ///local queries--------------------------------------------------------------

  ///Save default language
  ///
  ///
  Future<void> saveDefaultLanguage(Language language) async {
    await db.upsert<Language>(language);
  }

  ///Get default language
  ///
  ///
  Future<Language> getDefaultLanguage() async{
    return await db.get(
      DBKey.TBL_LANGUAGE,
      where: '${DBKey.FL_ISDEFAULT} = ?',
      whereArgs: <String>['yes'],
      jsonSource: JsonSource.LOCAL,
    );
  }

}
