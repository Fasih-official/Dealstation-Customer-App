import 'package:country_code_picker/country_localizations.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:memberApp/utils/app_preferences.dart';
import 'package:memberApp/utils/colors.dart';
import 'package:memberApp/utils/constants.dart';
import 'package:memberApp/utils/routes.dart';
import 'package:memberApp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  globalPreferences = await SharedPreferences.getInstance();
}

void main() async {
  await initialize();

  FBroadcast.instance().register(BroadcastEvent.EVENT_API_ERROR_HANDLING, (value, callback) {
    if(isNotEmpty(value)){
      if(value is Map){
        var statusCode = value['statusCode'];
        var errMsg = value['errMsg'];
        if(statusCode == 401){
          myNavigatorKey.currentState?.pushNamedAndRemoveUntil(NamedRoutes.routeSignUp, (route) => false);
        }
        myScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
          content: Text(errMsg.toString()),
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
  });

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      startLocale: Locale('en'),
      path: 'assets/translations',
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  var key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: key,
      navigatorKey: myNavigatorKey,
      scaffoldMessengerKey: myScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates
        ..add(CountryLocalizations.delegate),
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Deals Station',
      theme: ThemeData(
        primarySwatch: appBarColorSwatch,
      ),
      initialRoute: NamedRoutes.routeSplash,
      getPages: Routes.pages,
    );
  }
}
