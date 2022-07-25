import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/NotificationButton.dart';
import 'dart:io';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.title,required this.UserName,/*required this.PhoneNumber, */required this.UserImage}) : super(key: key);
  final String title;
  final String UserName;
 // final String PhoneNumber;
  final String UserImage;
  @override
  _ProfileViewState createState() => _ProfileViewState(title: title, UserName: UserName, /*PhoneNumber: PhoneNumber, */UserImage: UserImage);
}

bool edit = false;

var _PickedImage;
final storage = FirebaseStorage.instance;

Widget UserImage() {
  return Container(
    height: 150,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          maxRadius: 65,
          backgroundImage: AssetImage("assets/images/user.png"),
        ),
      ],
    ),
  );
}

Widget _buildSingleContainer({required String startName, required String endName}){
  return Card(
    child: Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(startName,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
          Text(endName,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}

Widget _buildSingleTextFormField(String name){
  return TextFormField(
    decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        )
    ),
  );
}


Widget _buildProfileDetail(
    {required String startName, required String endName}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        startName,
        style: TextStyle(
            color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 15),
      ),
      Text(
        endName,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15),
      ),
    ],
  );
}

Widget editUser() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(30),
      ),
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "Name",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}




class _ProfileViewState extends State<ProfileView> {
  final String title;
  final String UserName;
 // final String PhoneNumber;
  final String UserImage;

  _ProfileViewState({required this.UserImage,required this.title,required this.UserName, /*required this.PhoneNumber,*/});

  Widget imageUser(){
    return Center(
      child: Stack(
        children: <Widget>[
          ClipOval(
            child: _PickedImage != null
                ? Image.network(
              _PickedImage!,
              width: 170,
              height: 170,
              fit: BoxFit.cover,
            )
                : Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png',
              width: 170,
              height: 170,
              fit: BoxFit.cover,
            ),
          ),
          /*CircleAvatar(
            radius: 80.0,
            backgroundImage: _PickedImage != null ? Image.file(_PickedImage!) :
            AssetImage("assets/images/add-product.png"),
            /*_image == null
                ? AssetImage("assets/images/add-product.png")
                : FileImage(File(_image.path)),*/
          ), */
          /*Center(
            child: _image == null ? AssetImage("assets/images/add-product.png") : Image.file(_image) ,
          ), */
          Positioned(
              bottom: 20.0,
              right: 5.0,
              child: InkWell(
                onTap: (){
                  //getImage();
                  //imageProduct();
                  pickImage(ImageSource.camera);
                },
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.deepOrange,
                  size: 28.0,
                ),
              )
          ),
          /*Positioned(
            top: 120,
            left: 110,
            child: RawMaterialButton(
              elevation: 10,
              fillColor: Colors.deepOrange,
              child: Icon(Icons.add_a_photo),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog();
                    });
              },
            ),
          ),*/

        ],),
    );
  }


  pickImage(ImageSource imageType) async {
    try{
      final photo = await ImagePicker().pickImage(source: ImageSource.camera);
      if(photo == null){
        return;
      }
      final tempImage = File(photo.path);
      var snapshot = await storage.ref()
          .child("User_Image/" + photo.name)
          .putFile(tempImage);
      /*.then((taskSnapshot)
      {
        print("Task Done");
        if(taskSnapshot.state)
      });*/
      var DownloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _PickedImage = DownloadUrl; //tempImage;
      });
      Get.back();
    }catch (error){
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //ProductProvider productProvider;
    final top = 180 - 50 / 2;
    final top1 = 300 - 50 / 2;
    final top2 = 350 - 50 / 2;
    final top3 = 430 - 50 / 2;
    final top4 = 520 - 50 / 2;
    final top5 = 610 - 50 / 2;
    final top6 = 710 - 50 / 2;
    return Scaffold(
      appBar: AppBar(
        leading:edit == true? IconButton(
          color: primaryColor,
          onPressed: () {
           Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Home(
                      title: title,
                      UserName: UserName,
                      UserImage: UserImage, //PhoneNumber: '',
                    )));
            setState(() {
              edit=false;
            });
          },
          icon: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ):Container(

        ),
        title: Text(widget.title),
        actions: [
         edit==false? NotificationButton():
          IconButton(onPressed: (){

          }, icon: Icon(Icons.check,size: 30,color: Colors.green,)),
        ],
      ),

      //=============================================================
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            maxRadius: 70,
                            backgroundImage: AssetImage("assets/images/user.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 70.0,
                    right: 25.0,
                    child: InkWell(
                      onTap: (){
                        //getImage();
                        //imageProduct();
                        pickImage(ImageSource.camera);
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.deepOrange,
                        size: 28.0,
                      ),
                    )
                ),
              /* Padding(
                  padding: const EdgeInsets.only(left: 210,top: 80),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ) */
              ],
            ),
            Container(
              height: 300,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 300,
                    child: edit == true? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSingleTextFormField(UserName),
                        _buildSingleTextFormField(title),
                        _buildSingleTextFormField("01030228527"),
                        _buildSingleTextFormField("30ST Cairo"),
                      ],
                    ): Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSingleContainer(startName: "Name", endName: UserName),
                        _buildSingleContainer(startName: "Email", endName: title),
                        _buildSingleContainer(startName: "Phone", endName: "01030228527"),
                        _buildSingleContainer(startName: "Address", endName: "30ST Cairo"),
                      ],
                    ),
                  ),

                 /* _buildSingleTextFormField("AmrAhmed"),
                  _buildSingleTextFormField("amrahmed@gmail.com"),
                  _buildSingleTextFormField("01030228527"),
                  _buildSingleTextFormField("30ST Cairo"), */
                ],
              ),
            ),
          /*edit == false?*/ RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: Colors.teal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.red,
                  ),
                ],
              ),
              onPressed: (){
                setState(() {
                  edit = true;
                });
              },
              /* {
                            final modelhud =
                            Provider.of<ModelHud>(context, listen: false);
                            modelhud.changeisLoading(true);
                            if (_globalKey.currentState!.validate()) {
                              _globalKey.currentState!.save();
                              try {
                                final authResult = await _auth.signUp(
                                    _email.toString(), _password.toString());
                                modelhud.changeisLoading(false);
                                print(authResult);
                                print('success');
                               // Navigator.pushNamed(context, ShopLayout().id);
                              } catch (e) {
                                print(e);
                                modelhud.changeisLoading(false);
                               // Scaffold.of(context).showSnackBar(SnackBar(
                                //  content: Text('Error'),
                               // ));
                              }
                            }
                          }, */
            )/*:Container(

          ),*/
          ],
        ),
      )
    );
  }
}
