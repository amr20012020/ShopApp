import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_app/models/product.dart';

class Store {
  final productRef = FirebaseFirestore.instance
      .collection("products")
      .doc("3Mlk4LvGtj13wImlWXoK").collection("ListProduct");

  final CollectionReference deletePro = FirebaseFirestore.instance
      .collection("products")
      .doc("3Mlk4LvGtj13wImlWXoK")
      .collection("ListProduct");

  addProduct(Product product) {
    DocumentReference documentRefernce = FirebaseFirestore.instance
        .collection('products')
        .doc("3Mlk4LvGtj13wImlWXoK")
        .collection('ListProduct')
        .doc();
    documentRefernce
        .set({
          'productname': product.name,
          'image': product.image,
          'description': product.description,
          'price': product.price,
          'category': product.category,
          'producing_Company': product.companyname,
          'productId': documentRefernce.id,
        })
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add Product: $error"));
  }

  EditProduct(Product product) {
    DocumentReference documentRefernce = FirebaseFirestore.instance
        .collection('products')
        .doc("3Mlk4LvGtj13wImlWXoK")
        .collection('ListProduct')
        .doc();
    documentRefernce
        .update({
          'productname': product.name,
          'image': product.image,
          'description': product.description,
          'price': product.price,
          'category': product.category,
          'producing_Company': product.companyname,
          'productId': documentRefernce.id,
        })
        .then((value) => print("Product Updated"))
        .catchError((error) => print("Failed to Update Product: $error"));
  }

  /* return await productRef.update({
      'productname' : productname,
      'image': image,
      'description': description,
      'price': price,
      'category': category,
      'producing_Company': producing_Company,
    }*/

  UpdateData(String productname, String image, String description, int price,
      String category, String producing_Company, String id) async
  {
    final DocumentSnapshot doc = await productRef.doc(id).get();
    print(productname);
    if(doc.exists)
    {
      doc.reference.update({
        'productname': productname,
        'image': image,
        'description': description,
        'price': price,
        'category': category,
        'producing_Company': producing_Company,
      });
    }
  }

  /*editProduct(data, documentId) {
    productRef
        .collection('products')
        .doc("3Mlk4LvGtj13wImlWXoK")
        .collection('ListProduct')
        .doc(documentId)
        .update(data);
  }*/

  /*deleteProduct(Product product) {
    /* DocumentReference documentRefernce = FirebaseFirestore.instance.collection(
        'products')
        .doc("3Mlk4LvGtj13wImlWXoK")
        .collection('ListProduct').doc();
    documentRefernce.update(
      {
        'productname': FieldValue.delete(),
        'image': FieldValue.delete(),
        'description': FieldValue.delete(),
        'price': FieldValue.delete(),
        'category': FieldValue.delete(),
        'producing_Company': FieldValue.delete(),
        'productId': FieldValue.delete(),
      }
    ).then((value) => print("Product Delete")).catchError((error) =>
        print("Failed to Delete Product: $error"));*/
    FirebaseFirestore.instance
        .collection("products")
        .doc("3Mlk4LvGtj13wImlWXoK")
        .collection('ListProduct')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("ListProduct")
            .doc(element.id)
            .delete()
            .then((value) {
          print("Product deleted!");
        });
      });
    });
  } */

  Future deleteProduct1(String documentId) async {
    try {
      await deletePro.doc(documentId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
