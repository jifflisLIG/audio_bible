import 'package:bible_app/constant/custom_colors.dart';
import 'package:bible_app/controller/content_controller.dart';
import 'package:bible_app/model/resources/reading_progress.dart';
import 'package:bible_app/provider/language_provider.dart';
import 'package:bible_app/widget/error_widget.dart' as error;
import 'package:bible_app/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';

class Content extends StatelessWidget {
  const Content({
    this.loadUrl = false,
    @required this.readingProgress,
  });

  final bool loadUrl;
  final ReadingProgress readingProgress;

  @override
  Widget build(BuildContext context) {
    final ContentController controller = Get.put(
      ContentController(),
      tag: readingProgress.chapterID,
    );

    final LanguageProvider languageProvider = Get.find();

    controller.init(readingProgress: readingProgress, loadUrl: loadUrl);

    return Stack(
      children: <Widget>[
        _buildContent(controller),
        if (languageProvider.language.audioID != null)
          Obx(() => _playButton(controller)),
      ],
    );
  }

  Widget _playButton(ContentController controller) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 45,
          height: 45,
          margin: const EdgeInsets.only(bottom: 17),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: CustomColors.orange4),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 5,
                offset: const Offset(2, 3), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              controller.updateAudioState();
            },
            child: _getPlayIcon(controller),
          ),
        ),
      );

  Widget _getPlayIcon(ContentController controller) {
    if (controller.audioState.value == AudioState.initializing) {
      return const CupertinoActivityIndicator(
        radius: 10,
      );
    } else if (controller.audioState.value == AudioState.play) {
      return const Icon(Icons.pause);
    } else {
      return const Icon(Icons.play_arrow);
    }
  }

  Widget _buildContent(ContentController controller) =>
      GetBuilder<ContentController>(
          tag: readingProgress.chapterID,
          builder: (_) {
            if(controller.hasError){
              return error.ErrorWidget((){
                  controller.getChapter();
              });
            }
            if (controller.isLoading) {
              return LoadingWidget();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  child: Html(
                    data: controller.data,
                    //Optional parameters:
                    style: <String, Style>{
                      'p': Style(
                        fontFamily: 'Helvetica',
                        fontSize: FontSize.large,
                        lineHeight: 1.5,
                      ),
                      'table': Style(
                        fontFamily: 'Helvetica',
                        backgroundColor:
                            const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                      ),
                      'tr': Style(
                        fontFamily: 'Helvetica',
                        border: const Border(
                            bottom: BorderSide(color: Colors.grey)),
                      ),
                      'th': Style(
                        fontFamily: 'Helvetica',
                        padding: const EdgeInsets.all(6),
                        backgroundColor: Colors.grey,
                      ),
                      'td': Style(
                        fontFamily: 'Helvetica',
                        padding: const EdgeInsets.all(6),
                      ),
                      'var': Style(
                        fontFamily: 'Helvetica',
                        fontSize: FontSize.larger,
                      ),
                    },
                  ),
                ),
              ),
            );
          });
}
