import 'package:bible_app/controller/book_controller.dart';
import 'package:bible_app/model/resources/book.dart';
import 'package:bible_app/model/resources/langauge.dart';
import 'package:bible_app/model/resources/reading_progress.dart';
import 'package:bible_app/provider/language_provider.dart';
import 'package:bible_app/repositories/reading_repository.dart';
import 'package:bible_app/widget/carousel_tab.dart';
import 'package:bible_app/widget/content.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class ReadingController extends GetxController {
  ReadingRepository repository = ReadingRepository();
  LanguageProvider languageProvider = Get.find();

  BookController _bookController = Get.find();
  CarouselTabController _tabController;
  List<CarouselTabItem> tabItems = <CarouselTabItem>[];
  List<Widget> tabViews = <Widget>[];
  Language language;

  int numberOfChapters = 0;
  bool hasError = false;

  CarouselTabController get tabController {
    _tabController ??= Get.put(CarouselTabController());
    return _tabController;
  }

  Future<void> init() async {
    hasError = false;
    try {
      language = await languageProvider.getLanguage();
      _bookController = Get.find();
      print('the book');
      print(_bookController.selectedBook);
      await setCarouselTabItem();
    } catch (e) {
      showToast(
        'Unable to play audio. Please try again...',
        position: ToastPosition.bottom,
      );
      hasError = true;
    }
  }

  int initialPage() {
    if (book.readingProgress == null || book.readingProgress.chapter == null) {
      return 0;
    }
    return book.readingProgress.chapter - 1;
  }

  Book get book {
    return _bookController.selectedBook;
  }

  Future<void> setCarouselTabItem() async {
    tabItems = <CarouselTabItem>[];
    tabViews = <Widget>[];

    numberOfChapters = await repository.getTotalChapters(language.id, book.id);
    for (int i = 0; i < numberOfChapters; i++) {
      final int chapter = i + 1;
      final String bookId = book.id;

      tabItems.add(CarouselTabItem('$chapter'));
      tabViews.add(
        Content(
          readingProgress: ReadingProgress(
            bookID: bookId,
            chapter: chapter,
            chapterID: '$bookId.$chapter',
          ),
          loadUrl: true,
        ),
      );
    }
  }
}
