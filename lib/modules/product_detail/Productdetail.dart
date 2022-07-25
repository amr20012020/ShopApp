import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/cartPage/cart.dart';
import 'package:shop_app/modules/pie_chart/pie_chart_page.dart';
import 'package:shop_app/modules/product_detail/test.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/widgets/NotificationButton.dart';

import '../../network/services/auth.dart';
import '../../provider/AdminMode.dart';
import '../../provider/modelHud.dart';
import '../admin/adminHome.dart';

class ProductDetail extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String description;
  final String Category;
  final String Producing_Company;
  final String title;
  final String UserName;
  final String ProductId;
  final String userId;
  //int positiveCount;
  //int negativeCount = 0;
  //int mixedCount = 0;
  //final Widget image;
  ProductDetail(this.image, this.name, this.price,this.Category,this.Producing_Company, this.description, {required this.title, required this.UserName,required this.ProductId, required this.userId});
  @override
  State<ProductDetail> createState() => _ProductDetailState(title: title, ProductId: ProductId, UserName: UserName, userId: userId);
}

class _ProductDetailState extends State<ProductDetail> {
  final String UserName;
  final String title;
  final String ProductId;
  final String userId;
  _ProductDetailState({required this.title, required this.ProductId, required this.UserName, required this.userId});

  @override
  void initState() {
    super.initState();
  }
  final globalKey = GlobalKey<FormState>();
  final _auth = Auth();

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
              child: /*Image.network((widget.image ?? ""), fit: BoxFit.cover,),*/
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



  var image = [];
  var nameproduct = [];
  var description = [];
  var price = [];
  var productId = [];
  var producing_Company = [];
  var category = [];

  /*void adminButton(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (globalKey.currentState != null && globalKey.currentState!.validate()
    /*widget.globalKey.currentState!.validate()*/
    ) {
      globalKey.currentState!.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        try {
          navigateTo(context, AdminHome(/*EmailAdmin: emailController.text,AdminName: admins[0],*/));
          // navigateTo(context, admin(UserName: admins[0], title: emailController.text,));
        } catch(e){
          Fluttertoast.showToast(msg: "Error Admin");
          // showToast(msg: e.toString());
          // showToast(msg: _email);
          chooseToastColor(ToastState.ERROR);
          print(e.toString());
        }
      }
    }
    modelhud.changeisLoading(false);
  } */

  Widget _buildButtonPart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        child: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => cart(name: widget.name, price: widget.price, image: widget.image, title: title, UserImage: '', UserName: UserName, PhoneNumber: '',),
            ));
          }, icon: Icon(Icons.add_shopping_cart),
          ),
        ),
    );
  }

  int positiveCount = 0;
  int negativeCount = 0;
 // int mixedCount = 0;

  double counter = 0;

  final counterRef = FirebaseFirestore.instance.collection('counters');


  Widget product(
      {required String name,
        required int price,
        required String image,
        required String description,
        required String Category,
        required String Producing_Comapny,
        required String id}) {
    /*return Card(
      child: Container(
        height: 250,
        width: 180,
        //  color: Colors.blue,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) =>
                        ProductDetail(image, "Hp Envy x360", 100)));
              },
            ),
            Container(
              height: 250,
              width: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      "assets/images/$image",
                    )),
              ),
            ),
            Text(
              "\$ $price",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xff9b96d6)),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    ); */
    return Column(
      children: [
        Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  child: Container(
                    height: 250,
                    width: 350,
                    child: Column(
                      children: <Widget>[
                        /* Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                  builder: (ctx) =>
                                      ProductDetail(image, name, price)));
                            },
                          ),
                        ), */
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                builder: (ctx) => ProductDetail(
                                  image,
                                  name,
                                  price.toString(),
                                  description,
                                  Category,
                                  Producing_Comapny,
                                  title: title,
                                  UserName: UserName,
                                  ProductId: id.toString(),
                                  userId: '',
                                )));
                            print("well");
                            print(UserName);
                          },
                          child: Container(
                            height: 170,
                            width: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(image),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "\$ $price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xff9b96d6)),
                        ),
                        Text(
                          name,
                          style: TextStyle(fontSize: 17),
                        ),
                        //Text(ProductId, style: TextStyle(fontSize: 17),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> Trying({
     required String name,
     required int price,
     required String image,
     required String description,
     required String Category,
     required String Producing_Comapny,
     required String id}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Sorry! You are not admin"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => /*ProductDetail(
                        image,
                        name,
                        price.toString(),
                        description,
                        Category,
                        Producing_Comapny,
                        title: title,
                        UserName: UserName,
                        ProductId: id.toString(),
                        userId: '',
                      )*/
                    Home(title: title, UserName: UserName, UserImage: '', /*PhoneNumber: '',*/),
                  ));
                },
                child: Text("Cancel")),
          ],
        ));
  }

  getCount() async{
    final DocumentSnapshot doc =  await counterRef.doc(ProductId).get();
    if(doc.exists) {
      print(doc.get("positiveCount"));
      positiveCount = doc.get("positiveCount");
      negativeCount = doc.get("negativeCount");
     counter = doc.get("positiveCount").toDouble() + doc.get("negativeCount").toDouble();
      //counter = double.parse(doc.get("positiveCount")) + double.parse(doc.get("negativeCount")) + double.parse(doc.get("mixedCount"));
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => Pie_chart_Page(ProductId: ProductId,negativeCount: negativeCount, positiveCount: positiveCount,counter: counter, Email: '', Name: '',),
      ),
    );
    //final QuerySnapshot snapshot =  await counterRef.doc.get();
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
                  builder: (ctx) => Home(title: title, UserName: UserName, UserImage: '', /*PhoneNumber: '',*/),
                ),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Trying(name: nameproduct.toString(), price: price.toString().length, image: image.toString(), description: description.toString(), Category: category.toString(), Producing_Comapny: producing_Company.toString(), id: productId.toString());
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    // color: Color(0xff9b96d6),
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
                                widget.Category,
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
                            widget.description,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              // color: Color(0xff9b96d6),
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
                              // color: Color(0xff9b96d6),
                            ),
                          ),
                        ],
                      ),
                      height: 60,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Wrap(
                        children: <Widget>[
                          _buildButtonPart(),
                          SizedBox(width: 150,),
                          IconButton(onPressed: (){
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => CommentScreen1(title: title, UserName: UserName, productID: ProductId, userId: userId)
                                ));
                            //showToast(msg: UserName);
                          },
                              icon: Icon(Icons.comment)),
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
