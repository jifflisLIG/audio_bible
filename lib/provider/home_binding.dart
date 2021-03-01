import 'package:bible_app/controller/book_controller.dart';
import 'package:bible_app/controller/main_controller.dart';
import 'package:bible_app/provider/language_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class HomeBinding implements Bindings{

  @override
  void dependencies() {
    Get.put<LanguageProvider>(LanguageProvider());
    Get.put<MainController>(MainController());
    Get.put<BookController>(BookController());
  }


}