import 'package:bible_app/controller/reading_controller.dart';
import 'package:bible_app/widget/app_bar.dart';
import 'package:bible_app/widget/carousel_tab.dart';
import 'package:bible_app/widget/error_widget.dart' as error;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ReadingController controller = Get.put(ReadingController());

    return GetBuilder<ReadingController>(
        builder: (_) => FutureBuilder<void>(
              future: controller.init(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                final String title =
                    '${controller.book.name} ${controller.languageProvider.language.abbreviation}';

                return snapshot.connectionState != ConnectionState.done
                    ? Scaffold(
                        appBar: _buildAppBar(title, controller),
                        body: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Scaffold(
                        appBar: _buildAppBar(title, controller),
                        body: controller.hasError
                            ? error.ErrorWidget(() {
                              controller.update();
                        })
                            : CarouselTabBarView(
                                initialPage: controller.initialPage(),
                                controller: controller.tabController,
                                children: controller.tabViews,
                                height: MediaQuery.of(context).size.height,
                              ),
                      );
              },
            ));
  }

  AppBar _buildAppBar(String title, ReadingController controller) {
    return appBar(
      title: title,
      bottom: PreferredSize(
          child: CarouselTabBar(
            initialPage: controller.initialPage(),
            controller: controller.tabController,
            tabs: controller.tabItems,
            onTap: (int index) {
              controller.tabController.index = index;
            },
          ),
          preferredSize: const Size.fromHeight(20)),
    );
  }
}
