import 'package:bible_app/constant/custom_colors.dart';
import 'package:bible_app/controller/book_widget_controller.dart';
import 'package:bible_app/model/resources/book.dart' as resource;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BookWidget extends StatelessWidget {
  const BookWidget(this.book, this.onTap);

  final resource.Book book;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final BookWidgetController controller =
        Get.put(BookWidgetController(book), tag: book.id);
    controller.getReadingChapter();

    return _body(controller);
  }

  Widget _body(BookWidgetController controller) {
    return SizedBox(
      height: 163,
      width: 163,
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: CustomColors.orange3,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildTitle(),
              _buildGap(8),
              _buildSubTitle(),
              _buildGap(8),
              _buildFooter(controller)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGap(double height) => SizedBox(
        height: height,
      );

  Widget _buildTitle() => Container(
        color: const Color(0xFFFFF5E8),
        width: double.infinity,
        child: Center(
          child: ListTile(
            title: Text(
              book.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );

  Widget _buildSubTitle() => Text(
        'Total Chapter ${book.totalChapter.toString()}',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black54,
        ),
      );

  Widget _buildFooter(BookWidgetController controller) =>
      GetBuilder<BookWidgetController>(
        tag: book.id,
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Last Read Ch ${controller.readingProgress == null ? '--' : controller.readingProgress.chapter}',
              ),
              _buildGap(12),
              const Text('Progress 50%'),
              _buildGap(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: _buildProgressLine(),
              ),
            ],
          );
        },
      );

  Widget _buildProgressLine() => LinearPercentIndicator(
        lineHeight: 3,
        percent: 0.5,
        linearStrokeCap: LinearStrokeCap.roundAll,
        backgroundColor: Colors.grey,
        progressColor: Colors.orange,
      );
}
