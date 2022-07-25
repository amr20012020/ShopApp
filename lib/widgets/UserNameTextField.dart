import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

class UseNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;

  UseNameTextField({
    required this.controller,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'UserName is empty';
        }else if(value.length < 6){
          return 'Fill UserName';
        }
      },
      controller: controller,
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
      ),
    );
  }
}