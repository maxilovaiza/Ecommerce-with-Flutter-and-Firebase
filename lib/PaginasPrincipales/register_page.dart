import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/custom_btn.dart';
import 'package:e_commerce/widgets/custom_imput.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  CollectionReference perfil =
      FirebaseFirestore.instance.collection('Perfiles');
  //creador de alerta
  Future<void> _alerDialog(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cerrar"))
            ],
          );
        });
  }

//crear usuario
  Future<String> _registrarUsuario() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      await perfil.doc(_registerEmail).set({
        "nombre": _registerNombre,
        "apelldio": _registerApellido,
        "direccion": _registerDireccion,
        "localidad": _registerLocalidad,
        "telefono": _registerTelefono
      });
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'La contraseña es muy debil';
      } else if (e.code == 'email-already-in-use') {
        return 'El correo esta en uso';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });
    String _crearCuentaFeedBack = await _registrarUsuario();
    if (_crearCuentaFeedBack != null) {
      _alerDialog(_crearCuentaFeedBack);
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      //Si el String era nulo, el usuarion ingreso
      Navigator.pop(context);
    }
  }

  bool _registerFormLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";
  String _registerDireccion = "";
  String _registerTelefono = "";
  String _registerNombre = "";
  String _registerApellido = "";
  String _registerLocalidad = "";

  TextInputType _imputType = TextInputType.number;
  TextCapitalization _imputCap = TextCapitalization.none;

  FocusNode _passFocusNode;

  @override
  void initState() {
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
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Crear Cuenta nueva",
                      textAlign: TextAlign.center,
                      style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "(Ingresar los datos \n en los campos sin espacios \n para que no salga error)",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0, top: 70.0),
                    child: Column(
                      children: [
                        CustomImput(
                          hintText: "Nombre...",
                          onChanged: (value) {
                            _registerNombre = value;
                          },
                          onSubmitted: (value) {
                            _passFocusNode.requestFocus();
                          },
                          textImputAction: TextInputAction.next,
                        ),
                        CustomImput(
                          hintText: "Apellido",
                          onChanged: (value) {
                            _registerApellido = value;
                          },
                          onSubmitted: (value) {
                            _passFocusNode.requestFocus();
                          },
                          textImputAction: TextInputAction.next,
                        ),
                        CustomImput(
                          hintText: "Telefono...",
                          textimput: _imputType,
                          onChanged: (value) {
                            _registerTelefono = value;
                          },
                          onSubmitted: (value) {
                            _passFocusNode.requestFocus();
                          },
                          textImputAction: TextInputAction.next,
                        ),
                        CustomImput(
                          hintText: "Direccion...",
                          onChanged: (value) {
                            _registerDireccion = value;
                          },
                          onSubmitted: (value) {
                            _passFocusNode.requestFocus();
                          },
                          textImputAction: TextInputAction.next,
                        ),
                        CustomImput(
                          hintText: "Localidad...",
                          onChanged: (value) {
                            _registerLocalidad = value;
                          },
                          onSubmitted: (value) {
                            _passFocusNode.requestFocus();
                          },
                          textImputAction: TextInputAction.next,
                        ),
                        CustomImput(
                          hintText: "Email...",
                          textCap: _imputCap,
                          onChanged: (value) {
                            _registerEmail = value;
                          },
                          onSubmitted: (value) {
                            _passFocusNode.requestFocus();
                          },
                          textImputAction: TextInputAction.next,
                        ),
                        CustomImput(
                          hintText: "Contraseña...",
                          onChanged: (value) {
                            _registerPassword = value;
                          },
                          onSubmitted: (value) {
                            _submitForm();
                          },
                          focusNode: _passFocusNode,
                          isPassField: true,
                        ),
                        CustomBtn(
                          text: "Registrarse",
                          onPressed: () {
                            _submitForm();
                          },
                          isLoading: _registerFormLoading,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomBtn(
                      text: "Volver a Inicio de Sesion",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      outlineBtn: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
