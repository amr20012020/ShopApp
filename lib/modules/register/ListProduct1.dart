import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/service/store.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/NotificationButton.dart';
import 'package:shop_app/widgets/custom_text.dart';

import 'home.dart';

/*class ListProduct1 extends StatefulWidget {
  final String name;
 final List<Product> snapShot;

  ListProduct1({required this.name, required this.snapShot});

  @override
  State<ListProduct1> createState() => _ListProduct1State();
}

class _ListProduct1State extends State<ListProduct1> {
  final productRef = FirebaseFirestore.instance
      .collection("products")
      .doc("3Mlk4LvGtj13wImlWXoK")
      .collection('ListProduct');

  final _store = Store();

  @override
  void initState() {
    super.initState();
    getproduct();
  }

 List<String> getproduct(){
    List<String> names = [];
    productRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        names.add(doc["name"]);
      });
    });
    return names;
  }

/*  buildproduct(){
    return StreamBuilder(
        stream: productRef.doc().snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          List<Product> p = [];
          snapshot.requireData.docs.ForEach{

          }
        }
    )
  } */

  Widget featuresAndViewMore() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 8.0, right: 8.0, top: 15.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomText(
            text: "Featured",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: primaryColor,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home(title: '', UserName: '',)));
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.green,
          ),
        ),
        // backgroundColor: Colors.grey[100],
        elevation: 0.0,
        actions: [
          IconButton(
            color: primaryColor,
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          SizedBox(
            width: 7,
          ),
          NotificationButton(),
        ],
      ),
      body: Container(
        child: getproduct(),
      ),

    );
  }
}*/
