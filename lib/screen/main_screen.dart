import 'package:bible_app/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Widget> _navigationScreens = <Widget>[
    SubNavigator(
        navigatorKey: Routes.bookNavigatorKey,
        initialRoute: Routes.SCREEN_BOOK),
    SubNavigator(
      navigatorKey: Routes.readingNavigatorKey,
      initialRoute: Routes.SCREEN_READING,
    ),
    SubNavigator(
        navigatorKey: Routes.languageNavigatorKey,
        initialRoute: Routes.SCREEN_LANGUAGE),
  ];

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();
    return Obx(()=>Scaffold(
      body: _navigationScreens[controller.selectedBottomIndex.value],
      bottomNavigationBar: _buildBottomNavigation(context,controller),
    ));
  }

  /// Build bottom navigation widget.
  ///
  ///
  Widget _buildBottomNavigation(BuildContext context,MainController controller) => BottomNavigationBar(
        backgroundColor: Colors.black12,
        elevation: 0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: controller.selectedBottomIndex.value,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
         controller.selectedBottomIndex.value = index;
        },
        items: _bottomNavigationItems(),
      );

  /// Bottom navigation items.
  ///
  ///
  List<BottomNavigationBarItem> _bottomNavigationItems() =>
      <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(
              Icons.book,
              size: 19,
            ),
          ),
          label: 'Book',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Icon(
              Icons.read_more,
              size: 19,
            ),
          ),
          label: 'Read more',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Icon(
              Icons.language,
              size: 19,
            ),
          ),
          label: 'Language',
        ),
      ];
}
