import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/modules/product_detail/Productdetail.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/NotificationButton.dart';
import 'package:shop_app/widgets/custom_text.dart';

class ListProduct extends StatelessWidget {
  final String name;
  final List<Product> snapShot;

  ListProduct({required this.name, required this.snapShot});



  final productRef = FirebaseFirestore.instance
      .collection("products")
      .doc("3Mlk4LvGtj13wImlWXoK")
      .collection('ListProduct');



  var image = [];
  var nameproduct = [];
  var description = [];
  var price = [];
  var productId = [];



  getProduct()async{
    final QuerySnapshot snapshot = await productRef.get();
    snapshot.docs.forEach((DocumentSnapshot doc) {
      image.add(doc.get("image"));
      nameproduct.add(doc.get("name"));
      description.add(doc.get("description"));
      price.add(doc.get("price"));
      productId.add(doc.get("productId"));
    });
  }


  Future<dynamic> loadProducts()async{
    var snapshot = await FirebaseFirestore.instance
        .collection("products")
        .doc("3Mlk4LvGtj13wImlWXoK")
        .collection('featureProduct')
        .get();
    List<Product> products = [];
    for(var doc in snapshot.docs)
    {
      var data = doc.data();
      products.add(
          Product(
              data['image'],
              data['price'],
              data['name'],
              data['description'],
              //data['product_Id'],
              data['category'],
              data['producing_Company']));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildSearchBar(context) {
      return Container();
    }

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

    /*Widget product(
        {required String name, required int price, required String image, required String description,
          required String Category,
          required String Producing_Comapny,}) {
      /* return Card(
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
                      width: 180,
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
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          ProductDetail(image, name, price.toString(), description, title: '', UserName: '', ProductId: '', userId: '',
                                            Category,
                                            Producing_Comapny,)));
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
    } */

   /* Widget showProduct() {
      final Orientation orientation = MediaQuery.of(context).orientation;
      return Container(
        height: 700,
        child: GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          childAspectRatio: orientation == Orientation.portrait ? 0.8 : 0.9,
          scrollDirection: Axis.vertical,
          children: snapShot
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    /*  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => ProductDetail())); */
                  },
                  child: SingleProduct(
                    price: e.price,
                    image: e.image,
                    name: e.name,
                  ),
                ),
              )
              .toList(),
        ),
      );
    } */

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: primaryColor,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home(title: '', UserName: '', UserImage: '', /*PhoneNumber: '',*/ )));
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
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection("products")
            .doc("3Mlk4LvGtj13wImlWXoK")
            .collection('ListProduct')
            .get(),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
            print(snapshot.data.toString());
          }

          if (snapshot.hasData){
            // DocumentSnapshot<Map<String, dynamic>>
            /* Future<void> variable = FirebaseFirestore
                    .instance.collection('products')
                    .doc('3Mlk4LvGtj13wImlWXoK')
                    .collection('featureProduct')
                     .doc('0r611D6x7EI2mhDLOr6r')
                    .get (); */
            // print(variable.toString());
            var collection =  FirebaseFirestore.instance.collection('products')
                .doc("3Mlk4LvGtj13wImlWXoK")
                .collection('featureProduct')
                .doc("0r611D6x7EI2mhDLOr6r")
                .get().then((value) => print(value)).catchError((error) =>
                print("Failed to add user: $error"));
            //  final Map<String, dynamic> doc = snapshot.data;
            // print(snapshot.data["price"]);
            print("Amroooo");
            // print(snapshot.data.toString()["productname".toString().length]);
            //  print(snapshot.data.toString()["price".toString()]);
            print(snapshot.requireData.docs[2]["image".toString()]);
            /* mobiledata = Product(
                 image: snapshot.requireData.docs[0]["image"],//.toString().length],
                 price: snapshot.requireData.docs[0]["price"],
                 name: snapshot.requireData.docs[0]["productname"],
               ); */
            /* headPhonedata = Product(
                 image: snapshot.requireData.docs[1]["image".toString()],//.toString().length],
                 price: snapshot.requireData.docs[1]["price".toString()],
                 name: snapshot.requireData.docs[1]["productname".toString()],
               ); */
            print("mmmmmm");
            // print(mobiledata.price.toString());
            print("wwwwwww");
            //  snapshot.data.toString()[2]["productname".length]

            // print(price.toString());
            showToast(msg: "Hello");
          }
         return Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    featuresAndViewMore(),
                    getProduct(),
                    /*SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // product(name: "Headphone", price: 20, image: "headphone.png"),
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[0]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[0]["price"],
                              image: snapshot.requireData.docs[0]["image"],
                              description: snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[1]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[1]["price"],
                              image: snapshot.requireData.docs[1]["image"],
                              description: snapshot.requireData.docs[1]["description"],
                              //"headphone0.png"
                            ),
                           // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                           // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[2]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[2]["price"],
                              image: snapshot.requireData.docs[2]["image"],
                              description: snapshot.requireData.docs[2]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[3]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[3]["price"],
                              image: snapshot.requireData.docs[3]["image"],
                              description: snapshot.requireData.docs[3]["description"],
                              //"headphone0.png"
                            ),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ),
                       /* Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[4]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[4]["price"],
                              image: snapshot.requireData.docs[4]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[5]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[5]["price"],
                              image: snapshot.requireData.docs[5]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[6]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[6]["price"],
                              image: snapshot.requireData.docs[6]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[7]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[7]["price"],
                              image: snapshot.requireData.docs[7]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ),
                     /*  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[8]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[8]["price"],
                              image: snapshot.requireData.docs[8]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[9]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[9]["price"],
                              image: snapshot.requireData.docs[9]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[10]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[10]["price"],
                              image: snapshot.requireData.docs[10]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[11]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[11]["price"],
                              image: snapshot.requireData.docs[11]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ), */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[12]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[12]["price"],
                              image: snapshot.requireData.docs[12]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[13]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[13]["price"],
                              image: snapshot.requireData.docs[13]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[14]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[14]["price"],
                              image: snapshot.requireData.docs[14]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[15]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[15]["price"],
                              image: snapshot.requireData.docs[15]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[16]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[16]["price"],
                              image: snapshot.requireData.docs[16]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[17]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[17]["price"],
                              image: snapshot.requireData.docs[17]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(
                              name: snapshot.requireData.docs[18]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[18]["price"],
                              image: snapshot.requireData.docs[18]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            product(
                              name: snapshot.requireData.docs[19]["name"],
                              /*"HeadphoneA"*/
                              price: snapshot.requireData.docs[19]["price"],
                              image: snapshot.requireData.docs[19]["image"],
                              description: "25",//snapshot.requireData.docs[0]["description"],
                              //"headphone0.png"
                            ),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                          ],
                        ),
                       /* Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(name: "HeadphoneA", price: "32", image: "mobile.png"),
                            // product(name: "Hp Envy x360", price: 43, image: "mobile2.png"),
                            product(name: "Hp Envy x360", price: "1200", image: "mobile1.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(name: "HeadphoneA", price: "11", image: "mobile2.png"),
                            // product(name: "Hp Envy x360", price: 6464, image: "mobile2.png"),
                            product(name: "Hp Envy x360", price: "8676", image: "MX412.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(name: "HeadphoneA", price: "23", image: "pc.png"),
                            // product(name: "Hp Envy x360", price: 767, image: "mobile2.png"),
                            product(name: "Hp Envy x360", price: "555", image: "pc1.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(name: "HeadphoneA", price: "87", image: "speaker.png"),
                            // product(name: "Hp Envy x360", price: 243, image: "mobile2.png"),
                            product(name: "Hp Envy x360", price: "444", image: "speaker2.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(name: "HeadphoneA", price: "87", image: "speaker3.png"),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            product(name: "Hp Envy x360", price: "333", image: "MX412.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(name: "HeadphoneA", price: "16", image: "laptop2.png"),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            product(name: "Hp Envy x360", price: "222", image: "laptop3.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(name: "HeadphoneA", price: "16", image: "laptop.png"),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            product(name: "Hp Envy x360", price: "111", image: "laptop2.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(name: "HeadphoneA", price: "16", image: "headphone.png"),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            product(name: "Hp Envy x360", price: "777", image: "laptop3.png"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // product(name: "Headphone", price: 20, image: "headphone.png"),
                          children: <Widget>[
                            product(name: "HeadphoneA", price: "16", image: "speaker2.png"),
                            // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                            product(name: "Hp Envy x360", price: "888", image: "speaker3.png"),*/
                          ],
                        ), */
                      ],
                    ), */
                    /* showProduct(),
                    showProduct(),
                    showProduct(),
                    showProduct(),
                    showProduct(),
                    showProduct(),
                    showProduct(),
                    showProduct(),
                    showProduct(),
                    showProduct(),
                    showProduct(), */
                  ],
                ),
              ),
            ],
          ),
         );
        },
      ),
    );
  }
}




/* Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  featuresAndViewMore(),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // product(name: "Headphone", price: 20, image: "headphone.png"),
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "16", image: "headphone.png"),
                          //product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "4225", image: "headphone2.png"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "32", image: "mobile.png"),
                         // product(name: "Hp Envy x360", price: 43, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "1200", image: "mobile1.png"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "11", image: "mobile2.png"),
                         // product(name: "Hp Envy x360", price: 6464, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "8676", image: "MX412.png"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "23", image: "pc.png"),
                         // product(name: "Hp Envy x360", price: 767, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "555", image: "pc1.png"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "87", image: "speaker.png"),
                         // product(name: "Hp Envy x360", price: 243, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "444", image: "speaker2.png"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "87", image: "speaker3.png"),
                         // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "333", image: "MX412.png"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "16", image: "laptop2.png"),
                         // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "222", image: "laptop3.png"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "16", image: "laptop.png"),
                         // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "111", image: "laptop2.png"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "16", image: "headphone.png"),
                         // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "777", image: "laptop3.png"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // product(name: "Headphone", price: 20, image: "headphone.png"),
                        children: <Widget>[
                          product(name: "HeadphoneA", price: "16", image: "speaker2.png"),
                         // product(name: "Hp Envy x360", price: 1200, image: "mobile2.png"),
                           product(name: "Hp Envy x360", price: "888", image: "speaker3.png"),
                        ],
                      ),
                    ],
                  ),
                 /* showProduct(),
                  showProduct(),
                  showProduct(),
                  showProduct(),
                  showProduct(),
                  showProduct(),
                  showProduct(),
                  showProduct(),
                  showProduct(),
                  showProduct(),
                  showProduct(), */
                ],
              ),
            ),
          ],
        ),
      ),
     */


















/* @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        SizedBox(
          height: 10,
        ),
        Category(),
        Center(
            child: Text(
              'Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        AllProducts()
      ],
    );
  }
}
 */
