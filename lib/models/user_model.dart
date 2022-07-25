// ملخص هذا الكلاس ان اي حاجه user بيدخلها من بيانات بناخذ البيانات و نحولها الي jsonfile علشان تترفع علي database


class UserDataModel {
  String? userName;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;
  String? uid;
  // String? pic;

  UserDataModel(
    this.userName,
    this.email,
    this.phone,
    this.password,
    this.confirmPassword,
    this.uid,
    // this.pic,
  );

  UserDataModel.fromJson(Map<String, dynamic> json) {
    if(json == null){
      return ;
    }
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    uid = json['uid'];
    // pic = json['pic'];
  }

  toJson(){
    return {
      'userId' : uid,
      'userName' : userName,
      'email' : email,
      'phone' : phone,
      // 'pic' : pic,
      'password' : password,
      'confirmPassword' : confirmPassword,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'phone': phone,
      //  'pic' : pic,
      'password': password,
      'confirmPassword': confirmPassword,
      'uid': uid,
    };
  }
}

/*import 'package:flutter/cupertino.dart';

class UserModel {
  String userName,
      email,
      phone,
      userPhoneNumber,
      userImage,
      userAddress;
  UserModel(
      {
        required this.email,
        required this.userImage,
        required this.userAddress,
        required this.phone,
        required this.userName,
        required this.userPhoneNumber
      });
} */

