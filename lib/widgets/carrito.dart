import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/Carrito/carrito_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Carrito extends StatefulWidget {
  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  final CollectionReference _pedidoReference =
      FirebaseFirestore.instance.collection("Pedidos");
  final User _usercur = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CarritoPage()));
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
                  child: Icon(FontAwesomeIcons.shoppingCart),
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
                            .collection("Pedido")
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
    );
  }
}
