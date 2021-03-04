import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/Carrito/carrito_page.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/CatalogoPages/serch_page.dart';
import 'package:e_commerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomActionbar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  final bool hasBackgroundArrow;
  final bool serch;
  final bool carrito;

  CustomActionbar(
      {this.title,
      this.hasBackArrow,
      this.hasTitle,
      this.hasBackground,
      this.hasBackgroundArrow,
      this.serch,
      this.carrito});
  final CollectionReference _pedidoReference =
      FirebaseFirestore.instance.collection("Pedidos");
  final User _usercur = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;
    bool _hasBackgroundArrow = hasBackgroundArrow ?? false;
    bool _hasSerch = serch ?? false;
    bool _hascarrito = carrito ?? false;

    return Container(
      decoration: BoxDecoration(color: _hasBackground ? Colors.red[900] : null),
      padding:
          EdgeInsets.only(top: 50.0, right: 24.0, left: 24.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color:
                      _hasBackgroundArrow ? Colors.transparent : Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(
                    "assets/flecha-izquierda.png",
                  ),
                  width: 20.0,
                  height: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? "CustomActionBar",
              style: Constants.boldHeadingw,
            ),
          Row(
            children: [
              if (_hasSerch)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SerchPage()));
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage(
                        "assets/lupa.png",
                      ),
                      width: 30.0,
                      height: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (_hascarrito)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CarritoPage()));
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.red[900],
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0.0,
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/carrito-de-compras.png',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                              width: 20.0,
                              height: 20.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.red[900],
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(color: Colors.white)),
                              child: StreamBuilder(
                                  stream: _pedidoReference
                                      .doc(_usercur.uid)
                                      .collection("Pedido 2")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    int _totalItems = 0;

                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      List _documentos = snapshot.data.docs;
                                      _totalItems = _documentos.length;
                                    }
                                    return Text(
                                      "$_totalItems" ?? "0",
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    );
                                  })),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
