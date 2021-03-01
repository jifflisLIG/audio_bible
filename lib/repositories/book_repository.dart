import 'package:bible_app/constant/db_cons_key.dart';
import 'package:bible_app/enum/json_source.dart';
import 'package:bible_app/model/resource_definition.dart';
import 'package:bible_app/model/resources/book.dart';
import 'package:bible_app/model/resources/reading_progress.dart';
import 'package:bible_app/model/resources/resource_list.dart';
import 'package:bible_app/provider/resource_provider.dart';
import 'package:bible_app/repositories/local_db.dart';
import 'package:bible_app/utils/resource_helper.dart';

class BookRepository {
  ResourceProvider provider = ResourceProvider();
  LocalDB db = LocalDB.getInstance();

  Future<List<Book>> getBooks(String bookId) async {
    final ResourceDefinition def = ResourceHelper.get<Book>();

    final ResourceList<Book> list = await provider.list(
      endpoint: 'bibles/$bookId/${def.name}',
    );
    return list.items;
  }

  Future<ReadingProgress> getReadingProgress(String bookId) async {
    return db.get<ReadingProgress>(DBKey.TBL_READING_PROGRESS,
        whereArgs: <String>[bookId],
        where: '${DBKey.FRD_BOOK_ID} = ?');
  }


  ///local queries--------------------------------------------------------------

  ///Save selected book
  ///
  ///
  Future<void> saveSelectedBook(Book book) async {
    int reuslt =await db.upsert<Book>(book);
    print('the reuslt is:$reuslt');
  }

  ///Get selected book
  ///
  ///
  Future<Book> getSelectedBook() async{
    return await db.get(
        DBKey.TBL_BOOK,
        where: '${DBKey.FB_IS_SELECTED} = ?',
        whereArgs: <String>['true'],
        jsonSource: JsonSource.LOCAL,
    );
  }


}
