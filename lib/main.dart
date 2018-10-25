import 'package:flutter/material.dart';
import 'package:flutter_grid_view/pages/homepage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Grid App',
      theme: new ThemeData(
        primarySwatch: Colors.amber
      ),
      // Todo:
      home: new HomePage() ,
    );
  }


}

