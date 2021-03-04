import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/Carrito/carrito_page.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/CatalogoPages/serch_page.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/CatalogoPages/aperitivos.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/CatalogoPages/gaseosas.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/CatalogoPages/vinos.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/CatalogoPages/vodkas.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/CatalogoPages/whiskies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class CatalogoTab extends StatelessWidget {
  final CollectionReference _pedidosReference =
      FirebaseFirestore.instance.collection("Pedidos");
  final User _usercur = FirebaseAuth.instance.currentUser;
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("Users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        AppBar(
          backgroundColor: Colors.red[900],
          title: Text(
            "Catalogo",
            style: Constants.boldHeadingw,
          ),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                top: 3,
              ),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SerchPage()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, right: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarritoPage()));
                        },
                        child: Icon(FontAwesomeIcons.shoppingCart),
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
                            stream: _userReference
                                .doc(_usercur.uid)
                                .collection("Cart")
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
            )
          ],
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 10.0, bottom: 12.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      width: 350.0,
                      height: 250.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 330.0,
                            width: 350.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'assets/vinos.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 10.0, bottom: 20.0),
                                      child: Text(
                                        "Vinos",
                                        style: Constants.regularHeading,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductoVinos()));
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      width: 350.0,
                      height: 250.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 350.0,
                            width: 350.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'assets/Gaseosas.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0, right: 0.0, bottom: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 10.0, bottom: 20.0),
                                      child: Text(
                                        "Gaseosa",
                                        style: Constants.regularHeading,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductoGaseosa()));
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      width: 350.0,
                      height: 250.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 330.0,
                            width: 350.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'assets/Aperitvos.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 10.0, bottom: 20.0),
                                      child: Text(
                                        "Aperitivos",
                                        style: Constants.regularHeading,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductoAperitivos()));
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      width: 350.0,
                      height: 250.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 330.0,
                            width: 350.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'assets/Wiskies.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 10.0, bottom: 20.0),
                                      child: Text(
                                        "Whiskies",
                                        style: Constants.regularHeading,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductoWhiskies()));
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      width: 350.0,
                      height: 250.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 330.0,
                            width: 350.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'assets/Vodkas.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 10.0, bottom: 20.0),
                                      child: Text(
                                        "Vodkas",
                                        style: Constants.regularHeading,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductoVodka()));
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
