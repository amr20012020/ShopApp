import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/SignUp/SignUp_Screen.dart';
import 'package:shop_app/modules/login/Login_Screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingModel {
  final String image;
  final String title;
  final String subTitle;

  onBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

List<onBoardingModel> models = [
  onBoardingModel(
    image: 'assets/images/onborad_1.png',
    title: 'Start Ordering Online',
    subTitle: 'With Extremely Simple Steps.',
  ),
  onBoardingModel(
    image: 'assets/images/onborad_2.png',
    title: 'Choose Something To Buy',
    subTitle: 'With High Quality.',
  ),
  onBoardingModel(
    image: 'assets/images/onborad_3.png',
    title: 'Very Fast Delivery',
    subTitle: 'Within 2 Days At Most.',
  ),
];

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  static const String id = 'onBoardingScreen';
  var pageController = PageController();

  int pageIndex = 0;

  bool isLast = false;
  bool? value;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value = true) {
     //  navigateAndFinish(context, LoginScreen());
       // navigateTo(context, homeView());
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: Text('SKIP'),
          ),
          SizedBox(
            width: 3,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (int index) {
                  if (index == models.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemCount: 3,
                itemBuilder: (context, index) {
                  pageIndex = index;
                  return buildOnBoardingItem(models[index]);
                },
                physics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: models.length),
                Spacer(),
                FloatingActionButton(
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onPressed: () {
                    if (isLast) {
                      submit();
                      // navigateAndFinish(context, ShopLoginScreen());
                    }
                    if (pageIndex < 2) {
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastOutSlowIn,
                      );
                    } else {
                      submit();
                    }
                    pageController.nextPage(
                      duration: Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildOnBoardingItem(onBoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.subTitle}',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
