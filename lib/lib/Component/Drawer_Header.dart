import 'package:flutter/material.dart';

class Drawer_Header extends StatefulWidget {
  @override
  Drawer_HeaderState createState() => Drawer_HeaderState();
}

class Drawer_HeaderState extends State<Drawer_Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[700],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/icon.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Image.asset('assets/Logo.png',fit: BoxFit.contain, color: Colors.red, width: 100, alignment: Alignment.center),
          SizedBox(
            height: 3,
          ),
          Image.asset('assets/tozemis.png',fit: BoxFit.contain, color: Colors.white, width: 190,alignment: Alignment.center),
          //Text("akrokol\nToz ve Duman Emiş Sistemleri",style: TextStyle(color: Colors.black, fontSize: 18,fontFamily: ('fonts/oswald-regular.ttf'),),textAlign: TextAlign.center),
        ],
      ),
    );
  }
}