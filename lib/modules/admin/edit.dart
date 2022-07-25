import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:shop_app/modules/admin/ProductdetailAdmin.dart';
import 'package:shop_app/modules/admin/adminHome.dart';

class EditScreen extends StatefulWidget {
  final String ProductId;
  final String EmailAdmin;

  EditScreen({required this.ProductId,required this.EmailAdmin,});
  @override
  _EditScreenState createState() => _EditScreenState(
    ProductId: ProductId,
    Email: EmailAdmin,);
}

class _EditScreenState extends State<EditScreen> {
  final String ProductId;
  final String Email;
  //final String Name;

  _EditScreenState({
    required this.ProductId,
    required this.Email,
    //required this.Name,
  });
  Color primaryColor = Colors.teal;
  //Color secondaryColor = Color(0xff232c51);
 // Color logoGreen = Color(0xff25bcbb);

  // create controllers for every input field
  TextEditingController productnameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  CollectionReference prodRef = FirebaseFirestore.instance
      .collection("products")
      .doc("3Mlk4LvGtj13wImlWXoK")
      .collection("ListProduct");

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.green)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            border: InputBorder.none),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
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
                  builder: (ctx) => AdminHome(ProductId: '',EmailAdmin: Email, /*NameAdmin: Name,*/),
                ),
              );
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: prodRef.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return ListView.builder(
                    itemCount: snapshot.data!.docs
                        .length, // 3add el documents ely mawgoda fi el collection
                    itemBuilder: (context, index) {
                      var doc = snapshot.requireData!.docs[
                          index]; // hna ana bageeb el data ely gowa kol document aw el attributes
                      return ListTile(
                        leading: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.black,
                            onPressed: () {
                              // add this line for each product attribute
                              print("aaaaaaaaaaaa");
                              print(doc);
                              productnameController.text = doc["productname"];
                              priceController.text = doc["price"].toString();
                              descriptionController.text = doc["description"];
                              categoryController.text = doc["category"];
                              companyController.text = doc["producing_Company"];
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                      child: Container(
                                          color: Colors.teal,
                                          child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: ListView(
                                                shrinkWrap: true,
                                                children: <Widget>[
                                                  _buildTextField(
                                                      productnameController,
                                                      "Product name"),
                                                  SizedBox(height: 20),
                                                  _buildTextField(
                                                      priceController,
                                                      "Price"),
                                                  SizedBox(height: 20),
                                                  _buildTextField(
                                                      descriptionController,
                                                      "Description"),
                                                  SizedBox(height: 20),
                                                  _buildTextField(
                                                      categoryController,
                                                      "Category"),
                                                  SizedBox(height: 20),
                                                  _buildTextField(
                                                      companyController,
                                                      "Company"),
                                                  SizedBox(height: 20),
                                                  TextButton(
                                                    child: Padding(
                                                        padding: EdgeInsets.all(16.0),
                                                        child: Text("edit product",style: TextStyle(color: Colors.black),)),
                                                    onPressed: () {
                                                      snapshot.requireData
                                                          .docs[index].reference
                                                          .update({
                                                                 "productname": productnameController.text, // add this line for each product property
                                                                 "price": int.parse(priceController.text),
                                                                 "producing_Company": companyController.text,
                                                                 "category": categoryController.text,
                                                                 "description": descriptionController.text,
                                                          }).whenComplete(() => Navigator.pop(context));
                                                    },
                                                  ),
                                                ],
                                              ))))
                              );
                            }), // di el 7aga daymn el btb2a 3ala ymen el tile aw (el div bl web)

                        title: Text(doc["productname"], style: TextStyle(color: Colors.black, fontSize: 20)),

                        subtitle: Column(
                          children: <Widget>[
                            // Text(doc["brand"] ,style: TextStyle(color:Colors.white)),
                            Text("\$ ${doc["price"].toString()}",
                                style: TextStyle(color: Colors.black, fontSize: 20))
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        trailing: Image.network(
                            doc["image"], height: 100, width: 100,
                            fit: BoxFit.cover), // di el 7aga daymn el btb2a 3ala shmal el tile aw (el div bl web)
                      );
                    });
              else
                return Text("no data");
            }) // for real time changes
        );
  }
}
