import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/user_model.dart';

class UserProvider with ChangeNotifier{
  
  late UserDataModel currentData;

 /* void addUserData({
    required User currentUser,
    required String userName,
    required String userImage,
    required String userEmail,
  }) async {
    await FirebaseFirestore.instance
        .collection("usersData")
        .doc(currentUser.uid)
        .set(
      {
        "userName": userName,
        "userEmail": userEmail,
        "userImage": userImage,
        "userUid": currentUser.uid,
      },
    );
  } */

 /* late UserDataModel userDataModel;

  void getUserData() async{

    var value = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();
    if(value.exists){
      userDataModel = UserDataModel(
           email: value.get("Email"),
          userName: value.get("UserName"),
          uid: currentData.uid,
      );
      currentData = userDataModel;
      notifyListeners();
    }
  }

  UserDataModel get currentUserData{
    return currentData;
  } */


}