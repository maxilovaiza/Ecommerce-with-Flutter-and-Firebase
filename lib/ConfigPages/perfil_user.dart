import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/custom_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PerfilUsuario extends StatefulWidget {
  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  final CollectionReference _perfilReference =
      FirebaseFirestore.instance.collection("Perfiles");
  User _usuario = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot> _query;

  @override
  void initState() {
    _query = _perfilReference.doc(_usuario.email).get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text(
              "Usiario",
              style: Constants.boldHeadingw,
            ),
            backgroundColor: Colors.red[900],
          ),
          Expanded(
            child: FutureBuilder<DocumentSnapshot>(
                future: _query,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map _mapdatos = snapshot.data.data();
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/default-user.png'),
                          ),
                          Container(
                            child: Text(
                              "Nombre",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomInfo(
                            hintText: "${_mapdatos['nombre']}",
                          ),
                          //apelldio
                          Container(
                            child: Text(
                              "Apellido",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomInfo(
                            hintText: "${_mapdatos['apelldio']}",
                          ),
                          //Telefono
                          Container(
                            child: Text(
                              "Teléfono",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomInfo(
                            hintText: "${_mapdatos['telefono']}",
                          ),
                          //direccion
                          Container(
                            child: Text(
                              "Dirección",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomInfo(
                            hintText: "${_mapdatos['direccion']}",
                          ),
                          //localidad
                          Container(
                            child: Text(
                              "Ciudad",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomInfo(
                            hintText: "${_mapdatos['localidad']}",
                          ),
                        ],
                      ),
                    );
                  }
                  return Container(
                      child: Text(
                    "Loading.....",
                    style: Constants.boldHeading,
                  ));
                }),
          ),
        ],
      ),
    );
  }
}
