import 'package:flutter/material.dart';

import '../constants.dart';

class AcercaDe extends StatefulWidget {
  @override
  _AcercaDeState createState() => _AcercaDeState();
}

class _AcercaDeState extends State<AcercaDe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text(
              "Acerca de EcommerceApp",
              style: Constants.boldHeadingw,
            ),
            backgroundColor: Colors.red[900],
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/ic_logoapp.png',
            height: 200,
            width: 200,
          ),
          Text(
            "EcommerceApp para Android",
            style: Constants.boldHeading,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Version 1.0",
            style: Constants.regularHeading,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Copyright 2020-2020 EcommerceApp Inc.",
            style: TextStyle(
              color: Colors.grey[350],
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Soldado Carrascull 535,CP 5929,Cordoba,Argentina",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 2,
            color: Colors.black54,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Terminos y Condiciones",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  "Como cuidamos tu privacidad",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  "Aviso legales",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                )
              ],
            ),
          ),
          Divider(height: 2, color: Colors.black54),
        ],
      ),
    );
  }
}
