import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/cartPage/CheckOutScreen.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/widgets/NotificationButton.dart';

class cart extends StatefulWidget {
 // const cart({Key? key}) : super(key: key);
  final String price;
  final String name;
  final String image;

  final String title;
  final String UserName;
  final String PhoneNumber;
  final String UserImage;
  cart({required this.image,required this.name,required this.price,required this.UserName,required this.title,required this.UserImage,required this.PhoneNumber});
  @override
  State<cart> createState() => _cartState(title: title, UserName: UserName, PhoneNumber: PhoneNumber, UserImage: UserImage);
}

class _cartState extends State<cart> {
  int count = 1;

  final String title;
  final String UserName;
  final String PhoneNumber;
  final String UserImage;

  _cartState({required this.UserImage,required this.title,required this.UserName, required this.PhoneNumber,});


  Widget _buildSingleCartProduct(){
    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 130,
                  width: 150,
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
                Container(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.name),
                        Text(
                          "\$${widget.price.toString()}",
                          style: TextStyle(
                              color: Color(0xff9b96d6),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 35,
                          width: 120,
                          color: Color(0xfff2f2f2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                child: Icon(Icons.remove),
                                onTap: (){
                                  setState(() {
                                    if(count > 1){
                                      count--;
                                    }
                                  });
                                },
                              ),
                              Text(
                                count.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                child: Icon(Icons.add),
                                onTap: (){
                                  setState(() {
                                    count++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        /*Container(
                                height: 60,
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)
                                  ),
                                  color: Colors.pink,
                                  child: Text(
                                    "Check Out",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () {

                                  },
                                ),
                              ) */
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        padding: EdgeInsets.all(10),
        child: RaisedButton(
          color: Colors.teal,
          child: Text("Continuos",style: TextStyle(color: Colors.black),),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => CheckOut(price: widget.price, image: widget.image, name: widget.name, counter: count.toString(),),
            ));
          },
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cart Page", style: TextStyle(color: Colors.black)),
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
                builder: (ctx) => Home(title: title, UserName: UserName, UserImage: UserImage, /*PhoneNumber: PhoneNumber,*/),
              ),
            );
          },
        ),
        actions: <Widget>[
          NotificationButton(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildSingleCartProduct(),
        ],
      ),
    );
  }
}
