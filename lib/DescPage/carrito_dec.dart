import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:e_commerce/widgets/imagen_swap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarritoDesc extends StatefulWidget {
  final String productoId;
  CarritoDesc({this.productoId});

  @override
  _CarritoDescState createState() => _CarritoDescState();
}

class _CarritoDescState extends State<CarritoDesc> {
  final CollectionReference detallecarritoference =
      FirebaseFirestore.instance.collection("Productos");
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("Users");
  User _user = FirebaseAuth.instance.currentUser;

  Future _addCart() {
    return _userReference
        .doc(_user.uid)
        .collection("Cart")
        .doc(widget.productoId)
        .set({"Tamaño": 1, "Coleccion": "Ofertas"});
  }

  final SnackBar _snackBar = SnackBar(content: Text("Producto agregado"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
          future: detallecarritoference.doc(widget.productoId).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error ${snapshot.error}"),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              // Mapa de los documentos de firebase
              Map<String, dynamic> documentData = snapshot.data.data();

              //Lista de imagenes

              List imagenList = documentData['imagen'];
              return ListView(
                padding: EdgeInsets.all(0),
                children: [
                  ImagenSwep(
                    imagenList: imagenList,
                  ),
                  //nombre
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0, left: 24.0, right: 24.0, bottom: 4.0),
                    child: Text(
                      "${documentData['nombre']}",
                      style: Constants.boldHeading,
                    ),
                  ),
                  //precio
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 24.0),
                    child: Text(
                      "\$${documentData['precio']}",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.red[900],
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  //desceripcion
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    child: Text(
                      "${documentData['descripcion']}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  //fecha
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0.0,
                            top: 0.0,
                            child: Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.black, width: 2.0)),
                              child: Image.asset(
                                'assets/calendario2.png',
                                height: 30,
                                width: 30,
                              ),
                              padding: EdgeInsets.all(3.0),
                            ),
                          ),
                          Positioned(
                            left: 80,
                            top: 0.0,
                            child: Visibility(
                              visible: false,
                              child: Container(
                                child: Text("FECHA DE LA OFERTA",
                                    style: Constants.boldHeading),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 80,
                            top: 30,
                            child: Container(
                              child: Text(
                                "${documentData['fecha']}",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //add y fav
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(12.0)),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/corazon.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await _addCart();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              height: 60,
                              width: 200,
                              margin: EdgeInsets.only(left: 16.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.red[900],
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }

            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        CustomActionbar(
          hasBackArrow: true,
          hasTitle: false,
          hasBackground: false,
        ),
      ],
    ));
  }
}
