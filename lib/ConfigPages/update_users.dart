import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/custom_btn.dart';
import 'package:e_commerce/widgets/custom_update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class UpdateUsers extends StatefulWidget {
  @override
  _UpdateUsersState createState() => _UpdateUsersState();
}

class _UpdateUsersState extends State<UpdateUsers> {
  CollectionReference perfil =
      FirebaseFirestore.instance.collection('Perfiles');
  User _user = FirebaseAuth.instance.currentUser;
  String _registerDireccion = "";
  String _registerTelefono = "";
  String _registerNombre = "";
  String _registerApellido = "";
  String _registerLocalidad = "";

  final CollectionReference _perfilReference =
      FirebaseFirestore.instance.collection("Perfiles");
  User _usuario = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot> _query;
  FocusNode _passFocusNode;

  Future update() {
    return perfil.doc(_user.email).update({
      "nombre": _registerNombre,
      "apelldio": _registerApellido,
      "direccion": _registerDireccion,
      "localidad": _registerLocalidad,
      "telefono": _registerTelefono
    });
  }

  TextInputType _textImput = TextInputType.number;
  final SnackBar _snackBar = SnackBar(content: Text("Datos actualizados"));
  @override
  void initState() {
    _query = _perfilReference.doc(_usuario.email).get();
    _passFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text(
              "Datos del Usuario",
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
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 20),
                            height: 30,
                            width: 400,
                            child: Text(
                              "Modificar los datos del usuario",
                              style: Constants.boldHeading,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "Nombre",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomUpdate(
                            hintText: "${_mapdatos['nombre']}",
                            onChanged: (value) {
                              _registerNombre = value;
                            },
                            onSubmitted: (value) {
                              _passFocusNode.requestFocus();
                            },
                            textImputAction: TextInputAction.next,
                          ),
                          //apelldio
                          Container(
                            child: Text(
                              "Apellido",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomUpdate(
                            hintText: "${_mapdatos['apelldio']}",
                            onChanged: (value) {
                              if (value.isEmpty) {
                                _registerApellido = _mapdatos['apelldio'];
                              } else {
                                _registerApellido = value;
                              }
                            },
                            onSubmitted: (value) {
                              _passFocusNode.requestFocus();
                            },
                            textImputAction: TextInputAction.next,
                          ),
                          //Telefono
                          Container(
                            child: Text(
                              "Teléfono",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomUpdate(
                            hintText: "${_mapdatos['telefono']}",
                            textimput: _textImput,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                _registerTelefono = _mapdatos['telefono'];
                              } else {
                                _registerTelefono = value;
                              }
                            },
                            onSubmitted: (value) {
                              _passFocusNode.requestFocus();
                            },
                            textImputAction: TextInputAction.next,
                          ),
                          //direccion
                          Container(
                            child: Text(
                              "Dirección",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomUpdate(
                            hintText: "${_mapdatos['direccion']}",
                            onChanged: (value) {
                              if (value.isEmpty) {
                                _registerDireccion = _mapdatos['direccion'];
                              } else {
                                _registerDireccion = value;
                              }
                            },
                            onSubmitted: (value) {
                              _passFocusNode.requestFocus();
                            },
                            textImputAction: TextInputAction.next,
                          ),
                          //localidad
                          Container(
                            child: Text(
                              "Ciudad",
                              style: Constants.boldHeadingR,
                            ),
                          ),
                          CustomUpdate(
                            hintText: "${_mapdatos['localidad']}",
                            onChanged: (value) {
                              if (value.isEmpty) {
                                _registerLocalidad = _mapdatos['localidad'];
                              } else {
                                _registerLocalidad = value;
                              }
                            },
                            onSubmitted: (value) {
                              _passFocusNode.requestFocus();
                            },
                            textImputAction: TextInputAction.next,
                          ),
                          CustomBtn(
                            text: "Actualizar",
                            onPressed: () {
                              if (_registerNombre.isEmpty) {
                                _registerNombre = _mapdatos['nombre'];
                              }
                              if (_registerApellido.isEmpty) {
                                _registerApellido = _mapdatos['apelldio'];
                              }
                              if (_registerDireccion.isEmpty) {
                                _registerDireccion = _mapdatos['direccion'];
                              }
                              if (_registerTelefono.isEmpty) {
                                _registerTelefono = _mapdatos['telefono'];
                              }
                              if (_registerLocalidad.isEmpty) {
                                _registerLocalidad = _mapdatos['localidad'];
                              }
                              update();
                              setState(() {
                                Column();
                              });
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
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
