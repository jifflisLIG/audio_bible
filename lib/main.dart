
import 'package:bible_app/provider/home_binding.dart';
import 'package:bible_app/provider/language_provider.dart';
import 'package:bible_app/repositories/local_db.dart';
import 'package:bible_app/screen/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'controller/language_controller.dart';
import 'environment.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


@override
  Widget build(BuildContext context) {
    LocalDB.getInstance().initialize();
    return OKToast(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.orange,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialBinding: HomeBinding(),
        navigatorKey: Routes.rootNavigatorKey,
        initialRoute: Routes.SCREEN_MAIN,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}

