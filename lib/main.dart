import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dartz/dartz.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/modules/SignUp/SignUp_Screen.dart';
import 'package:shop_app/modules/onBoarding/on_boarding_screen.dart';
import 'package:shop_app/modules/splach_Screen/welcome_screen.dart';
import 'package:shop_app/provider/AdminMode.dart';
import 'package:shop_app/provider/modelHud.dart';
import 'package:shop_app/routes/router.dart';
import 'package:shop_app/routes/routes_names.dart';
import 'package:shop_app/shared/components/constance.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:get/get.dart';
import 'package:shop_app/utils/size_config.dart';
import 'package:shop_app/utils/validator.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/SessionManagment.dart';
import 'modules/login/Login_Screen.dart';
import 'modules/register/home.dart';
import 'network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManagement.init();
  await CacheHelper.init();
  await Firebase.initializeApp();

  String uid = CacheHelper.getData('uid') ?? '';
  Widget startScreen;
  uid.isNotEmpty ? startScreen = Home(title: '', UserName: '', UserImage: '',) : startScreen = LoginScreen();

  Widget widget;

  bool? isDark = CacheHelper.getData('isDark');
  bool? onBoarding = CacheHelper.getData('onBoarding');

  if (onBoarding != null) {
    if (Token != null)
      widget = Home(title: '', UserName: '', UserImage: '',);
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}


class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  final bool? isDark;


  late final Widget startWidget;

  MyApp({
    this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Loading....'),
                ),
              ),
            );
          } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModelHud>(
                    create: (context) => ModelHud()),
                ChangeNotifierProvider<AdminMode>(
                    create: (context) => AdminMode()),
              ],
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return OrientationBuilder(builder: (context, orientation) {
                    init(constraints, orientation);
                    return GetMaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Shopping',
                      theme: lightTheme,
                      darkTheme: darkTheme,
                      themeMode: ThemeMode.light,
                      getPages: AppRouter.pages,
                      initialRoute: AppRoutesNames.splashScreen,
                      home: startWidget,
                    );
                  });
                },
              ),
            );
          }
        });
  }
}
