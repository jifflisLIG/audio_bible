import 'package:bible_app/constant/custom_colors.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef OnCarouselTabItemTapped = void Function(int index);
typedef OnAnimateTo = void Function(int index);

//--------------------------------------------------------------------------------
/// Carousel tab bar widget.
///
///
class CarouselTabBar extends StatelessWidget {
  CarouselTabBar({
    @required this.tabs,
    @required this.controller,
    this.initialPage = 0,
    this.height = 35,
    this.onTap,
    Key key,
  }) : super(key: key) {

    controller.tabCount = tabs.length;

    for (int i = 0; i < controller.tabCount; i++) {
      final CarouselTabItem tab = tabs[i];
      tab._index = i;
      tab._onTap = onTap;
    }
    controller.index = initialPage;
  }

  final List<CarouselTabItem> tabs;
  final CarouselTabController controller;
  final int initialPage;
  final double height;
  final OnCarouselTabItemTapped onTap;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: tabs,
      carouselController: controller.tabBarController,
      options: CarouselOptions(
        initialPage: initialPage,
        viewportFraction: .1,
        height: height,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
      ),
    );
  }
}

//--------------------------------------------------------------------------------
/// Carousel tab bar item widget.
///
///
class CarouselTabItem extends StatelessWidget {
  CarouselTabItem(this._text);

  final String _text;

  Function _onTap;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final CarouselTabController controller = Get.find();

    return GetBuilder<CarouselTabController>(
      builder: (_) => InkWell(
        onTap: () {
          _onTabTapped(controller);
          if (_onTap != null) {
            _onTap(_index);
          }
        },
        child: Container(
          child: Center(
            child: Text(
              _text,
              style: TextStyle(
                color: _getColor(controller),
                fontSize: controller.index == _index ? 20 : 12,
                fontWeight:  controller.index == _index?FontWeight.bold:FontWeight.normal
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Get selected/unselected color.
  ///
  ///
  Color _getColor(CarouselTabController model) =>
      model.index == _index ? CustomColors.orange : CustomColors.gray1;

  /// CarouselTabBar item "onTap" callback.
  ///
  ///
  void _onTabTapped(CarouselTabController model) {
    final int prevIndex = model.index;
    model._isTabTapped = true;

    if (prevIndex == model.tabCount - 1 && _index == 0) {
      model.tabBarViewController.nextPage();
    } else if (prevIndex == 0 && _index == model.tabCount - 1) {
      model.tabBarViewController.previousPage();
    } else {
      model.tabBarViewController.animateToPage(_index);
    }

    model.index = _index;
  }
}

//--------------------------------------------------------------------------------
/// Carousel tab ber view widget.
///
///
class CarouselTabBarView extends StatelessWidget {
  const CarouselTabBarView({
    @required this.children,
    @required this.controller,
    this.initialPage = 0,
    this.height = double.infinity,
    this.onPageChanged,
    Key key,
  }) : super(key: key);

  final List<Widget> children;
  final CarouselTabController controller;
  final int initialPage;
  final double height;
  final Function onPageChanged;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarouselTabController>(
        builder: (_) => CarouselSlider(
              items: children,
              carouselController: controller.tabBarViewController,
              options: CarouselOptions(
                  initialPage: initialPage,
                  viewportFraction: 1.0,
                  height: height,
                  onPageChanged: (int index, _) {
                    _onPageChanged(context, index);
                    if (onPageChanged != null) {
                      onPageChanged(index);
                    }
                  }),
            ));
  }

  /// "onPageChanged" callback.
  ///
  ///
  void _onPageChanged(BuildContext context, int index) {
    if (controller._isTabTapped) {
      if (controller.index == index) {
        controller._isTabTapped = false;
        controller.tabBarController.jumpToPage(index);
      }

      return;
    }

    if (controller.index == 0 && index == children.length - 1) {
      controller.tabBarController.previousPage();
    } else if (controller.index == children.length - 1 && index == 0) {
      controller.tabBarController.nextPage();
    } else {
      controller.tabBarController.animateToPage(index);
    }

    controller.index = index;
  }
}

//--------------------------------------------------------------------------------
/// Carousel tab controller.
///
///
class CarouselTabController extends GetxController {
  final CarouselController tabBarController = CarouselController();
  final CarouselController tabBarViewController = CarouselController();

  OnAnimateTo _onAnimateTo;

  int _index = 0;
  bool _isTabTapped = false;

  int tabCount = 0;

  /// Get current tab index.
  ///
  ///
  int get index => _index;

  /// Set tab index.
  ///
  ///
  set index(int value) {
    if (value < 0 || _index == value) {
      return;
    }
    _index = value;
    update();
  }

  /// Set [animateTo] callback.
  ///
  /// This will be called before the page animation.
  void setOnAnimateTo(OnAnimateTo callback) => _onAnimateTo = callback;

  /// Animate to page.
  ///
  ///
  void animateTo(int index) {
    if (_index == index) {
      return;
    }
    if (_onAnimateTo != null) {
      _onAnimateTo(index);
    }
    tabBarViewController.animateToPage(index);
  }
}
