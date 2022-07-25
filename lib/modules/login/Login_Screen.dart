import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/SignUp/SignUp_Screen.dart';
import 'package:shop_app/modules/admin/AddProduct.dart';
import 'package:shop_app/modules/admin/adminHome.dart';
import 'package:shop_app/modules/admin/adminSignUp.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/network/services/auth.dart';
import 'package:shop_app/provider/AdminMode.dart';
import 'package:shop_app/provider/modelHud.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/E-mailFormField.dart';
import 'package:shop_app/widgets/custom_logo.dart';
import 'package:shop_app/network/services/auth.dart';
import 'package:shop_app/widgets/passwordtextformfield.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  const LoginScreen(
      {Key? key,})
      : super(key: key);


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final usersRef = FirebaseFirestore.instance.collection('users');
final adminsRef = FirebaseFirestore.instance.collection('admins');

class _LoginScreenState extends State<LoginScreen> {
  static const String id = 'loginScreen';
  final globalKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool obserText = true;

  bool isAdmin = false;
  bool keepMeLoggedIn = false;
  bool _isObscure = true;

  final _auth = Auth();

  String? _email, password;
  var users = [];
  var admins = [];


  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _validate(context);
  }



  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: globalKey,
        child: ListView(
          children: <Widget>[
            CustomLogo(),
            SizedBox(
              height: height * .1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: EmailFormField(
                controller: emailController,
                name: 'Email',
                onSavedFn: (value) {
                  _email = value!;
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: PasswordTextFormField(
                controller: passwordController,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    obserText = !obserText;
                  });
                },
                obserText: obserText,
                name: 'Password',
                onSavedFn: (value) {
                  password = value!;
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    color: Colors.teal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    onPressed: () {
                      _validate(context);
                      adminButton(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have account ?',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateAndFinish(context, SignUp_Screen());
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'If You admin?',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateAndFinish(context, adminSignUp());
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(true);
                      },
                      child: Text(
                        'I\'m an admin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? defaultColor
                              : Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(false);
                      },
                      child: TextButton(
                        onPressed: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(false);
                        },
                        child: Text(
                          'I\'m an user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context, listen: true).isAdmin ? Colors.white : defaultColor,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (globalKey.currentState != null && globalKey.currentState!.validate()
        ) {
      globalKey.currentState!.save();
     if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        try {
          await _auth.signIn(emailController.text, passwordController.text);
          CollectionReference adminInfo =
          FirebaseFirestore.instance.collection('admins');
          print(_email);
          print(password);
          final QuerySnapshot snapshot = await usersRef.get();
          snapshot.docs.forEach((DocumentSnapshot doc) {
            if (emailController.text == doc.get("Email")) {
              print(doc.get("Email"));
              admins.add(doc.get("AdminName"));
            }
          });
          navigateTo(context, AdminHome(ProductId: '',EmailAdmin: emailController.text,/*NameAdmin: admins[0],*/));
        } catch(e){
          Fluttertoast.showToast(msg: "Error Admin");
          chooseToastColor(ToastState.ERROR);
          print(e.toString());
        }
      } else {
        try {
           await _auth.signIn(emailController.text, passwordController.text);
          CollectionReference userInfo =
              FirebaseFirestore.instance.collection('users');
           final QuerySnapshot snapshot = await usersRef.get();
           snapshot.docs.forEach((DocumentSnapshot doc) {
             if (emailController.text == doc.get("Email")) {
               users.add(doc.get("UserName"));
             }
           });

           FirebaseFirestore.instance.collection('users').get();
          navigateTo(context, Home(title: emailController.text, UserName: users[0], UserImage: '', /*PhoneNumber: '',*/));
        } catch (e) {
          Fluttertoast.showToast(msg: "Error");
          chooseToastColor(ToastState.ERROR);
          print(e.toString());
        }
      }
    }
    modelhud.changeisLoading(false);
  }


  void adminButton(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (globalKey.currentState != null && globalKey.currentState!.validate()
    ) {
      globalKey.currentState!.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        try {
          await _auth.signIn(emailController.text, passwordController.text);
          CollectionReference adminInfo =
          FirebaseFirestore.instance.collection('admins');
          navigateTo(context, AdminHome(ProductId: '',EmailAdmin: emailController.text,/*NameAdmin: admins[0],*/));
        } catch(e){
          Fluttertoast.showToast(msg: "Error Admin");
          chooseToastColor(ToastState.ERROR);
          print(e.toString());
        }
      }
    }
    modelhud.changeisLoading(false);
  }
}
