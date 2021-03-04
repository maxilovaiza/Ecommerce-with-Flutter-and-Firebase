import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InfoUser extends StatefulWidget {
  @override
  _InfoUserState createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  final CollectionReference _perfilReference =
  FirebaseFirestore.instance.collection("Perfiles");
  User _usuario = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot> _query;
  @override
  void initState() {
    _query= _perfilReference.doc(_usuario.email).get();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<DocumentSnapshot>(
          future: _query,
          builder:(context, snapshot){
            if(snapshot.hasData) {
              Map _mapdatos = snapshot.data.data();
              return  Container(
                  width: 400,
                  height: 120,
                  margin: EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 2.0)
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0.0,
                        top: 0.0,
                        child: Container(
                          child: Row(
                            children: [
                              Text("Nombre: ",
                                style: Constants.regularHeading,),
                              Text("${_mapdatos['nombre']}",
                                style: TextStyle(
                                  fontSize: 18
                                ),),
                            ],
                          ),
                        ),
                      ),
                      //apelldio
                      Positioned(
                        left: 0.0,
                        top: 22,
                        child: Container(
                          child: Row(
                            children: [
                              Text("Apellido: ",
                                style: Constants.regularHeading,),
                              Text("${_mapdatos['apelldio']}",
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                            ],
                          ),
                        ),
                      ),
                      //Telefono
                      Positioned(
                        left: 0.0,
                        top: 44,
                        child: Container(
                          child: Row(
                            children: [
                              Text("Telefono: ",
                                style: Constants.regularHeading,),
                              Text("${_mapdatos['telefono']}",
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                            ],
                          ),
                        ),
                      ),
                      //direccion
                      Positioned(
                        left: 0.0,
                        top: 66,
                        child: Container(
                          child: Row(
                            children: [
                              Text("Direccion: ",
                                style: Constants.regularHeading,),
                              Text("${_mapdatos['direccion']}",
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                            ],
                          ),
                        ),
                      ),
                      //localidad
                      Positioned(
                        left: 0.0,
                        top: 88,
                        child: Container(

                          child: Row(
                            children: [
                              Text("Ciudad: ",
                                style: Constants.regularHeading,),
                              Text("${_mapdatos['localidad']}",
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              );
            }
            return Container(
                child: Text("Loading.....",style: Constants.boldHeading,));
          }

      ),
    );
  }
}
