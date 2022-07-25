import 'dart:math';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/SignUp/SignUp_Screen.dart';
import 'package:shop_app/modules/cartPage/cart.dart';
import 'package:shop_app/modules/drawerScreens/Connect%20us.dart';
import 'package:shop_app/modules/drawerScreens/aboutScreen.dart';
import 'package:shop_app/modules/login/Login_Screen.dart';
import 'package:shop_app/modules/product_detail/Productdetail.dart';
import 'package:shop_app/modules/profilePage/ProfileView.dart';
import 'package:shop_app/provider/category_provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/provider/user_provider.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/bottomTabs.dart';
import 'package:shop_app/widgets/custom_text.dart';
import 'ListProduct.dart';
import 'ListProduct1.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.title,
    required this.UserName,
    required this.UserImage,
    //required this.PhoneNumber,
  }) : super(key: key);
  final String title;
  final String UserName;
  final String UserImage;
  //final String PhoneNumber;
  @override
  _HomeState createState() => _HomeState(title: title, UserName: UserName, UserImage: UserImage, /*PhoneNumber: PhoneNumber*/);
}

late Product mobiledata;
late Product headPhonedata;
late Product speakersdata;
late Product computersdata;
late Product mousedata;

class _HomeState extends State<Home> {
  final String title;
  final String UserName;
  final String UserImage;
  //final String PhoneNumber;
  _HomeState({required this.title, required this.UserName,required this.UserImage, /*required this.PhoneNumber*/});

  ProductProvider? productProvider;
  List<Product> pro = [];

  @override
  void initState() {
    super.initState();
    //setProduct();
    getProduct();
    //getProduct().then((value) => print(value[0]));
    //print("Ahmed" + getProduct().toString());
  }

  late double height, width;

  final productRef = FirebaseFirestore.instance
      .collection("products")
      .doc("3Mlk4LvGtj13wImlWXoK")
      .collection('ListProduct');

  var image = [];
  var nameproduct = [];
  var description = [];
  var price = [];
  var productId = [];
  var producing_Company = [];
  var category = [];
                /*===============================================*/
  Future<String> getProduct() async {
    final QuerySnapshot snapshot = await productRef.get();
    snapshot.docs.forEach((DocumentSnapshot doc) {
      image.add(doc.get("image"));
      print(image);
      nameproduct.add(doc.get("productname"));
      print(nameproduct);
      description.add(doc.get("description"));
      price.add(doc.get("price"));
      productId.add(doc.get("productId"));
    });
    if (nameproduct.isEmpty) {
      print("55");
      return "0";
    } else {
      print("11");
      return "1";
    }
    return "0";
  }




  List<Widget> putProduct(int j) {
    List<Widget> lines = [];
    lines.add(
      _buildImageSlider(),
    );

    if (nameproduct.isNotEmpty) {
      int i = j;
      for (int i = j; i < nameproduct.length; i = i + 1) {
        print("AaAAAA" + productId[i]);
        if ((i + 2) == 2) {
          lines.add(
            featuresAndViewMore(),
          );
        }
        if ((nameproduct.length) % 1 == 0) {
          lines.add(SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                product(
                  name: nameproduct[i],
                  price: price[i],
                  image: image[i],
                  description: description[i],
                  id: productId[i],
                  Producing_Comapny: producing_Company[i],
                  Category: category[i],
                ),
              ],
            ),
          ));
        } else {
          lines.add(
              SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                product(
                  name: nameproduct[i],
                  price: price[i],
                  image: image[i],
                  description: description[i],
                  id: productId[i],
                  Category: category[i],
                  Producing_Comapny: producing_Company[i],
                ),
              ],
            ),
          ));
        }
      }
      return lines;
    } else {
      lines.add(Row(
        children: [
          Text("Ok"),
        ],
      ));
      return lines;
    }
  }

  List<Widget> setProduct() {
    List<Widget> x = [];
    productRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        x.add(Card(
          child: Container(
            height: 250,
            width: 180,
            child: Column(
              children: <Widget>[
                Container(
                  height: 170,
                  width: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(doc["image"]),
                    ),
                  ),
                ),
                Text(
                  "\$" + doc["price"].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xff9b96d6)),
                ),
                Text(
                  doc["productname"],
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        ));
      });
    });
    return x;
  }



//=============================================================================
  // image slider //
  Widget _buildImageSlider() {
    return Container(
      height: height * 0.3,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Carousel(
          borderRadius: true,
          boxFit: BoxFit.cover,
          autoplay: true,
          showIndicator: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          images: [
            AssetImage("assets/images/headphone.png"),
            AssetImage("assets/images/computer3.png"),
            AssetImage("assets/images/mobile.png"),
          ],
        ),
      ),
    );
  }

  Widget featuresAndViewMore() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomText(
            text: "Best Selling",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => About(UserName: UserName, title: title,),
              ));
            },
            child: CustomText(
              text: "View More",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget newAchivesAndViewMore() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomText(
            text: "New Achives",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ListProduct(
                        name: 'New Achives',
                        snapShot: [],
                      )
              ));
            },
            child: CustomText(
              text: "View More",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget product(
      {required String name,
      required int price,
      required String image,
      required String description,
      required String Category,
      required String Producing_Comapny,
      required String id}) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 60,
                  shadowColor: Colors.teal,
                  child: Container(
                    height: 250,
                    width: 350,
                    child: Column(
                      children: <Widget>[
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
                          },
                          child: Container(
                            height: 170,
                            width: 200,
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



  bool homeColor = true;
  bool profileColor = false;
  bool cartColor = false;
  bool connectUsColor = false;
  bool aboutColor = false;
  bool logoutColor = false;


  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              UserName,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
            decoration: BoxDecoration(
              color: Color(0xfff2f2f2),
            ),
            accountEmail: Text(
              title,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                homeColor = true;
                profileColor = false;
                cartColor = false;
                connectUsColor = false;
                aboutColor = false;
                logoutColor = false;
              });
            },
            leading: Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: Text("Home"),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                homeColor = false;
                profileColor = true;
                cartColor = false;
                connectUsColor = false;
                aboutColor = false;
                logoutColor = false;
              });
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => ProfileView(
                        title: title,
                        UserName: UserName,
                        //PhoneNumber: PhoneNumber,
                        UserImage: '',
                      )
                  ));
            },
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.green,
            ),
            title: Text("Profile"),
          ),
          ListTile(
            selected: cartColor,
            onTap: () {
              setState(() {
                homeColor = false;
                profileColor = false;
                cartColor = true;
                connectUsColor = false;
                aboutColor = false;
                logoutColor = false;
              });
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => cart(
                        image: image.toString(),
                        price: "0.0",
                        name: "You are not get Product",
                       UserImage: UserImage, UserName: UserName, PhoneNumber: '', title: title,
                      )));
            },
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.green,
            ),
            title: Text("Cart"),
          ),
          ListTile(
            selected: connectUsColor,
            onTap: () {
              setState(() {
                homeColor = false;
                profileColor = false;
                cartColor = false;
                connectUsColor = true;
                aboutColor = false;
                logoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => ContactUs(UserName: UserName, PhoneNumber: '', title: title, UserImage: UserImage,)));
            },
            leading: Icon(
              Icons.phone,
              color: Colors.green,
            ),
            title: Text("Connect us"),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(() {
                homeColor = false;
                profileColor = false;
                cartColor = false;
                connectUsColor = false;
                aboutColor = true;
                logoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => About(UserName: UserName, title: title,)));
            },
            leading: Icon(
              Icons.info,
              color: Colors.green,
            ),
            title: Text("About"),
          ),
          ListTile(
            selected: logoutColor,
            onTap: () {
              setState(() {
                homeColor = false;
                profileColor = false;
                cartColor = false;
                connectUsColor = false;
                aboutColor = false;
                logoutColor = true;
              });
              Logout();
              /* Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => LoginScreen())); */
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.green,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }



/* List<Widget> SetProduct(){
    List<Widget> productsCards;
    productRef.get().then((QuerySnapshot snapshot)
    {
      snapshot.docs.forEach((DocumentSnapshot doc)
      {
       productsCards.add(
           product(
            name: doc["productname"],
            price: doc["price"],
            image: doc["image"],
            description: doc["description"],
            Category: doc["category"],
            Producing_Comapny: doc["producing_Company"],
            ProductId: doc["productId"],
        ));
      });
    });
    return productsCards;
  } */


  Future<dynamic> Logout() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really to exit the app"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      //showToast(msg: "Cancel");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Home(
                                title: title,
                                UserName: UserName,
                                UserImage: UserImage, /*PhoneNumber: PhoneNumber,*/
                              )));
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text("Logout")),
              ],
            ));
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Scaffold(
        key: _key,
        drawer: _buildDrawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.sort),
            color: primaryColor,
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
          backgroundColor: Colors.grey[100],
          elevation: 0.0,
          title: Text(
            "E-Store app",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => Home(title: title, UserName: UserName, UserImage: UserImage, /*PhoneNumber: PhoneNumber,*/)));
              },
              icon: Icon(Icons.search),
              color: primaryColor,
            ),
            SizedBox(
              width: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: CircleAvatar(
                backgroundColor: primaryColor,
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
            ),
          ],
        ),
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: productRef.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {

                image = [];
                nameproduct = [];
                description = [];
                price = [];
                productId = [];
                category = [];
                producing_Company = [];


                snapshot.data!.docs.forEach((DocumentSnapshot doc) {
                  image.add(doc.get("image"));
                  print(image);
                  nameproduct.add(doc.get("productname"));
                  print(nameproduct);
                  description.add(doc.get("description"));
                  price.add(doc.get("price"));
                  productId.add(doc.get("productId"));
                  print(productId);
                  category.add(doc.get("category"));
                  producing_Company.add(doc.get("producing_Company"));
                });
              }
                return Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    /*child:ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                             //categoriesAndViewMore(),
                            // categoryTypes(),
                            setProduct(),
                            //putProduct(0),
                            /* product(name: "Headphone", price: 20, image: "headphone.png"),
                             showProduct("headphone.png","HeadPhone", 30.0),
                            // newProduct("headphone.png", 30.0, "headphone"),
                            // SingleProduct(image: "headphone.png", name: "HeadPhone", price: 200),
                             newAchivesAndViewMore(),
                            // SingleProduct(image: "phone.png", name: "Samsung A7", price: 200),
                             showProduct("phone.png","Samsung A7", 180),
                             showProduct("mobile.png", "Iphone", 90),
                            //  BottomTabs(),
                          ],
                        ),
                      ),
                     /* SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: //getProduct(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[0]["productname"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[0]["price"],
                              image: snapshot.requireData.docs[0]["image"],
                              description: snapshot.requireData
                                  .docs[0]["description"],
                              ProductId: snapshot.requireData
                                  .docs[0]["productId"],
                              //"headphone0.png"
                            ),
                            product(
                                name: snapshot.requireData
                                    .docs[1]["productname"],
                                /*"Hp Envy x360" */
                                price: snapshot.requireData.docs[1]["price"],
                                image: snapshot.requireData.docs[1]["image"],
                                description: snapshot.requireData
                                    .docs[1]["description"],
                                ProductId: snapshot.requireData
                                    .docs[1]["productId"]),
                            product(
                                name: snapshot.requireData.docs[2]["name"],
                                /*"Hp Envy x360" */
                                price: snapshot.requireData.docs[2]["price"],
                                image: snapshot.requireData.docs[2]["image"],
                                description: snapshot.requireData
                                    .docs[2]["description"],
                                ProductId: ''),
                            product(
                                name: snapshot.requireData.docs[3]["name"],
                                price: snapshot.requireData.docs[3]["price"],
                                image: snapshot.requireData.docs[3]["image"],
                                description: snapshot.requireData
                                    .docs[3]["description"],
                                ProductId: ''),
                            product(
                                name: snapshot.requireData.docs[4]["name"],
                                price: snapshot.requireData.docs[4]["price"],
                                image: snapshot.requireData.docs[4]["image"],
                                description: snapshot.requireData
                                    .docs[4]["description"],
                                ProductId: ''),
                            product(
                                name: snapshot.requireData.docs[5]["name"],
                                price: snapshot.requireData.docs[5]["price"],
                                image: snapshot.requireData.docs[5]["image"],
                                description: snapshot.requireData
                                    .docs[5]["description"],
                                ProductId: ''),
                            product(
                                name: snapshot.requireData.docs[6]["name"],
                                price: snapshot.requireData.docs[6]["price"],
                                image: snapshot.requireData.docs[6]["image"],
                                description: snapshot.requireData
                                    .docs[6]["description"],
                                ProductId: ''),
                            product(
                                name: snapshot.requireData.docs[7]["name"],
                                price: snapshot.requireData.docs[7]["price"],
                                image: snapshot.requireData.docs[7]["image"],
                                description: snapshot.requireData
                                    .docs[7]["description"],
                                ProductId: ''),
                          ],
                        ),
                      ),
                      categories(),
                       Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // product(name: "Headphone", price: 20, image: "headphone.png"),
                      children: <Widget>[
                        product(
                            name: snapshot.requireData.docs[8]["name"],
                            price: snapshot.requireData.docs[8]["price"],
                            image: snapshot.requireData.docs[8]["image"],
                            description: snapshot.requireData.docs[8]["description"], ProductId: ''),
                        product(
                          name: snapshot.requireData.docs[10]["name"],
                          /*"HeadphoneA"*/
                          price: snapshot.requireData.docs[10]["price"],
                          image: snapshot.requireData.docs[10]["image"],
                          description: snapshot.requireData.docs[10]["description"], ProductId: '',
                          //"headphone0.png"
                        ),
                        // product(name: "Hp Envy x360", price: 1200, image: "computer.png"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // product(name: "Headphone", price: 20, image: "headphone.png"),
                      children: <Widget>[
                        product(
                          name: snapshot.requireData.docs[11]["name"],
                          /*"HeadphoneA"*/
                          price: snapshot.requireData.docs[11]["price"],
                          image: snapshot.requireData.docs[11]["image"],
                          description: snapshot.requireData.docs[11]["description"], ProductId: '',
                          //"headphone0.png"
                        ),
                        product(
                          name: snapshot.requireData.docs[12]["name"],
                          /*"HeadphoneA"*/
                          price: snapshot.requireData.docs[12]["price"],
                          image: snapshot.requireData.docs[12]["image"],
                          description: snapshot.requireData.docs[12]["description"], ProductId: '',
                          //"headphone0.png"
                        ),
                        // product(name: "Hp Envy x360", price: 1200, image: "computer.png"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // product(name: "Headphone", price: 20, image: "headphone.png"),
                      children: <Widget>[
                        product(
                          name: snapshot.requireData.docs[13]["name"],
                          /*"HeadphoneA"*/
                          price: snapshot.requireData.docs[13]["price"],
                          image: snapshot.requireData.docs[13]["image"],
                          description: snapshot.requireData.docs[13]["description"], ProductId: '',
                          //"headphone0.png"
                        ),
                        product(
                          name: snapshot.requireData.docs[14]["name"],
                          /*"HeadphoneA"*/
                          price: snapshot.requireData.docs[14]["price"],
                          image: snapshot.requireData.docs[14]["image"],
                          description: snapshot.requireData.docs[14]["description"], ProductId: '',
                          //"headphone0.png"
                        ),
                        // product(name: "Hp Envy x360", price: 1200, image: "computer.png"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // product(name: "Headphone", price: 20, image: "headphone.png"),
                      children: <Widget>[
                       /* product(
                          name: snapshot.requireData.docs[12]["name"],
                          /*"HeadphoneA"*/
                          price: snapshot.requireData.docs[12]["price"],
                          image: snapshot.requireData.docs[12]["image"],
                          //"headphone0.png"
                        ),
                        product(
                          name: snapshot.requireData.docs[12]["name"],
                          /*"HeadphoneA"*/
                          price: snapshot.requireData.docs[12]["price"],
                          image: snapshot.requireData.docs[12]["image"],
                          //"headphone0.png"
                        ), */
                        // product(name: "Hp Envy x360", price: 1200, image: "computer.png"),
                      ],
                    ), */
                  ],
                ), */
                        ),

              ),
              ],
                ) */
                    child: ListView(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                            putProduct(0),
                          ),
                        ),
                      ],
                    )
                );
              }
            ),
      ),
    ]);
  }
}
