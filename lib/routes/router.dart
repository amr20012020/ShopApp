import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:shop_app/modules/SignUp/SignUp_Screen.dart';
import 'package:shop_app/modules/admin/adminHome.dart';
import 'package:shop_app/modules/admin/adminSignUp.dart';
import 'package:shop_app/modules/login/Login_Screen.dart';
import 'package:shop_app/modules/onBoarding/on_boarding_screen.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/modules/splach_Screen/welcome_screen.dart';
import 'package:shop_app/routes/routes_names.dart';
// ده كلاس بيحدد مسار application من البدايه الي النهايه

class AppRouter {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutesNames.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutesNames.onBoardingScreen,
      page: () => OnBoardingScreen(),
    ),
    GetPage(
      name: AppRoutesNames.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutesNames.signUpScreen,
      page: () => SignUp_Screen(),
    ),
    GetPage(
      name: AppRoutesNames.HomeScreen,
      page: () => Home(title: '', UserName: '', UserImage: '',/* PhoneNumber: '',*/),
    ),
    GetPage(
      name: AppRoutesNames.adminScreen,
      page: () => AdminHome(ProductId: '',EmailAdmin: '', /*NameAdmin: ''*/),
    ),
    GetPage(
      name: AppRoutesNames.adminSignUpScreen,
      page: () => adminSignUp(),
    ),

  ];
}
