import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/cartPage/cart.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/widgets/NotificationButton.dart';

class CheckOut extends StatefulWidget {
  //const CheckOut({Key? key}) : super(key: key);

  final String price;
  final String name;
  final String image;
  final String counter;
  CheckOut({required this.image, required this.name, required this.price, required this.counter});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Widget _buildSingleCartProduct() {
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
                      placeholder: (context, url) =>
                        new CircularProgressIndicator(),
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
                              Text("Quantity"),
                              Text(widget.counter),
                            ],
                          ),
                        ),
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

  Widget _buildBottomDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          endName,
          style:
              TextStyle(color: Color(0xff9b96d6), fontWeight: FontWeight.bold,fontSize: 15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("CheckOut", style: TextStyle(color: Colors.black)),
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
                builder: (ctx) => Home(title: '', UserName: '', UserImage: '',/* PhoneNumber: '', */),
              ),
            );
          },
        ),
        actions: <Widget>[
          NotificationButton(),
        ],
      ),

      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        padding: EdgeInsets.all(10),
        child: RaisedButton(
          color: Colors.teal,
          child: Text("Buy",style: TextStyle(color: Colors.black),),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => CheckOut(price: widget.price, image: widget.image,name: widget.name, counter: widget.counter,),
            ));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "CheckOut",
                    style: TextStyle(fontSize: 28),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildSingleCartProduct(),
           // _buildSingleCartProduct(),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildBottomDetail(
                    startName: "Your Price",
                    endName: "\$" + widget.price,
                  ),
                  _buildBottomDetail(
                    startName: "Discount",
                    endName: "3%",
                  ),
                  _buildBottomDetail(
                    startName: "Shipping",
                    endName: "\$ 60.00",
                  ),
                  _buildBottomDetail(
                    startName: "Total",
                    endName: "\$" + widget.price + widget.counter,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
