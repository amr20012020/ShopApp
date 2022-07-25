import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/admin/ProductdetailAdmin.dart';
import 'package:shop_app/modules/admin/adminHome.dart';
import 'package:shop_app/widgets/Editing.dart';

import '../../core/service/store.dart';
import '../../models/product.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/UserNameTextField.dart';
import '../../widgets/custom_textfield.dart';
import '../profilePage/ProfileView.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  final String image;
  late final String name;
  final int price;
  final String description;
  final String Category;
  final String Producing_Company;
  final String title;
  final String UserName;
  final String ProductId;
  final String userId;

  EditProduct(this.image, this.name, this.price,this.Category,this.Producing_Company, this.description, {required this.title, required this.UserName,required this.ProductId, required this.userId});

  @override
  State<EditProduct> createState() => _EditProductState(title: title, ProductId: ProductId, UserName: UserName, userId: userId, name: name,
      description: description, image: image, price: price, Category: Category, Producing_Company: Producing_Company);
}

class _EditProductState extends State<EditProduct> {

  final String UserName;
  final String title;
  final String ProductId;
  final String userId;

  final String image;
  late final String name;
  late int price;
  late final String description;
  late final String Category;
  late final String Producing_Company;

  _EditProductState({required this.title, required this.ProductId, required this.UserName, required this.userId,
    required this.image,required this.name,required this.price,required this.Category,required this.description,required this.Producing_Company});
  //late String _name, _price, _description, _category, _imageLocation, _producing_Company;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _store = Store();
  var _PickedImage;

  var ProductName = TextEditingController();
  var Price = TextEditingController();
  var Description = TextEditingController();
  var ProductCategory = TextEditingController();
  var Company = TextEditingController();



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


  Widget imageProduct(){
    return Center(
      child: Stack(
        children: <Widget>[
          ClipOval(
            child: widget.image != null
                ? Image.network(
              widget.image!,
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
    //Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Product", style: TextStyle(color: Colors.black)),
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
                builder: (ctx) => ProductDetailAdmin(image,name,price.toString(),Category,Producing_Company,description,Email: title, UserName: UserName, userId: userId, ProductId: ProductId,),
              ),
            );
          },
        ),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            imageProduct(),
            SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: EditingTextField(name: widget.name, controller: ProductName,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildSingleTextFormField(widget.name),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildSingleTextFormField(widget.Producing_Company),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildSingleTextFormField(widget.price.toString()),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildSingleTextFormField(widget.description),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildSingleTextFormField(widget.Category),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildSingleTextFormField(widget.Producing_Company),
                ),
               /* Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildSingleTextFormField(widget.ProductId),
                ),*/

                RaisedButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      {
                      /* _store.EditProduct(
                        Product(
                           image,
                           price,
                           name,
                           description,
                           Category,
                           Producing_Company,
                           /*ProductId,*/),
                    );*/
                        _store.UpdateData(
                            widget.name,
                            widget.image,
                            widget.description,
                            widget.price,
                            widget.Category,
                            widget.Producing_Company,
                            widget.ProductId);
                        /*_store.editProduct(
                          Product(
                            image,
                            price,
                            name,
                            description,
                            Category,
                            Producing_Company,
                            /*_product_Id,*/),*/
                  }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: Colors.teal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Edit Product',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}