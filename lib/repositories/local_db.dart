import 'package:bible_app/constant/db_cons_key.dart';
import 'package:bible_app/enum/json_source.dart';
import 'package:bible_app/model/resource_definition.dart';
import 'package:bible_app/model/resources/base_resource.dart';
import 'package:bible_app/model/resources/resource_list.dart';
import 'package:bible_app/utils/resource_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  LocalDB._();

  static LocalDB _instance;

  ///Get singleton instance of this class
  ///
  ///
  static LocalDB getInstance() {
    if (_instance == null) {
      return LocalDB._();
    }
    return _instance;
  }

  Database db;

  ///Initialize DB
  ///
  ///
  Future<void> initialize() async {
    db = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'NBible.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (Database db, int version) {
        // Run the CREATE TABLE statement on the database.
        _createTableLastReading(db);

        _createTableLanguage(db);

        _createTableBook(db);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  ///Create table reading progress
  ///
  ///
  void _createTableLastReading(Database db) {
    db.execute(
      'CREATE TABLE ${DBKey.TBL_READING_PROGRESS}('
      '${DBKey.FRD_BOOK_ID} STRING PRIMARY KEY, '
      '${DBKey.FRD_CHAPTER_ID} STRING,'
      '${DBKey.FRD_CHAPTER} INTEGER)',
    );
  }


  static String TBL_BOOK='book';
  static String FB_ID = 'id';
  static String FB_BIBLE_ID = 'bibleId';
  static String FB_ABBREVIATION = 'abbreviation';
  static String FB_NAME = 'name';
  static String FB_NAME_LONG = 'nameLong';
  static String FB_TOTAL_CHAPTER = 'totalChapter';

  ///Create table book
  ///
  ///
  void _createTableBook(Database db) {
    db.execute(
      'CREATE TABLE ${DBKey.TBL_BOOK}('
          '${DBKey.FB_ID} STRING PRIMARY KEY, '
          '${DBKey.FB_BIBLE_ID} STRING,'
          '${DBKey.FB_ABBREVIATION} STRING,'
          '${DBKey.FB_NAME} STRING,'
          '${DBKey.FB_NAME_LONG} STRING,'
          '${DBKey.FB_IS_SELECTED} STRING,'
          '${DBKey.FB_TOTAL_CHAPTER} INTEGER)',
    );
  }

  ///Create table language
  ///
  ///
  void _createTableLanguage(Database db) {
    db.execute('CREATE TABLE ${DBKey.TBL_LANGUAGE} ('
        '${DBKey.FL_ID} STRING PRIMARY KEY,'
        '${DBKey.FL_NAME} STRING,'
        '${DBKey.FL_LANGUAGE} STRING,'
        '${DBKey.FL_COUNTRY} STRING,'
        '${DBKey.FL_AUDIO_ID} STRING,'
        '${DBKey.FL_ISDEFAULT} STRING,'
        '${DBKey.FL_ABBREVIATION} STRING)');
  }

  ///check if db is initialize
  ///
  ///
  Future<void> _initializeDb() async {
    if (db == null) {
      await initialize();
    }
  }

  ///Insert or update data
  ///
  ///
  Future<int> upsert<T>(T data) async {
    await _initializeDb();

    final ResourceDefinition def = ResourceHelper.get<T>();

    return await db.insert(
      def.tableName,
      def.toMap(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///Get single data
  ///
  ///
  Future<T> get<T>(String table,
      {bool distinct,
      List<String> columns,
      String where,
      List<dynamic> whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset,
      JsonSource jsonSource,
      }) async {
    await _initializeDb();

    List<Map<String, dynamic>> map = await db.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);

    print('the map:${map.toString()}');
    final ResourceDefinition def = ResourceHelper.get<T>();
    if (map == null || map.isEmpty) {
      return null;
    }

    return def.builder(map[0],jsonSource: jsonSource) as T;
  }
//
//  ///Get list of data
//  ///
//  ///
//  Future<ResourceList<T>> list<T extends BaseResource>(String table,
//      {bool distinct,
//        List<String> columns,
//        String where,
//        List<dynamic> whereArgs,
//        String groupBy,
//        String having,
//        String orderBy,
//        int limit,
//        int offset,
//        JsonSource jsonSource,
//      }) async {
//    await _initializeDb();
//
//    List<Map<String, dynamic>> map = await db.query(table,
//        distinct: distinct,
//        columns: columns,
//        where: where,
//        whereArgs: whereArgs,
//        groupBy: groupBy,
//        having: having,
//        orderBy: orderBy,
//        limit: limit,
//        offset: offset);
//
//    if (map == null || map.isEmpty) {
//      return null;
//    }
//
//    return Future<ResourceList<T>>.value(ResourceList<T>(
//        mapList: map
//    ));
//
//  }
}
