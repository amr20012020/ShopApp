import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/modules/admin/AddProduct.dart';
import 'package:shop_app/modules/admin/EditProduct.dart';
import 'package:shop_app/modules/admin/ProductdetailAdmin.dart';
import 'package:shop_app/modules/admin/edit.dart';
import 'package:shop_app/modules/login/Login_Screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constance.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../core/service/store.dart';
import '../../models/user_model.dart';
import '../../provider/product_provider.dart';
import '../../widgets/custom_text.dart';
import '../pie_chart/pie_chart_page.dart';
import '../product_detail/Productdetail.dart';

class AdminHome extends StatefulWidget {
  static String id = 'AdminHome';
  final String ProductId;
  final String EmailAdmin;
  //final String NameAdmin;
  const AdminHome({
    Key? key,
    required this.ProductId,
    required this.EmailAdmin,
    //required this.NameAdmin,
  }) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState(
        ProductId: ProductId,
        Email: EmailAdmin,
        //Name: NameAdmin,
      );
}

class _AdminHomeState extends State<AdminHome> {
  final String ProductId;
  final String Email;
  //final String Name;

  _AdminHomeState({
    required this.ProductId,
    required this.Email,
    //required this.Name,
  });
  static const String id = 'adminScreen';

  final _store = Store();

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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

  bool homeColor = true;
  bool profileColor = false;
  bool cartColor = false;
  bool connectUsColor = false;
  bool aboutColor = false;
  bool AddColor = false;
  bool EditColor = false;
  bool logoutColor = false;

  Future<dynamic> Logout() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really to exit the app"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AdminHome(
                                ProductId: '', EmailAdmin: Email, /*NameAdmin: Name,*/
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

  int positiveCount = 0;
  int negativeCount = 0;
  int mixedCount = 0;
  double counter = 0;

  final counterRef = FirebaseFirestore.instance.collection('counters');

  getCount() async {
    final DocumentSnapshot doc = await counterRef.doc(ProductId).get();
    if (doc.exists) {
      print(doc.get("positiveCount"));
      positiveCount = doc.get("positiveCount");
      negativeCount = doc.get("negativeCount");
      mixedCount = doc.get("mixedCount");
      counter = doc.get("positiveCount").toDouble() +
          doc.get("negativeCount").toDouble() +
          doc.get("mixedCount").toDouble();
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => Pie_chart_Page(
          ProductId: ProductId,
          //mixedCount: mixedCount,
          negativeCount: negativeCount,
          positiveCount: positiveCount,
          counter: counter, Email: Email, Name: 'Name',
        ),
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
                    height: 300,
                    width: 350,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => ProductDetailAdmin(
                                        image,
                                        name,
                                        price.toString(),
                                        Category,
                                        Producing_Comapny,
                                        description,
                                        Email: Email,
                                        UserName: 'UserName',
                                        ProductId: id.toString(),
                                        userId: '')));
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
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\$ $price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xff9b96d6)),
                        ),
                        SizedBox(
                          height: 10,
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

  List<Widget> putProduct(int j) {
    List<Widget> lines = [];
    if (nameproduct.isNotEmpty) {
      int i = j;
      for (int i = j; i < nameproduct.length; i = i + 1) {
        print("AaAAAA" + productId[i]);
        if ((i + 2) == 2) {
          lines.add(
            Container(
              alignment: Alignment.center,
              child: Text(
                "Products",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            ),
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
          Text("Error"),
        ],
      ));
      return lines;
    }
  }

  Widget _buildDrawer1() {
    List<UserDataModel> userModel = ProductProvider().userModelList;
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "AdminName",
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
              Email,
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
                EditColor = false;
                AddColor = false;
                aboutColor = false;
                logoutColor = false;
              });
            },
            leading: Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: Text("AdminHome"),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                homeColor = false;
                profileColor = true;
                cartColor = false;
                AddColor = false;
                EditColor = false;
                connectUsColor = false;
                aboutColor = false;
                logoutColor = false;
              });
              /* Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) =>
                      ProfileView(
                        title: title, UserName: UserName,
                      )
                /* profile(),*/
              ));*/
            },
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.green,
            ),
            title: Text("Profile"),
          ),
          ListTile(
            selected: AddColor,
            onTap: () {
              setState(() {
                homeColor = false;
                profileColor = false;
                AddColor = true;
                cartColor = false;
                connectUsColor = false;
                aboutColor = false;
                logoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AddProduct(EmailAdmin: Email, NameAdmin: 'Name',)));
            },
            leading: Icon(
              CupertinoIcons.add_circled_solid,
              color: Colors.green,
            ),
            title: Text("Add Product"),
          ),
          ListTile(
            selected: EditColor,
            onTap: () {
              setState(() {
                homeColor = false;
                profileColor = false;
                AddColor = true;
                cartColor = false;
                EditColor = false;
                connectUsColor = false;
                aboutColor = false;
                logoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => EditScreen( ProductId: ProductId, EmailAdmin: Email,)));
            },
            leading: Icon(Icons.edit, color: Colors.green,),
            title: Text("Edit Product"),
          ),
          ListTile(
            selected: logoutColor,
            onTap: () {
              setState(() {
                homeColor = false;
                profileColor = false;
                cartColor = false;
                AddColor = false;
                connectUsColor = false;
                aboutColor = false;
                logoutColor = true;
              });
              Logout();
            },
            leading: Icon(
              Icons.logout,
              color: Colors.green,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      drawer: _buildDrawer1(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.sort, color: Colors.teal,),
          color: primaryColor,
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "E-Store app",
          style: TextStyle(color: Colors.teal),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.teal,
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
                child: ListView(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: putProduct(0),
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
