import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

class PhoneTextFormField extends StatelessWidget{
 // final bool obserText;
  final TextEditingController controller;
  final String name;
 // final Function(String?) onSavedFn;

  final Function onTap;

  PhoneTextFormField({
    required this.controller,
    required this.onTap,
    required this.name,
   // required this.obserText,
   // required this.onSavedFn,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'Phone is empty';
        }else if(value.length < 11){
          return 'Fill Phone';
        }
      },
    //  onSaved: onSavedFn,
      controller: controller,
     // obscureText: obserText,
      cursorColor: defaultColor,
      decoration: InputDecoration(
        hintText: 'Phone Number',
        prefixIcon: Icon(
            Icons.phone,
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