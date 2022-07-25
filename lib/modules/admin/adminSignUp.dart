import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/login/Login_Screen.dart';
import 'package:shop_app/network/services/auth.dart';
import 'package:shop_app/provider/modelHud.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/AddressCompanyTextField.dart';
import 'package:shop_app/widgets/CompanyNameTextField.dart';
import 'package:shop_app/widgets/E-mailFormField.dart';
import 'package:shop_app/widgets/passwordtextformfield.dart';
import 'package:shop_app/widgets/phonetextformfield.dart';

class adminSignUp extends StatefulWidget {
  static String id = '/adminSignup';

  @override
  _adminSignUpState createState() => _adminSignUpState();
}

class _adminSignUpState extends State<adminSignUp> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool obserText = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var email = TextEditingController();
  var AdminName = TextEditingController();
  var address = TextEditingController();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Color textColor1 = Colors.white;
  Color textColor2 = Colors.greenAccent;
  String? _email, _password;
  String? _confirmPassword;
  bool remember = false;

  final List<String> errors = [];

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
                    height: 120,
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
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "AdminSignUp",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CompanyNameTextField(
                      controller: AdminName,
                      name: 'Admin Name',
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AddressCompanyTextField(
                      controller: address,
                      name: 'Address',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: PhoneTextFormField(
                      controller: phoneNumber,
                      name: 'Phone Number',
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
                                DocumentReference documentRefernce = FirebaseFirestore.instance.collection('admins').doc();
                                documentRefernce.set({
                                  'AdminName': AdminName.text,
                                  'Email' : email.text,
                                  'Address' : address.text,
                                  'Phone' : phoneNumber.text,
                                  'Password' : password.text,
                                  'id': documentRefernce.id,
                                }).then((value) => print("Admin Added")).catchError((error) => print("Failed to add admin: $error"));
                                final userCredential = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);
                                userCredential.user;
                                userCredential.toString();

                                ModelHud().changeisLoading(false);
                                print('success');

                                modelHud.changeisLoading(false);
                                Fluttertoast.showToast(msg: "Success");
                                chooseToastColor(ToastState.SUCCESS);

                                navigateTo(context, LoginScreen());
                              } on PlatformException catch (e) {
                                Fluttertoast.showToast(msg: e.toString());
                                print(e.toString());
                              }
                            }
                            modelHud.changeisLoading(false);
                          },
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
