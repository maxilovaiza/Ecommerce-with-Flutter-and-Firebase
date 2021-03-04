import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Blocs/bloc_descpage.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/Carrito/carrito_page.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/db/operaciones.dart';
import 'package:e_commerce/widgets/imagen_swap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ProductoDesc extends StatefulWidget {
  final String productoId;

  ProductoDesc({this.productoId});

  @override
  _ProductoDescState createState() => _ProductoDescState();
}

class _ProductoDescState extends State<ProductoDesc> {
  final CollectionReference detalleOfertaReference =
      FirebaseFirestore.instance.collection("Productos");
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("Users");
  final CollectionReference _pedidosReference =
      FirebaseFirestore.instance.collection("Pedidos");
  User _user = FirebaseAuth.instance.currentUser;
  final User _usercur = FirebaseAuth.instance.currentUser;
  int cantidad = 1;
  int subprecio = 0;

  CounterBlock _block = CounterBlock();

  @override
  void dispose() {
    _block.dispose();
    super.dispose();
  }

  Future _addFav() {
    return _userReference
        .doc(_user.uid)
        .collection("Favoritos")
        .doc(widget.productoId)
        .set({});
  }

  Future _addCart(String fecha, int precio, int cantidadp) {
    return _userReference
        .doc(_user.uid)
        .collection('Cart')
        .doc(widget.productoId)
        .set({"Cantidad": cantidadp, "Fecha": fecha, "Subprecio": precio});
  }

  Future _addPedido(
    String fecha,
    int precio,
    int cantidadp,
  ) {
    return _pedidosReference
        .doc(_user.uid)
        .collection('Pedido 1')
        .doc(widget.productoId)
        .set({"Cantidad": cantidadp, "Fecha": fecha, "Subprecio": precio});
  }

  final SnackBar _snackBar =
      SnackBar(content: Text("Producto agregado al carrito"));
  final SnackBar _snackBarFav =
      SnackBar(content: Text("Producto agregado a favoritos"));

  @override
  Widget build(BuildContext context) {
    Operaciones.productos();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);

    return Scaffold(
        body: Column(
      children: [
        AppBar(
          backgroundColor: Colors.red[900],
          actions: [
            Stack(
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
            )
          ],
        ),
        Expanded(
          child: FutureBuilder(
              future: detalleOfertaReference.doc(widget.productoId).get(),
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
                      if (documentData['categoria'] == "oferta")
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 24.0),
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
                                  child: Container(
                                    child: Text("FECHA DE LA OFERTA",
                                        style: Constants.boldHeading),
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
                      //temperatura
                      if (documentData['categoria'] == "vino")
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 24.0),
                          child: Container(
                            width: 80,
                            height: 80,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0.0,
                                  top: 0.0,
                                  child: Container(
                                    height: 80.0,
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.black, width: 2.0)),
                                    child: Image.asset('assets/termometro.png'),
                                    padding: EdgeInsets.all(3.0),
                                  ),
                                ),
                                Positioned(
                                  left: 100,
                                  top: 0.0,
                                  child: Container(
                                    child: Text("TEMPERATURA",
                                        style: Constants.boldHeading),
                                  ),
                                ),
                                Positioned(
                                  left: 100,
                                  top: 30,
                                  child: Container(
                                    child: Text(
                                      "${documentData['temperatura']}",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      if (documentData['categoria'] == "vino")
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 24.0),
                          child: Container(
                            width: 80,
                            height: 80,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0.0,
                                  top: 0.0,
                                  child: Container(
                                    height: 80.0,
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.black, width: 2.0)),
                                    child: Image.asset('assets/uvas.png'),
                                    padding: EdgeInsets.all(3.0),
                                  ),
                                ),
                                Positioned(
                                  left: 100,
                                  top: 0.0,
                                  child: Container(
                                    child: Text("VARIETAL",
                                        style: Constants.boldHeading),
                                  ),
                                ),
                                Positioned(
                                  left: 100,
                                  top: 30,
                                  child: Container(
                                    child: Text(
                                      "${documentData['varietal']}",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (documentData['categoria'] == "vodka" ||
                          documentData['categoria'] == "aperitivo" ||
                          documentData['categoria'] == "whisky")
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 24.0),
                          child: Container(
                            width: 80,
                            height: 80,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0.0,
                                  top: 0.0,
                                  child: Container(
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.black, width: 2.0)),
                                    child:
                                        Image.asset('assets/graduacuion.png'),
                                    padding: EdgeInsets.all(3.0),
                                  ),
                                ),
                                Positioned(
                                  left: 70,
                                  top: 0.0,
                                  child: Container(
                                    child: Text("GRADUACION ALCOHOLICA",
                                        style: Constants.regularHeading),
                                  ),
                                ),
                                Positioned(
                                  left: 70,
                                  top: 30,
                                  child: Container(
                                    child: Text(
                                      "${documentData['graduacion']}",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      //cantidad
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          right: 150,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          height: 42,
                          width: 180,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    _block.sendEvent.add(DecresCounter());
                                  },
                                ),
                                Expanded(
                                  child: Center(
                                    child: StreamBuilder<int>(
                                        stream: _block.counterStream,
                                        initialData: 1,
                                        builder: (context, cantidadSnap) {
                                          cantidad = cantidadSnap.data;
                                          return Text(
                                            '${cantidadSnap.data}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          );
                                        }),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      _block.sendEvent.add(IncrementCounter());
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      //add y fav
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _addFav();

                                Scaffold.of(context).showSnackBar(_snackBarFav);
                              },
                              child: Container(
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
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  subprecio = documentData['precio'] * cantidad;
                                  await _addPedido(
                                      formattedDate, subprecio, cantidad);
                                  await _addCart(
                                      formattedDate, subprecio, cantidad);

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
                                    "Comprar",
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

                return Container(
                  color: Colors.transparent,
                );
              }),
        ),
      ],
    ));
  }
}
