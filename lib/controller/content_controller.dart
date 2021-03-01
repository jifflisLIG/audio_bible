import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bible_app/model/resources/reading_progress.dart';
import 'package:bible_app/provider/language_provider.dart';
import 'package:bible_app/repositories/content_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'main_controller.dart';

class ContentController extends GetxController {
  String data = '';
  bool isLoading = false;
  bool loadUrl;
  ReadingProgress readingProgress;

  final ContentRepository _repository = ContentRepository();
  final LanguageProvider _languageProvider = Get.find();
  final MainController _mainController = Get.find();
  final AudioPlayer audioPlayer = AudioPlayer();
  final int durationToUpdateReading = 10;

  static int readingTimerDuration = 0;
  static Timer timer;
  Rx<AudioState> audioState = AudioState.stop.obs;

  String audioPath;
  bool hasError = false;

  void init({@required ReadingProgress readingProgress, bool loadUrl = false}) {
    _listenAudioState();
    _cancelTimer();
    if (data.isNotEmpty) {
      _setLoading(false);
      _setReadingTimer();
      return;
    }

    this.readingProgress = readingProgress;
    this.loadUrl = loadUrl;

    if (loadUrl) {
      getChapter();
    }

    _mainController.selectedBottomIndex.listen((int i) {
      if (i != 1) {
        _cancelTimer();
      }
    });
  }

  void _listenAudioState() {
    audioPlayer.onSeekComplete.listen((_) {
      print('seek complete');
    });

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print(state);
      if (state == AudioPlayerState.PLAYING) {
        changeAudioState(AudioState.play);
      } else {
        changeAudioState(AudioState.pause);
      }
    });
  }

  void changeAudioState(AudioState audioState) {
    this.audioState.value = audioState;
    update();
  }

  void updateAudioState() {
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      _pauseAudio();
    } else if (audioPlayer.state == AudioPlayerState.PAUSED) {
      _resumeAudio();
    } else {
      _playAudio();
    }
  }

  Future<void> _pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> _resumeAudio() async {
    audioPlayer.resume();
  }

  Future<void> _playAudio() async {
    try {
      changeAudioState(AudioState.initializing);
      audioPath ??= await _getAudioUrl();
      await audioPlayer.play(audioPath, isLocal: true);
    } catch (e) {
      showToast('Unable to play audio. Please try again...');
      changeAudioState(AudioState.stop);
    }
  }

  Future<String> _getAudioUrl() async {
    return await _repository.getAudioUrl(
      _languageProvider.language.audioID,
      readingProgress.chapterID,
    );
  }

  Future<void> getChapter() async {
    hasError = false;
    _setLoading(true);
    try {
      data = await _repository.getChapter(
          (_languageProvider.language).id, readingProgress.chapterID);
    } catch (_) {
      showToast(
        'Unable to load contents. Please try again...',
        position: ToastPosition.bottom,
      );
      hasError = true;
    }
    isLoading = false;
    _setReadingTimer();
    refresh();
  }

  void _setLoading(bool isLoading) {
    this.isLoading = isLoading;
    refresh();
  }

  void _cancelTimer() {
    if (timer != null) {
      timer.cancel();
    }
  }

  void _setReadingTimer() {
    readingTimerDuration = 0;

    _cancelTimer();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      readingTimerDuration++;
      if (readingTimerDuration >= durationToUpdateReading) {
        //save last reading
        _repository.saveReadingProgress(readingProgress);
        timer.cancel();
      }
    });
  }
}

enum AudioState { initializing, play, pause, stop }
