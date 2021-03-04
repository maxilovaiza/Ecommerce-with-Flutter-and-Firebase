import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/ConfigPages/update_users.dart';
import 'package:e_commerce/DescPage/producto_page.dart';
import 'package:e_commerce/Services/services.dart';
import 'package:e_commerce/db/operaciones.dart';
import 'package:e_commerce/homePages/home_Page.dart';
import 'package:e_commerce/widgets/bottom_sheet.dart';
import 'package:e_commerce/widgets/total.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarritoPage extends StatefulWidget {
  final double total;

  CarritoPage({this.total});

  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  Stream<QuerySnapshot> _query;
  final String stringV = "";

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            '¿Quiere hacer el pedido?',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w900),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.dolly,
                  size: 60,
                  color: Colors.red[900],
                ),
                Text(
                  'Primero deberias revisar los datos de envio',
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Verificar Datos',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpdateUsers()));
              },
            ),
            TextButton(
              child: Text(
                'Realizar Pedido',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                deletCart();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deletCart() {
    _firebaseServices.usersRef
        .doc(_firebaseServices.getUser())
        .collection('Cart')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Future<String> getStringValuesSF() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringV = prefs.getString('stringValue') ?? "Pedido 1";
    return stringV;
  }

  @override
  void initState() {
    super.initState();
    _query = _firebaseServices.usersRef
        .doc(_firebaseServices.getUser())
        .collection('Cart')
        .snapshots();
    getStringValuesSF();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text("Carrito"),
            leading: BackButton(),
            backgroundColor: Colors.red[900],
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Icon(FontAwesomeIcons.shoppingCart),
                ),
              )
            ],
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUser())
                  .collection('Cart')
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
                                        height: 109,
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
                                              Positioned(
                                                right: 115,
                                                top: 50,
                                                child: Text(
                                                  "Cantidad: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Positioned(
                                                  top: 50,
                                                  right: 100,
                                                  child: FutureBuilder(
                                                      future: _firebaseServices
                                                          .usersRef
                                                          .doc(_firebaseServices
                                                              .getUser())
                                                          .collection('Cart')
                                                          .doc(document.id)
                                                          .get(),
                                                      builder: (context,
                                                          cantisnapshot) {
                                                        Map _document =
                                                            cantisnapshot.data
                                                                .data();
                                                        return Text(
                                                          "${_document['Cantidad']}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black),
                                                        );
                                                      }))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0.0,
                                        top: 0.0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            Future deletPedido() {
                                              return _firebaseServices.pedidoRef
                                                  .doc(_firebaseServices
                                                      .getUser())
                                                  .collection('Pedido 1')
                                                  .doc(document.id)
                                                  .delete();
                                            }

                                            Future deleteCart() {
                                              return _firebaseServices.usersRef
                                                  .doc(_firebaseServices
                                                      .getUser())
                                                  .collection('Cart')
                                                  .doc(document.id)
                                                  .delete();
                                            }

                                            await deletPedido();
                                            await deleteCart();
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
                                      Positioned(
                                          left: 0.0,
                                          bottom: 0.0,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              height: 1,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                color: Colors.black,
                                              )),
                                            ),
                                          ))
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
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red, width: 4.0)),
                  height: 60,
                  width: 300,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _query,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return TotalWidget(documentos: snapshot.data.docs);
                        }
                        return CircularProgressIndicator();
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: GestureDetector(
                  onTap: () async {
                    _showMyDialog();
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
                      "Comprar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
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
