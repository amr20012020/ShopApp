import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/admin/EditProduct.dart';
import 'package:shop_app/modules/admin/adminHome.dart';
import 'package:shop_app/modules/admin/edit.dart';

import '../../core/service/store.dart';
import '../../network/services/auth.dart';
import '../../shared/components/components.dart';
import '../../widgets/NotificationButton.dart';
import '../pie_chart/pie_chart_page.dart';
import '../profilePage/ProfileView.dart';

class ProductDetailAdmin extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String description;
  final String Category;
  final String Producing_Company;
  final String Email;
  final String UserName;
  final String ProductId;
  final String userId;
  //int positiveCount;
  //int negativeCount = 0;
  //int mixedCount = 0;
  //final Widget image;
  ProductDetailAdmin(this.image, this.name, this.price,this.Category,this.Producing_Company, this.description, {required this.Email, required this.UserName,required this.ProductId, required this.userId});
  @override
  State<ProductDetailAdmin> createState() => _ProductDetailAdminState(Email: Email, ProductId: ProductId,
      UserName: UserName, userId: userId,
      name: name, Producing_Company: Producing_Company,
      description: description, image: image,
      Category: Category, price: price);
}

class _ProductDetailAdminState extends State<ProductDetailAdmin> {
  final String UserName;
  final String Email;
  final String ProductId;
  final String userId;
  final String image;
  final String name;
  final String price;
  final String description;
  final String Category;
  final String Producing_Company;
  _ProductDetailAdminState({required this.Email, required this.ProductId,
    required this.UserName, required this.userId,
    required this.name,required this.price,
    required this.image, required this.description,
    required this.Category, required this.Producing_Company});

  @override
  void initState() {
    super.initState();
  }
  final globalKey = GlobalKey<FormState>();
  final _auth = Auth();
  final _store = Store();

  final productRef = FirebaseFirestore.instance
      .collection("products")
      .doc("3Mlk4LvGtj13wImlWXoK")
      .collection('ListProduct');

  int count = 1;

  Widget ImageBox() {
    return Center(
      child: Container(
        width: 380,
        child: Card(
          elevation: 60,
          shadowColor: Colors.teal.shade200,
          child: Container(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/product_image/${widget.image}"),
                ),
              ),
              child:
              CachedNetworkImage(
                imageUrl: widget.image,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }



  int positiveCount = 0;
  int negativeCount = 0;
 // int mixedCount = 0;

  double counter = 0;

  final counterRef = FirebaseFirestore.instance.collection('counters');

  getCount() async{
    final DocumentSnapshot doc =  await counterRef.doc(ProductId).get();
    if(doc.exists) {
      print(doc.get("positiveCount"));
      positiveCount = doc.get("positiveCount");
      negativeCount = doc.get("negativeCount");
     // mixedCount = doc.get("mixedCount");
      counter = doc.get("positiveCount").toDouble() + doc.get("negativeCount").toDouble();
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => Pie_chart_Page(ProductId: ProductId,negativeCount: negativeCount, positiveCount: positiveCount,counter: counter, Email: Email, Name: name,),
      ),
    );
  }


  Widget delteproduct(
      {required String id}) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () async{
                await productRef
                    .doc(id)
                    .delete()
                    .then((value) => print("delete"));
                _store.deleteProduct1(ProductId.toString());
                //_store.deleteProduct(Prod);
              },
              icon: Icon(Icons.delete),
              alignment: Alignment.bottomRight,
            ),
          ],
        ),
                       /* Container(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                              onPressed: () async {
                                await productRef
                                    .doc(id)
                                    .delete()
                                    .then((value) => print("delete"));
                                _store.deleteProduct1(ProductId.toString());
                              },
                              icon: Icon(Icons.delete)),
                        )*/
                      ]
    );
  }


  _buildTextField(TextEditingController controller, String labelText){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.teal,
        border: Border.all(color: Colors.green),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.name, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => AdminHome(ProductId: ProductId, EmailAdmin: Email, /*NameAdmin: name,*/),
                ),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                getCount();
              },
              icon: Icon(
                Icons.bar_chart,
                color: Colors.teal,
              ),
            ),
            NotificationButton(),
          ],
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ImageBox(),
                    Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "\$ ${widget.price.toString()}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            height: 60,
                          ),
                          Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        height: 150,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Wrap(
                            children: <Widget>[
                              Text(
                                widget.description,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                widget.ProductId,
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.Category,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      height: 60,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Company",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.Producing_Company,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      height: 60,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(width: 150,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () async{
                                  await productRef
                                      .doc(ProductId)
                                      .delete()
                                      .then((value) => print("delete"));
                                  //_store.deleteProduct1(ProductId.toString());
                                  print("delete");
                                  delteproduct(id: ProductId);
                                  //_store.deleteProduct(Prod);
                                },
                                icon: Icon(Icons.delete,color: Colors.red,),
                                alignment: Alignment.bottomRight,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Wrap(
                        children: <Widget>[
                          SizedBox(width: 150,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // _buildButtonPart(),
            ],
          ),
        ));
  }
}

