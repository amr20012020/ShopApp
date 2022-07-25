import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/shared/components/components.dart';

class ContactUs extends StatefulWidget {

  final String title;
  final String UserName;
  final String PhoneNumber;
  final String UserImage;

  ContactUs({required this.UserName,required this.title,required this.UserImage,required this.PhoneNumber});

  @override
  _ContactUsState createState() => _ContactUsState(title: title, UserName: UserName, PhoneNumber: PhoneNumber, UserImage: UserImage);
}

class _ContactUsState extends State<ContactUs> {
  final String title;
  final String UserName;
  final String PhoneNumber;
  final String UserImage;

  _ContactUsState({required this.UserImage,required this.title,required this.UserName, required this.PhoneNumber,});

  final TextEditingController message = TextEditingController();

  String? name, email;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void vaildation() async {
    if (message.text.isEmpty) {
      showToast(msg: "Please Fill the Message");
    } else {
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("Message").doc(user?.uid).set({
        "Name": name,
        "Email": email,
        "Message": message.text,
      });

    }
  }

  Widget _buildSingleFiled(String name) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
   /* ProductProvider provider;
    provider = Provider.of<ProductProvider>(context, listen: false);
    List<UserModel> user = provider.userModelList;
    user.map((e) {
      name = e.userName;
      email = e.userEmail;

      return Container();
    }).toList(); */

    super.initState();
  }

  connect(){
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => Home(title: '', UserName: '', UserImage: '', /*PhoneNumber: '',*/)));
  }

  @override
  Widget build(BuildContext context) {
    print(name);
    return WillPopScope(
      onWillPop: () {
        return  connect();
          Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => Home(title: '', UserName: '', UserImage: '', /*PhoneNumber: '',*/)));
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Connect us", style: TextStyle(color: Colors.black)),
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
                  builder: (ctx) => Home(title: title, UserName: UserName, UserImage: UserImage, /*PhoneNumber: '',*/),
                ),
              );
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 27),
          height: 600,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sent Us Your Message",
                style: TextStyle(
                  color: Color(0xff746bc9),
                  fontSize: 28,
                ),
              ),
            //  _buildSingleFiled(name: name),
             // _buildSingleFiled(name: email),
              Container(
                height: 200,
                child: TextFormField(
                  controller: message,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: " Message",
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigateAndFinish(context, Home(title: '', UserName: '', UserImage: '', /*PhoneNumber: '',*/));
                  //   Navigator.of(context).pushNamed('/signup');
                },
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: Colors.teal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Home(title: '', UserName: '', UserImage: '', /*PhoneNumber: '',*/)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}