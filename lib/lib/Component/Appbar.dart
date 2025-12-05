import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return AppBar(
        centerTitle: true,
        title: Image.asset('assets/Logo.png', color: Colors.red, fit: BoxFit.cover, width: 100,),
      //backgroundColor: Colors.black87,
      /*leading: new IconButton(
          icon: Icon(Icons.language,color: Colors.red,size: 22,),
          onPressed:(){
            //
          }
      ),*/
      actions: <Widget> [
        /*IconButton(
            icon: Icon(
                CupertinoIcons.bell,
                color: Colors.red,
                size: 24.0,
            ),
            onPressed:(){
              /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifications())
              );*/
            }
        ),*/
      ],
    );
  }

  @override
  Size get prefferredSize => Size.fromHeight(kToolbarHeight);
}

