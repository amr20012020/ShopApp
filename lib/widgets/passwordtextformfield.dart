import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

class PasswordTextFormField extends StatelessWidget{
  final bool obserText;
  final TextEditingController controller;
  final String name;
  String? _confirmPassword;
  final Function(String?) onSavedFn;

  final Function onTap;

  PasswordTextFormField({
    required this.controller,
    required this.onTap,
    required this.name,
    required this.obserText,
    required this.onSavedFn,
});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'Password is empty';
        }else if(value.length < 8){
          return 'Fill Password';
        }
      },
      onSaved: onSavedFn,
      controller: controller,
      obscureText: obserText,
      cursorColor: defaultColor,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: Icon(
            Icons.password
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
      ),
    );
  }

}