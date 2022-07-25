import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/user_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> feature = [];
  late Product featureData;

  List<UserDataModel> userModelList = [];
  late UserDataModel userModel;

  late UserDataModel userDataModel;
  
  Future<void> getUserData() async{
    List<UserDataModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot = await FirebaseFirestore.instance
     .collection("users").get();
    userSnapShot.docs.forEach(
            (element) {
                  if(currentUser!.uid == element.data().toString()["UserId".length]){
                    userModel = UserDataModel(
                        element.data().toString()["UserName".length],
                        element.data().toString()["Email".length],
                        element.data().toString()["Phone".length],
                        element.data().toString()["Password".length],
                        element.data().toString()["ConfirmPassword".length],
                        element.data().toString()["UserId".length]);
                    newList.add(userModel);
                  }
                  userModelList = newList;
    });
  }

  List<UserDataModel> get getUserModelList {
    return userModelList;
  }

  /*UserDataModel get getUserModel {
    return userDataModel;
  } */



  List<Product> get getFeatureList {
    return feature;
  }

  List<Product> homeFeature = [];

  List<Product> get getHomeFeatureList {
    return homeFeature;
  }

  List<Product> homeAchive = [];


  List<Product> get getHomeAchiveList {
    return homeAchive;
  }

  List<Product> newAchives = [];
  late Product newAchivesData;

  List<Product> get getNewAchiesList {
    return newAchives;
  }
}

