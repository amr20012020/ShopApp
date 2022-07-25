
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/core/service/store.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/modules/admin/adminHome.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/NotificationButton.dart';
import 'package:shop_app/widgets/UserNameTextField.dart';
import 'package:shop_app/widgets/custom_text.dart';
import 'package:shop_app/widgets/custom_textfield.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';
  final String EmailAdmin;
  final String NameAdmin;
  const AddProduct({
    Key? key,
    required this.EmailAdmin,
    required this.NameAdmin,
  }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState(Email: EmailAdmin,Name: NameAdmin);
}

class _AddProductState extends State<AddProduct> {
  final String Email;
  final String Name;

  _AddProductState({
    required this.Email,
    required this.Name,
  });
  late String _name, _description, _category, _producing_Company;

  late int _price;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController();

  final _store = Store();

  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;

  final storage = FirebaseStorage.instance;


  bool edit = false;

  var _PickedImage;

  //late PickedFile _image;


  //final imagePicker = ImagePicker();



  @override
  void initState() {
    super.initState();
  }

  // File? _pickedImage;
  
  Future<void> PickedImage(ImageSource source) async{
     final _image = (await ImagePicker().getImage(source: source))!;
    final tempImage = File(_image.path);
    var snapshot = await storage.ref()
        .child("Product_Image/" + _image.path)
        .putFile(tempImage);
    var DownloadUrl = await (await snapshot).ref.getDownloadURL();
    if(_image != null) {
      setState(() {
        _PickedImage = DownloadUrl;
        print('Image Path: $_PickedImage');
      });
    }
  }


  Future<void> DialogBox(){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Pick Form Camera"),
                    onTap: (){
                      PickedImage(ImageSource.camera);
                    },
                ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick Form Gallery"),
                    onTap: (){
                      PickedImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }



 /*Future pickImage(ImageSource imageType) async {
    try{
      final photo = await ImagePicker().pickImage(source: ImageSource.camera);
      if(photo == null){
        return;
      }
      final tempImage = File(photo.path);
      var snapshot = await storage.ref()
          .child("Product_Image/" + photo.name)
          .putFile(tempImage);
      var DownloadUrl = await (await snapshot).ref.getDownloadURL();
      setState(() {
        _PickedImage = DownloadUrl; //tempImage;
      });
      Get.back();
    }catch (error){
      print(error.toString());
    }
  }*/

  Widget imageProduct(){
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
                'https://iconarchive.com/download/i84538/custom-icon-design/flatastic-4/Add-item.ico',
              width: 170,
              height: 170,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              bottom: 20.0,
              right: 5.0,
              child: InkWell(
                onTap: (){
                  DialogBox();
                  //PickedImage(ImageSource.camera);
                  //pickImage(ImageSource.camera);
                },
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.deepOrange,
                  size: 28.0,
                ),
              )
          ),
      ],),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Product", style: TextStyle(color: Colors.black)),
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
                builder: (ctx) => AdminHome(ProductId: '',EmailAdmin: Email, /*NameAdmin: Name,*/),
              ),
            );
          },
        ),
        actions: <Widget>[
          NotificationButton(),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _globalKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  imageProduct(),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm PName is empty';
                        }else{
                          _name = value;
                        }
                      },
                      cursorColor: defaultColor,
                      decoration: InputDecoration(
                        hintText: 'Product Name',
                        prefixIcon: Icon(
                          Icons.add,
                        ),
                        filled: true,
                        fillColor: whiteColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Price is empty';
                        }else{
                          _price = int.parse(value);
                        }
                      },
                      cursorColor: defaultColor,
                      decoration: InputDecoration(
                        hintText: 'Product Price',
                        prefixIcon: Icon(
                          Icons.price_change,
                        ),
                        filled: true,
                        fillColor: whiteColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Confirm PDescription is empty';
                          }else{
                            _description = value;
                          }
                        },
                        cursorColor: defaultColor,
                        decoration: InputDecoration(
                          hintText: 'Confirm Description',
                          prefixIcon: Icon(
                            Icons.description,
                          ),
                          filled: true,
                          fillColor: whiteColor,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.green)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.green)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Category is empty';
                        }else{
                          _category = value;
                        }
                      },
                      cursorColor: defaultColor,
                      decoration: InputDecoration(
                        hintText: 'Confirm Category',
                        prefixIcon: Icon(
                          Icons.category,
                        ),
                        filled: true,
                        fillColor: whiteColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Producing is empty';
                        }
                        if (value.length < 8) {
                          return 'Fill Producing';
                        }else{
                          _producing_Company = value;
                        }
                      },
                      cursorColor: defaultColor,
                      decoration: InputDecoration(
                        hintText: 'Confirm Producing company',
                        prefixIcon: Icon(
                          Icons.production_quantity_limits,
                        ),
                        filled: true,
                        fillColor: whiteColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    color: Colors.teal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Add Product',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      if(_globalKey.currentState!.validate())
                        {
                          _globalKey.currentState!.save();
                          _store.addProduct(
                            Product(
                                _PickedImage,
                                _price,
                                _name,
                                _description,
                                _category,
                                _producing_Company,
                                /*_product_Id,*/),
                          );
                          showToast(msg: "Added Success");
                        }
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

