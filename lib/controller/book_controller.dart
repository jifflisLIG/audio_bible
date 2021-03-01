import 'package:bible_app/controller/main_controller.dart';
import 'package:bible_app/model/resources/book.dart';
import 'package:bible_app/provider/language_provider.dart';
import 'package:bible_app/repositories/book_repository.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class BookController extends GetxController {
  List<Book> books = <Book>[];
  bool isLoading = false;

  final BookRepository _repository = BookRepository();
  final LanguageProvider languageProvider = Get.find();
  final MainController controller = Get.find();
  Book selectedBook;
  bool hasError = false;

  @override
  void onInit() {
    setSelectedBook();
    getBooks();
    super.onInit();
  }

  Future<void> setSelectedBook() async {
    selectedBook =
        await _repository.getSelectedBook() ?? Book.factory(isSelected: true);
  }

  Future<void> getBooks() async {
    books.clear();
    hasError = false;
    setIsloading(true);
    try {
      final List<Book> books =
          await _repository.getBooks((await languageProvider.getLanguage()).id);
      this.books.addAll(books);
    } catch (e) {
      showToast(
        'Unable to load books. Please try again...',
        position: ToastPosition.bottom,
      );
      hasError = true;
    }
    isLoading = false;
    refresh();
  }

  void onItemClick(Book book) {
    book.isSelected = true;
    selectedBook = book;
    _repository.saveSelectedBook(book);
    controller.selectedBottomIndex.value = 1;
  }

  void setIsloading(bool isLoading) {
    this.isLoading = isLoading;
    refresh();
  }
}
