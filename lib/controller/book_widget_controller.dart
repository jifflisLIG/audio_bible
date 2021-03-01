import 'package:bible_app/model/resources/book.dart';
import 'package:bible_app/model/resources/reading_progress.dart';
import 'package:bible_app/repositories/book_repository.dart';
import 'package:get/get.dart';

class BookWidgetController extends GetxController{
  BookWidgetController(this.book);

  ReadingProgress readingProgress;
  Book book;

  final BookRepository _repository = BookRepository();

  Future<void> getReadingChapter() async {
      readingProgress = await _repository.getReadingProgress(book.id);
      book.readingProgress = readingProgress;
      update();
  }

}