import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce/DescPage/producto_page.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/Carrito/carrito_page.dart';
import 'package:e_commerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductoAperitivos extends StatefulWidget {
  @override
  _ProductoAperitivosState createState() => _ProductoAperitivosState();
}

class _ProductoAperitivosState extends State<ProductoAperitivos> {
  final CollectionReference _aperitivoReference =
      FirebaseFirestore.instance.collection("Productos");
  final CollectionReference _pedidosReference =
      FirebaseFirestore.instance.collection("Pedidos");
  final CollectionReference _usersReference =
      FirebaseFirestore.instance.collection("Users");

  final User _usercur = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.red[900],
            title: Text(
              "Aperitivo",
              style: Constants.boldHeadingw,
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15, top: 5),
                child: Stack(
                  children: [
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, right: 15),
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
                              stream: _usersReference
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
            child: FutureBuilder<QuerySnapshot>(
              future: _aperitivoReference
                  .where('categoria', isEqualTo: "aperitivo")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error ${snapshot.error}"),
                    ),
                  );
                }
                //cuando verifico los datos de la base, saca el progresbar y carga los datos en un listview
                if (snapshot.connectionState == ConnectionState.done) {
                  //Pone los datos adentro de un listview y los muestra
                  return ListView(
                    padding: EdgeInsets.only(top: 10.0, bottom: 12.0),
                    children: snapshot.data.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductoDesc(
                                        productoId: document.id,
                                      )));
                        },
                        child: Container(
                            width: 250,
                            height: 200,
                            padding: EdgeInsets.only(top: 40.0),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 30.0,
                                    left: 2.0,
                                    right: 1.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.8),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      width: 400,
                                      height: 100.0,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 24.0,
                                      ),
                                    )),
                                Positioned(
                                  top: 30.0,
                                  left: 2.0,
                                  right: 1.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    width: 350,
                                    height: 100,
                                    margin: EdgeInsets.only(
                                        top: 12.0,
                                        bottom: 12.0,
                                        left: 24.0,
                                        right: 30.0),
                                  ),
                                ),
                                Positioned(
                                  right: 80.0,
                                  top: 0.0,
                                  child: Container(
                                    child: Image.network(
                                        "${document.data()['imagencard'][0]}"),
                                    height: 140.0,
                                    width: 50.0,
                                  ),
                                ),
                                Positioned(
                                    left: 40,
                                    top: 50,
                                    child: Container(
                                      child: Text(
                                          document.data()['nombre'] ??
                                              "Nombre de la oferta",
                                          style: Constants.boldHeading),
                                    )),
                                Positioned(
                                    left: 25,
                                    bottom: 17,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 0.0),
                                      decoration: BoxDecoration(
                                          color: Colors.red[600],
                                          borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(12.0))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                            "\$" +
                                                    document
                                                        .data()['precio']
                                                        .toString() ??
                                                "Nombre de la oferta",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white)),
                                      ),
                                    )),
                              ],
                            )),
                      );
                    }).toList(),
                  );
                }
                //cargando los datos
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
