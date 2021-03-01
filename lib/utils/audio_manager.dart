import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class AudioManager{
  static Future<File> getFileFromServer(
      String url, String fileName, String dir) async {
    final HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url;
      final HttpClientRequest request =
      await httpClient.getUrl(Uri.parse(myUrl));
      final HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final Uint8List bytes =
        await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
        return file;
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
      print(filePath);
    } catch (ex) {
      filePath = 'Can not fetch url';
      print(filePath);
    }
    return file;
  }

  static Future<String> getTemporaryPath() async {
    final Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }
}