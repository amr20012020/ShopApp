import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

class AddressCompanyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;

  AddressCompanyTextField({
    required this.controller,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'Address is empty';
        }else if(value.length < 6){
          return 'Fill Address';
        }
      },
      controller: controller,
      cursorColor: defaultColor,
      decoration: InputDecoration(
        hintText: 'Address',
        prefixIcon: Icon(
          Icons.location_on,
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