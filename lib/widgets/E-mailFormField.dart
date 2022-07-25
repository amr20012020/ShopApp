import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shop_app/shared/styles/colors.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final Function(String?) onSavedFn;

  EmailFormField({
    required this.controller,
    required this.name,
    required this.onSavedFn,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'Email is empty';
        }else if(value.length < 6){
          return 'Fill Email';
        }
      },
      controller: controller,
      cursorColor: defaultColor,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(
          Icons.email,
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