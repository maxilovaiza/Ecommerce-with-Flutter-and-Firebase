import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/DescPage/producto_page.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/Carrito/carrito_page.dart';
import 'package:e_commerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _ofertasReference =
      FirebaseFirestore.instance.collection("Productos");
  final CollectionReference _pedidosReference =
      FirebaseFirestore.instance.collection("Pedidos");
  final CollectionReference _usersReference =
      FirebaseFirestore.instance.collection("Users");
  final User _usercur = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.red[900],
          title: Text(
            "Home",
            style: Constants.boldHeadingw,
          ),
          automaticallyImplyLeading: false,
          actions: [
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
            future:
                _ofertasReference.where('categoria', isEqualTo: "oferta").get(),
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
                        print(document.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 350,
                          width: 350,
                          child: Stack(
                            children: [
                              //imagen
                              Positioned(
                                left: 10.0,
                                right: 10,
                                child: Container(
                                  height: 300.0,
                                  width: 350.0,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0)),
                                    child: Image.network(
                                      "${document.data()['imagen'][0]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              //texto
                              Positioned(
                                left: 10,
                                right: 10,
                                top: 250,
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12.0),
                                        bottomRight: Radius.circular(12.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text(
                                              document.data()['nombre'] ??
                                                  "Nombre de la oferta",
                                              style: Constants.boldHeading),
                                        ),
                                      ),
                                      Positioned(
                                        right: 8.0,
                                        child: Container(
                                          child: Text(
                                              "\$" +
                                                      document
                                                          .data()['precio']
                                                          .toString() ??
                                                  "Nombre de la oferta",
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.red)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
    );
  }
}
