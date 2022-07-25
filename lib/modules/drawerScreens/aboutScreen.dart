import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/shared/styles/colors.dart';

class About extends StatefulWidget {
  final String title;
  final String UserName;
  const About({Key? key, required this.title, required this.UserName,}) : super(key: key);

  @override
  State<About> createState() => _AboutState(UserName: UserName, title: title);
}

class _AboutState extends State<About> {
  final String title;
  final String UserName;
  _AboutState({required this.title,required this.UserName,});

  @override
  Widget build(BuildContext context) {
    List<String> countries = ["Members of ESCP APP :-","1- Hussein Atef (team leader)", "2- Rafat Elshahed Eshak", "3- Amr Ahmed", "4- Rana Mohamed", "5- Daniel Emad",
      "project details :-"
          "                                                                                                              "
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
      "App version 2.0.0",  "يعد هذا المشروع ملكا لطلاب مودرن اكاديمى و تم انشاءه فى عام 2021 كمشروع تخرج لهم بتقدير عام امتياز , و قد اشرف عليه دكتور لمياء حسن و دكتور رنا محمد , كما يعد هذا المشروع من المشروعات الرائدة و الخ الخ",
      "صفحة التسجيل و الحساب :-   "

          "                                  يجب عليك اولا ملئ جميع الخانات بطريقة صحيحة حتى تتمكن من الدخول للصفحة الرئيسية و الاستمتاع بالتطبيق"
      ,];

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: primaryColor,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home(title: title, UserName: UserName, UserImage: '',/* PhoneNumber: '',*/)));
            },
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.green,
            ),
          ),
            title: Text("INFO"),
         //   backgroundColor: Colors.amber
        ),
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Scrollbar(
                isAlwaysShown: true, //always show scrollbar
                //    thickness: 0, //width of scrollbar
                radius: Radius.circular(20), //corner radius of scrollbar
                scrollbarOrientation: ScrollbarOrientation.top, //which side to show scrollbar
                child:ListView(
                  children: countries.map((country){
                    return Card(
                        child:ListTile(
                            title: Text(country, style: TextStyle(fontWeight: FontWeight.bold),)

                        )
                    );
                  }).toList(),
                )
            )
        )
    );
  }
}
