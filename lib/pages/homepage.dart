import 'package:flutter/material.dart';
import 'package:flutter_grid_view/model/product.dart';
import 'package:flutter_grid_view/widget/mygridview.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  List<Product> products = Product.getAllProducts();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Product Grid",
          style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _addImage(),
        child: Icon(Icons.add),

      ),
      body: new Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: new MyGridView(products)),
    );
  }

  void _addImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    var no = new Random();
    int id;
    for (var i = 0; i < 10; i++) {
      id = no.nextInt(100);
    }
    StorageReference storageRef =
    FirebaseStorage.instance.ref().child("images/$id");


    StorageUploadTask task = storageRef.putFile(image);

    var url = await (await task.onComplete).ref.getDownloadURL();

    Product.urls.add(url);
    Firestore.instance.collection('ToDo').document()
        .setData({
      'title':'todo',
      'isChecked':true,
      'avatarUrl': url
    });
  }
}
