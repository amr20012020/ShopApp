import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/shared/components/components.dart';

class NotificationButton extends StatefulWidget {

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
           return AlertDialog(
             title: Text("Alert"),
             actions: [
               FlatButton(
                   onPressed: (){
                     showToast(msg: "Clear Notification");
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(title: '', UserName: '', UserImage: '', /*PhoneNumber: '',*/)));
                   },
                   child: Text("Clear Notification")),
               FlatButton(
                   onPressed: (){
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(title: '', UserName: '', UserImage: '', /*PhoneNumber: '',*/)));
                   },
                   child: Text("Ok")),
             ],
           );
         });
  }
  @override
  Widget build(BuildContext context) {
   // productProvider = Provider.of<ProductProvider>(context);
    return Badge(
      position: BadgePosition(top: 8),
      badgeContent: Text(
        "0",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      badgeColor: Colors.teal,
      child: IconButton(
        icon: Icon(
          Icons.notifications_none,
          color: Colors.teal,
        ),
        onPressed: () {
          myDialogBox(context);
        },
      ),

    );
  }
}


