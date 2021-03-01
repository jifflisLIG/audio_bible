import 'package:bible_app/controller/language_controller.dart';
import 'package:bible_app/model/resources/langauge.dart';
import 'package:bible_app/widget/app_bar.dart';
import 'package:bible_app/widget/language_widget.dart';
import 'package:bible_app/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatelessWidget {
  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          title: 'Language',
        ),
        body: GetBuilder<LanguageController>(
          builder: (_) {
            if (controller.isLoading) {
              return LoadingWidget();
            }
            return _buildItems();
          },
        ));
  }


  ListView _buildItems() => ListView.builder(
      itemCount: controller.languages.length,
      itemBuilder: (BuildContext contexts, int i) {
        final Language language = controller.languages.elementAt(i);

        if (language.id == controller.languageProvider.language.id) {
          language.isDefault = true;

          //change the language instance from language provider to this language
          //so that it will be the same instance.
          controller.languageProvider.language = language;
        }

        return LanguageWidget(language, () {
          controller.onItemTap(language);
        });
      });


  Container _buildLoading(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
}
