import 'package:bible_app/model/resources/langauge.dart';
import 'package:bible_app/repositories/language_repository.dart';
import 'package:bible_app/repositories/local_db.dart';
import 'package:bible_app/screen/routes.dart';
import 'package:get/get.dart';

class LanguageProvider extends GetxController{

 LanguageProvider(){
  getLanguage();
 }

  Language language;
  LanguageRepository languageRepository = LanguageRepository();

  Future<Language> getLanguage() async {
    language ??= await languageRepository.getDefaultLanguage();
    return language ??= Language(
      id: '9879dbb7cfe39e4d-01',
      name: 'World English Bible',
      language: 'English',
      country: 'United States of America',
      abbreviation: 'WEB',
      audioID: '105a06b6146d11e7-01',
      isDefault: true,
    );
  }
}