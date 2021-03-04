import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/DescPage/producto_page.dart';
import 'package:e_commerce/Services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class FavoritoTab extends StatefulWidget {
  @override
  _FavoritoTabState createState() => _FavoritoTabState();
}

class _FavoritoTabState extends State<FavoritoTab> {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("Users");
  final User _usercur = FirebaseAuth.instance.currentUser;
  FirebaseServices _firebaseServices = FirebaseServices();
  int cantidad = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text(
              "Favoritos",
              style: Constants.boldHeadingw,
            ),
            backgroundColor: Colors.red[900],
            automaticallyImplyLeading: false,
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUser())
                  .collection("Favoritos")
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
                          child: FutureBuilder(
                            future: _firebaseServices.productRef
                                .doc(document.id)
                                .get(),
                            builder: (context, productsnap) {
                              if (productsnap.hasError) {
                                return Container(
                                  child: Center(
                                    child: Text("${productsnap.error}"),
                                  ),
                                );
                              }
                              if (productsnap.connectionState ==
                                  ConnectionState.done) {
                                Map _productMap = productsnap.data.data();
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 24.0,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        width: 100,
                                        height: 110,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            "${_productMap['imagen'][0]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 115,
                                        top: 10,
                                        child: Container(
                                          width: 200,
                                          height: 150,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0.0,
                                                child: Text(
                                                  "${_productMap['nombre']}",
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Positioned(
                                                top: 18,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 4.0,
                                                  ),
                                                  child: Text(
                                                    "\$${_productMap['precio']}",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0.0,
                                        top: 0.0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            Future delet() {
                                              return _firebaseServices.usersRef
                                                  .doc(_firebaseServices
                                                      .getUser())
                                                  .collection("Favoritos")
                                                  .doc(document.id)
                                                  .delete();
                                            }

                                            await delet();
                                            setState(() {
                                              ListView();
                                            });
                                          },
                                          child: Container(
                                            child: Image.asset(
                                              'assets/cancelar.png',
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            },
                          ));
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
