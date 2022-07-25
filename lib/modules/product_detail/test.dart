import 'dart:async';
import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/SignUp/SignUp_Screen.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/network/services/auth.dart';
import 'package:shop_app/provider/modelHud.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:comment_box/comment/comment.dart';

import '../../API.dart';



class CommentScreen1 extends StatefulWidget  {
  const CommentScreen1(
      {Key? key,
        required this.title,
        required this.UserName,
        required this.productID,
        required this.userId})
      : super(key: key);
  final String title;
  final String UserName;
  final String productID;
  final String userId;
  @override
  State<CommentScreen1> createState() => _CommentScreen1State(
    title: title,
    ProductId: productID,
    username: UserName,
    userId: userId,
    comment: '',
    avatarUrl: '',
  );
}

final usersRef = FirebaseFirestore.instance.collection('users');
final commentsRef = FirebaseFirestore.instance.collection('comments');
final countersRef = FirebaseFirestore.instance.collection('counters');
final FirebaseAuth auth = FirebaseAuth.instance;

class _CommentScreen1State extends State<CommentScreen1> {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final String ProductId;
  //final Timestamp timestamp;
  final String title;
  _CommentScreen1State({
    required this.title,
    required this.username,
    required this.userId,
    required this.avatarUrl,
    required this.comment,
    required this.ProductId,
    /* required this.timestamp*/
  });

  TextEditingController commentController = TextEditingController();

  final DateTime timestamp = DateTime.now();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  final _auth = Auth();

  String text = " ";

  String sentimentResult = "";

  String sentimentScore = "";

  int count = 1;

  //String UserName = "";

  var users = [];
  List productComment = [];
  var userComment = [];
  var ids = [];
  var comments = [];

  int commentCount = 0;
  int positiveCount = 0;
  int negativeCount = 0;
  int mixedCount = 0;


  void initState(){
    getUsers();
    //final QuerySnapshot snapshot = await commentsRef.get();
    super.initState();
  }

  getUsers() async {
    /* final QuerySnapshot snapshot =  await usersRef.get();
     setState(() {
       users = snapshot.docs;
     }); */
    // print(getUsers());
    print("amr");
    print(title);
    final QuerySnapshot snapshot = await usersRef.get();
    snapshot.docs.forEach((DocumentSnapshot doc) {
      print("sdsds");
      print(username);
      if (username == doc.get("UserName")) {
        print("aaaaaa");
        users.add(doc.get("UserName"));
        ids.add(doc.id);
      }
      // users.add(doc.get("UserName"));
      //ids.add(doc.id);
      // print(users);
    });
    // print(UserName);
    // print("Aaa");
    // print(users);
    return users.toString();
  }

  Widget Users() {
    print(getUsers());
    print(username);
    for (int i = 0; i < users.length; i++) {
      print(ids[i]);
      return Text(users[i]);
    }
    return Text("aaa");
  }

  user() {
    print(getUsers());
    print(username);
    print(ids);
    for (int i = 0; i < users.length; i++) {
      print(ids[i]);
      return users[i];
    }
    return username;
  }


 /* getComments() async {
    /* final QuerySnapshot snapshot =  await usersRef.get();
     setState(() {
       users = snapshot.docs;
     }); */
    // print(getUsers());
    print("amr");
    print(title);
    print("gdshgds");
    /*snapshot.docs.forEach((DocumentSnapshot doc) {
      print("sdsds");
      print(username);
      print(ProductId);
      print(doc.get("productId"));
      print(doc.id);
      if (ProductId == doc.get("productId")) {
        count++;
        print("aaaaaa");
        productComment.add(doc.get("Comment"));
        userComment.add(doc.get("UserName"));
      }
      print(doc.get("productId"));
      // users.add(doc.get("UserName"));
      //ids.add(doc.id);
      // print(users);
    }); */
    //snapshot.metadata;
    Stream<DocumentSnapshot> snap1 = commentsRef.snapshots() as Stream<DocumentSnapshot<Object?>>;
    /* for(int i = 0; i < snapshot.size; i++){
      var a = snapshot.docs[i];
      if (ProductId == a.get("productId")) {
        count++;
        print("aaaaaa");
        productComment.add(a.get("Comment"));
        userComment.add(a.get("UserName"));
      }
      print(a.data());
    }
    print("yyyy");
    for(int y = 0; y < count - 1; y++){
      print(userComment[y]);
    }
    print(snapshot.size); */
    print(snap1);
    print("hessss");
    print(count);
    count = 1;
    print("hhhhh" + userComment.length.toString());
    // print(UserName);
    // print("Aaa");
    // print(users);
    return productComment.toString();
  } */

 /* Widget textuser() {
    /* Timer(Duration(seconds: 15), () {
      getComments();
      print("afkasfjsssssssssssssssssssssssssssssssssssssssssssssssssssss");
    });
    Timer.run(() {
      print("ssssssssssssssaaaaaaaaaaaa");
    }); */
    for(int i = 0; i < 10000;i++){
      print("sasasasaaa");
    }
    getComments();
    print("ssss" + userComment.length.toString());
    for (int i = 0; i < userComment.length; i++) {
      print(ids[i]);
      return Text(userComment[i]);
    }
    return Text("aaaaaa");

    /*  getComments();
    getComments();
    print(username);
    print("ssss" + userComment.length.toString());
    for (int i = 0; i < userComment.length; i++) {
      print(ids[i]);
      return Text(userComment[i]);
    }
    userComment = [];
    return ListTile(
      title: Text("error 1 "),
     ); */
  } */

  /* comments(){
    print(getComments());
    print(username);
    print(ids);
    for (int i = 0; i < userComment.length; i++) {
      print(ids[i]);
      return Text(userComment[i]);
    }
    return Text(username);
  } */

  /*Widget productsComment() {
    print(getComments());
    print(username);
    print("Hello");
    print(ids);
    for (int i = 0; i < productComment.length; i++) {
      print(ids[i]);
      return Text(productComment[i].toString());
    }
    //commentController.text
    return Text(commentController.text);
  } */

  Widget categoryTypes() {
    return Container(
      height: 72,
      child: Row(
        children: <Widget>[
          Users(),
        ],
      ),
    );
  }


  /* Widget buildComments() {
    return /*ListTile(
      title: Text(comments()),
      leading: CircleAvatar(
        /* avatarUrl*/
        backgroundImage: CachedNetworkImageProvider(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1024px-User_icon_2.svg.png"),
      ),
      // isThreeLine: true,
      /*title*/
      trailing: Text(ProductId),
      subtitle: Text(
          productsComment() + '\n' + timeago.format(fifteenAgo),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      /*Text(comment)*/
    ); */
   /* ListView(
      children: [
        Comments(),
        productsComment(),
         //Comments(),
        //comments(),
       /* Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              comments(),
              // categoriesAndViewMore(),
              // categoryTypes(),

              /* product(name: "Headphone", price: 20, image: "headphone.png"),
                             showProduct("headphone.png","HeadPhone", 30.0),
                            // newProduct("headphone.png", 30.0, "headphone"),
                            // SingleProduct(image: "headphone.png", name: "HeadPhone", price: 200),
                             newAchivesAndViewMore(),
                            // SingleProduct(image: "phone.png", name: "Samsung A7", price: 200),
                             showProduct("phone.png","Samsung A7", 180),
                             showProduct("mobile.png", "Iphone", 90),*/
              //  BottomTabs(),
            ],
          ),
        ), */
      ],
    );*/
    ListView.builder(
        itemCount: productComment.length,
        itemBuilder: (context,index){
          return textuser();
    });

   /* ListView.builder(
        itemBuilder: (context, index){

        }); */
  } */

   _buildComments(){
     return StreamBuilder<QuerySnapshot>(
         stream: commentsRef.snapshots(),
         builder: (context, snapshot){
           if(!snapshot.hasData){
            return CircularProgressIndicator();
           }
           //var x = <comment>[];/*snapshot.requireData.docs.map((doc) => Text(doc["Comment"]),).toList();*/

            final List<ListTile> children = snapshot.requireData.docs.map((doc){
              /*if(doc["productId"] == ProductId){
                return ListTile(
                  title: Text(doc["UserName"]),
                  trailing: Text(doc["Comment"]),
                );
              }*/
              if(doc["productId"] == ProductId){
                print( "mer" + ProductId);
                return ListTile(
                  title: Text(doc["UserName"]),
                  trailing: Text(doc["Comment"]),
                );
              }else{
                return ListTile(
                  title: Text(""),
                  trailing: Text(""),
                );
              }
            }).toList();
           /*children.remove(ListTile(
             title: Text(""),
             trailing: Text(""),
           ));*/
           //List<ListTile> result = children.removeWhere((item)=>item == 20);
           return Container(
             child: ListView(
               children: children,
             ),
           );
         },
     );
   }


  Future<dynamic> sendData(String comment) async{
     var obj = {
       'textanalysis': comment,
     };
     var res = await CallApi().postData(obj);
     return res.body;
   }



  /* addComment() {
    getUsers();
    getComments();
    /*  final modelHud =
    Provider.of<ModelHud>(context, listen: false);
    modelHud.changeisLoading(true);
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      try {
        Provider.of<ModelHud>(context, listen: false);
        FirebaseFirestore.instance.collection('comments').doc().set({
          'IDuser' : ids[0],
          'UserName': users[0],
          'Comment' : commentController.text,
        }).then((value) => print("Comment Added")).catchError((error) => print("Failed to add comment: $error"));

        ModelHud().changeisLoading(false);
        print('success');
        modelHud.changeisLoading(false);
        Fluttertoast.showToast(msg: "Success");
        chooseToastColor(ToastState.SUCCESS);
      } on PlatformException catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        print(e.toString());
      }
    }
    modelHud.changeisLoading(false); */
    print("Ameeeee");
  } */


 updateCount(String counteranalysis) async{
    final DocumentSnapshot doc = await countersRef.doc(ProductId).get();
    print("very");
    if(doc.exists){
      if(counteranalysis == "1"){
        doc.reference.update({
          "commentsCount": doc.get("commentsCount") + 1,
          "positiveCount": doc.get("positiveCount") + 1,
          "negativeCount": doc.get("negativeCount"),
        });
      }else{
          doc.reference.update({
            "commentsCount": doc.get("commentsCount") + 1,
            "positiveCount": doc.get("positiveCount") ,
            "negativeCount": doc.get("negativeCount") + 1,
          });
        }
    }else{
      createCount(counteranalysis);
    }
  }


  createCount(String counteranalysis)async{
    if(counteranalysis == "1"){
      countersRef.doc(ProductId).set({
        "commentsCount": 1,
        "positiveCount": 1,
        "negativeCount": 0,
      });
    }else{
        countersRef.doc(ProductId).set({
          "commentsCount": 1,
          "positiveCount": 0,
          "negativeCount": 1,
        });
      }
    }


  addComment()async {
    String usercomment = commentController.text;
    var useranalysis = await sendData(usercomment);
    var resultanalysis = jsonDecode(useranalysis)["result"];
    print(resultanalysis.toString());
    commentsRef.add(
        {
          "UserName": username,
          "Comment" : commentController.text,
          "productId" : ProductId,
           "analysis" : resultanalysis,
          "timestamp" : timestamp,
           "UserID" : ids[0],
        }
    );
    updateCount(resultanalysis);
    commentController.clear();
  }

  final fifteenAgo = DateTime.now().subtract(Duration(minutes: 15));


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                // showToast(msg: "hhhhhh " + widget.image);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => Home(
                      title: title,
                      UserName: username, UserImage: '', /*PhoneNumber: '',*/
                    ),
                  ),
                );
              },
            ),
          ),
          body: //final List<Text> x =  snapshot.requireData.map((doc) => Text(doc['UserName'])).toList();
         Column(
              children: <Widget> [
                Expanded(child: _buildComments()),
                Divider(),
                ListTile(
                  title: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      labelText: "Write a Comment",
                    ),
                  ),
                  trailing: OutlinedButton(
                  onPressed: () =>
                         addComment(),
                  child: Text("Post"),
                  ),
                ),
              ],
              ),
            );
      },
    );
  }
}


