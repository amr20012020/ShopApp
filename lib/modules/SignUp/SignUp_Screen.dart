
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/login/Login_Screen.dart';
import 'package:shop_app/network/services/auth.dart';
import 'package:shop_app/provider/modelHud.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/utils/helper_functions.dart';
import 'package:shop_app/widgets/E-mailFormField.dart';
import 'package:shop_app/widgets/UserNameTextField.dart';
import 'package:shop_app/widgets/custom_textfield.dart';
import 'package:shop_app/widgets/passwordtextformfield.dart';
import 'package:shop_app/network/services/auth.dart';
import 'package:shop_app/widgets/phonetextformfield.dart';


class SignUp_Screen extends StatefulWidget {
  static String id = '/signup';
  // static String id = 'SignUp_Screen';

  @override
  _SignUpState createState() => _SignUpState();
}

final usersRef = FirebaseFirestore.instance.collection('users');

class _SignUpState extends State<SignUp_Screen> {
  List<dynamic> users = [];

  void initState(){
    getUsers();
    super.initState();
  }


  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool obserText = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var email = TextEditingController();
  var userName = TextEditingController();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();
 // var address = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Color textColor1 = Colors.white;
  Color textColor2 = Colors.tealAccent;
  String? _email, _password;
 // late String _email;
 // late String _password;
  String? _confirmPassword;
  bool remember = false;

  final List<String> errors = [];

  getUsers() async {
   final QuerySnapshot snapshot =  await usersRef.get();

  /* setState(() {
     users = snapshot.docs;
   });
 */
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.data);
        print(doc.id);
        print(doc.exists);
       });
  }

 /* getUserById() async{
      final String id = "HRXqWyc90cxJnsigqtJ8";
      final DocumentSnapshot doc =  await usersRef.doc(id).get();
      print(doc.data);
      print(doc.id);
      print(doc.exists);
  } */

  void adderror(String error) {
    if (errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeerror(String error) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context, listen: false).isLoading,
        child: SafeArea(
          child: Form(
            key: _globalKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight, end: Alignment.bottomLeft,
                        colors: [Colors.green, Colors.greenAccent],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  'Signup',
                                  style: TextStyle(
                                    color: textColor1,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.only(top: 45),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'We welcome you',
                                  style: TextStyle(
                                    color: textColor1,
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'With a E-Store',
                                  style: TextStyle(
                                    color: textColor1,
                                    fontSize: 25,
                                  ),
                                ),
                               /* SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Sent',
                                  style: TextStyle(
                                    color: textColor1,
                                    fontSize: 25,
                                  ),
                                ), */
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: UseNameTextField(
                      controller: userName,
                      name: 'UserName',
                      /*  validator: (value){
                        if(value!.isEmpty){
                          return 'UserName is empty';
                        }else if(value.length < 6){
                          return 'Fill UserName';
                        }
                      },
                      cursorColor: defaultColor,
                      decoration: InputDecoration(
                        hintText: 'UserName',
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        filled: true,
                        fillColor: whiteColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.green
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.green
                            )
                        ),
                      ), */
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: EmailFormField(
                      controller: email,
                      name: 'Email',
                      onSavedFn: (String? v) {  },
                    ),
                    /*EmailFormField(
                      controller: email,
                      Email: 'Email',
                      onSavedFn: (value) {
                        _email = value!;
                        value != null;
                      },
                      hintText: '',
                    ),*/
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: PhoneTextFormField(
                      controller: phoneNumber,
                      name: 'Phone Number',
                     // obserText: obserText,
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        setState(() {
                          obserText = !obserText;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: PasswordTextFormField(
                      controller: password,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          obserText = !obserText;
                        });
                      },
                      obserText: obserText,
                      name: 'Password',
                      onSavedFn: (value) {
                        _password = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Pass is empty';
                        }
                        if (value.length < 8) {
                          return 'Fill Password';
                        }
                      },
                      cursorColor: defaultColor,
                      decoration: InputDecoration(
                        hintText: 'Confirm Pass',
                        prefixIcon: Icon(
                          Icons.password_outlined,
                        ),
                        filled: true,
                        fillColor: whiteColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                    ),
                  ),
                  Padding(
                    //  alignment: Alignment.centerRight,
                    // margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          color: Colors.white,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Ok',
                                style: TextStyle(
                                  color: textColor2,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: textColor2,
                              ),
                            ],
                          ),
                          onPressed: () async {
                            final modelHud =
                                Provider.of<ModelHud>(context, listen: false);
                            modelHud.changeisLoading(true);
                            if (_globalKey.currentState!.validate()) {
                              _globalKey.currentState!.save();
                              try {
                                Provider.of<ModelHud>(context, listen: false);
                                // Navigator.pushNamed(context, ShopLayout().id);
                              /* Future<DocumentReference<Map<String, dynamic>>> userInfo =  FirebaseFirestore.instance.collection('users').doc('ybc01sOkUn7tDeTR5zZY').add({
                                 'UserName': userName,
                                 'Email' : email,
                                 'Phone' : phoneNumber,
                                 'Password' : password,
                                 }); */
                              // CollectionReference userInfo =
                              /* FirebaseFirestore.instance.collection('users').doc().set({
                                 'UserName': userName.text,
                                 'Email' : email.text,
                                 'Phone' : phoneNumber.text,
                                 'Password' : password.text,
                                  //'id' : auth.currentUser!.uid,
                               }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error")); */

                               /* FirebaseFirestore.instance.collection('users').doc().set({
                                  'UserName': userName.text,
                                  'Email' : email.text,
                                  'Phone' : phoneNumber.text,
                                  'Password' : password.text,
                                  //'id' : auth.currentUser!.uid,
                                }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error")); */

                                DocumentReference documentRefernce = FirebaseFirestore.instance.collection('users').doc();
                                documentRefernce.set({
                                  'UserName': userName.text,
                                  'Email' : email.text,
                                  'Phone' : phoneNumber.text,
                                  'Password' : password.text,
                                  'id': documentRefernce.id,
                                });
                             //  print(userInfo.id);
                              /* Future<void> addUser(){
                                 return userInfo.doc(userInfo.id).set({
                                   'UserName': userName.text,
                                   'Email' : email.text,
                                   'Phone' : phoneNumber.text,
                                  'Password' : password.text,
                                 }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));
                               } */
                              // addUser();
                              /*  FirebaseFirestore.instance.collection('users').add({
                                  'UserName': userName.text,
                                  'Email' : email.text,
                                  'Phone' : phoneNumber.text,
                                  'Password' : password.text,
                                }); */
                               // await _auth.signUp(email.text, password.text);
                                final userCredential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);
                                userCredential.user;
                                userCredential.toString();

                                ModelHud().changeisLoading(false);
                                print('success');
                             /*   UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: _email, password: _password); */
                               // userCredential.user;
                               // showToast(msg: userCredential.toString());
                                modelHud.changeisLoading(false);
                                Fluttertoast.showToast(msg: "Success");
                                chooseToastColor(ToastState.SUCCESS);
                               // Navigator.pushNamed(context, home());
                                navigateTo(context, LoginScreen());
                               // navigateAndFinish(context, LoginScreen());
                              } on PlatformException catch (e) {
                                Fluttertoast.showToast(msg: e.toString());
                                print(e.toString());
                              }
                            }
                            modelHud.changeisLoading(false);
                          },

                          /* {
                            final modelhud =
                            Provider.of<ModelHud>(context, listen: false);
                            modelhud.changeisLoading(true);
                            if (_globalKey.currentState!.validate()) {
                              _globalKey.currentState!.save();
                              try {
                                final authResult = await _auth.signUp(
                                    _email.toString(), _password.toString());
                                modelhud.changeisLoading(false);
                                print(authResult);
                                print('success');
                               // Navigator.pushNamed(context, ShopLayout().id);
                              } catch (e) {
                                print(e);
                                modelhud.changeisLoading(false);
                               // Scaffold.of(context).showSnackBar(SnackBar(
                                //  content: Text('Error'),
                               // ));
                              }
                            }
                          }, */
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: textColor2,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            navigateAndFinish(context, LoginScreen());
                            //   Navigator.of(context).pushNamed('/signup');
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
