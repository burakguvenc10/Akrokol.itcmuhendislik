import 'package:flutter/material.dart';

class Splash_item extends StatelessWidget {
  final String asset;
  final String title;

  Splash_item(this.asset,this.title);

  @override
  Widget build(BuildContext context){
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(3)),
          Image.asset(
            asset,
            height: 140,
            fit: BoxFit.fill,
          ),

          Text(
            title,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),

        ],
      ),
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 5,

    );
  }

}