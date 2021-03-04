import 'acerdade.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/ConfigPages/perfil_user.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/ConfigPages/update_users.dart';
import 'package:e_commerce/ConfigPages/pedidos.dart';
import 'package:e_commerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfigTab extends StatefulWidget {
  @override
  _ConfigTabState createState() => _ConfigTabState();
}

class _ConfigTabState extends State<ConfigTab> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Cerrar Sesión',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w900),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Quieres Cerrar Sesión?',
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text(
              "Configuraciones",
              style: Constants.boldHeadingw,
            ),
            backgroundColor: Colors.red[900],
            automaticallyImplyLeading: false,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              children: [
                ListTile(
                  title: Text("Usuario"),
                  leading: Icon(
                    FontAwesomeIcons.user,
                    size: 30,
                  ),
                  subtitle: Text("Datos del usuario"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PerfilUsuario()));
                  },
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                ),
                ListTile(
                  title: Text("Editar Datos"),
                  leading: Icon(
                    FontAwesomeIcons.addressCard,
                    size: 30,
                  ),
                  subtitle: Text("Editar los datos del usuario"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UpdateUsers()));
                  },
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                ),
                ListTile(
                  title: Text("Pedidos"),
                  leading: Icon(
                    FontAwesomeIcons.dollyFlatbed,
                    size: 30,
                  ),
                  subtitle: Text("Pedidos realizados"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaPedidos()));
                  },
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                ),
                ListTile(
                  title: Text("Acerca De"),
                  leading: Icon(
                    FontAwesomeIcons.exclamationCircle,
                    size: 30,
                  ),
                  subtitle: Text("Acerca de EcommerceApp"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AcercaDe()));
                  },
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                ),
                ListTile(
                  title: Text("Cerrar Sesión"),
                  leading: Icon(
                    FontAwesomeIcons.signOutAlt,
                    size: 30,
                  ),
                  subtitle: Text("Salir de la ceunta"),
                  onTap: () {
                    _showMyDialog();
                  },
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
