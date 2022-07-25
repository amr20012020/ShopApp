import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

class CompanyNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;

  CompanyNameTextField({
    required this.controller,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'AdminName is empty';
        }
      },
      controller: controller,
      cursorColor: defaultColor,
      decoration: InputDecoration(
        hintText: 'AdminName',
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