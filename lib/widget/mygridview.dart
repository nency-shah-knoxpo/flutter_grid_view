import 'package:flutter/material.dart';
import 'package:flutter_grid_view/model/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyGridView extends StatelessWidget {
  final List<Product> products;
  final List<String> url = new List();

  MyGridView(this.products);

  @override
  Widget build(BuildContext context) {
    StorageReference f = FirebaseStorage.instance.ref().child("image1.png");
    FirebaseStorage s = f.getStorage();
    return new StreamBuilder(
        stream: Firestore.instance.collection('ToDo').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
          if (!snap.hasData) return new Text('Loading...');
          return GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(10.0),
            childAspectRatio: 8.0 / 9.0,
          //  children: _getGridViewItems(context),
           children: snap.data.documents.map((doc){
             Product p = new Product(doc['title'], 10, doc['avatarUrl']);
              Widget w = _getGridItemUI(context, p);
              return w;
            }).toList()
          );
        });
  }

  _getGridViewItems(BuildContext context) {
    List<Widget> allWidgets = new List<Widget>();
    for (int i = 0; i < products.length; i++) {
      var widget = _getGridItemUI(context, products[i]);
      allWidgets.add(widget);
    }
    return allWidgets;
  }

  _getGridItemUI(BuildContext context, Product item) {
    String path;

    return new InkWell(
        onTap: () {
          _showSnackBar(context, item);
        },
        child: new Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                  child: new Center(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: new Column(
                      children: <Widget>[
                        new Image.network(
                          item.image,
                          //snap.data.documents.first['avatarUrl'],
                          fit: BoxFit.fill,
                          height: 70.0,
                          width: 70.0,
                        ),
                        new SizedBox(height: 30.0),
                        new Text(item.name),
                        new Text('Price: ${item.price}')
                      ],
                    )),
              ))
            ],
          ),
          elevation: 2.0,
          margin: EdgeInsets.all(5.0),
        ));
  }

  _showSnackBar(BuildContext context, Product item) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text("${item.name} is a city in ${item.name}"),
      backgroundColor: Colors.amber,
    );

    Scaffold.of(context).showSnackBar(objSnackbar);
  }
}
