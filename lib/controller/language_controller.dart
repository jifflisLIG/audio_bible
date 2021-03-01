import 'package:bible_app/controller/book_controller.dart';
import 'package:bible_app/model/resources/langauge.dart';
import 'package:bible_app/provider/language_provider.dart';
import 'package:bible_app/repositories/language_repository.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController{

  LanguageRepository languageRepository = LanguageRepository();
  final LanguageProvider languageProvider = Get.find();
  final BookController bookController = Get.find();

  List<Language> languages =<Language>[];
  bool isLoading = false;

  @override
  void onInit() {
    getLanguages();
    super.onInit();
  }

  Future<void> getLanguages() async{
    setLoading(true);
    (await languageProvider.language).isDefault = false;
    languages = await languageRepository.getLanguages();
    isLoading = false;
    update();
  }

  Future<void> onItemTap(Language language) async{
    setLoading(true);
    await _saveDefaultLanguage(language);
    bookController.getBooks();
    setLoading(false);
  }

  Future<void> _saveDefaultLanguage(Language language)async{
    language.isDefault = true;
    (await languageProvider.language).isDefault = false;
    languageProvider.language= language;
    await languageRepository.saveDefaultLanguage(language);
  }

  void setLoading(bool isLoading){
    this.isLoading = isLoading;
    update();
  }
}