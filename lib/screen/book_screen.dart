import 'package:bible_app/controller/book_controller.dart';
import 'package:bible_app/model/resources/book.dart';
import 'package:bible_app/widget/app_bar.dart';
import 'package:bible_app/widget/book_widget.dart';
import 'package:bible_app/widget/error_widget.dart' as error;
import 'package:bible_app/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BookController controller = Get.find();

    return Scaffold(
      appBar: appBar(
        title: 'Books',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: GetBuilder<BookController>(builder: (_) {
          if (controller.isLoading) {
            return LoadingWidget();
          }
          return controller.hasError
              ? error.ErrorWidget(() {
                  controller.getBooks();
                })
              : _buildItems(controller);
        }),
      ),
    );
  }

  GridView _buildItems(BookController controller) => GridView.builder(
      itemCount: controller.books.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (BuildContext context, int i) {
        final Book book = controller.books.elementAt(i);

        if (i == 0 || i == 1) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: BookWidget(book, () {
              controller.onItemClick(book);
            }),
          );
        }

        return BookWidget(book, () {
          controller.onItemClick(book);
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
