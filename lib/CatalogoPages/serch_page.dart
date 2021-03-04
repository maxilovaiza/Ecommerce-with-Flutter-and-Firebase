import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/DescPage/producto_page.dart';
import 'package:e_commerce/Services/services.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/widgets/custom_imput.dart';
import 'package:flutter/material.dart';

class SerchPage extends StatefulWidget {
  @override
  _SerchPageState createState() => _SerchPageState();
}

class _SerchPageState extends State<SerchPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _serch = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          if (_serch.isEmpty)
            Center(child: Text("Buscar algo..."))
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productRef
                  .orderBy("_serch")
                  .startAt([_serch]).endAt(["$_serch\uf8ff"]).get(),
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
                    padding: EdgeInsets.only(top: 115.0, bottom: 12.0),
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
                              height: 60,
                              width: 350,
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                  ],
                                ),
                              ),
                            ),
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
          SafeArea(
            child: CustomImput(
              hintText: "Busque ...",
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _serch = value.toLowerCase();
                  });
                }
              },
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    ));
  }
}
