import 'package:e_commerce/ConfigPages/pedido1.dart';
import 'package:e_commerce/ConfigPages/pedido2.dart';
import 'package:e_commerce/ConfigPages/pedido3.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class ListaPedidos extends StatefulWidget {
  @override
  _ListaPedidosState createState() => _ListaPedidosState();
}

class _ListaPedidosState extends State<ListaPedidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text(
              "Pedidos Realizados",
              style: Constants.boldHeadingw,
            ),
            backgroundColor: Colors.red[900],
          ),
          ListTile(
            title: Text(
              "Pedido 1",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Pedido1()));
            },
            subtitle: Text(
              "Entregado",
              style: TextStyle(
                color: Colors.green[300],
              ),
            ),
            leading: Image.asset(
              'assets/enviado.png',
              height: 50,
              width: 50,
            ),
          ),
          Divider(
            height: 2.0,
            color: Colors.grey[350],
          ),
          ListTile(
            title: Text(
              "Pedido 2",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Pedido2()));
            },
            subtitle: Text(
              "Pendiente de entrega",
              style: TextStyle(color: Colors.orange[300], fontSize: 15.0),
            ),
            leading: Image.asset(
              'assets/entrega.png',
              height: 50,
              width: 50,
            ),
          ),
          Divider(
            height: 2.0,
            color: Colors.grey[350],
          ),
          ListTile(
            title: Text(
              "Pedido 3",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              "Pendiente de entrega",
              style: TextStyle(color: Colors.orange[300], fontSize: 15.0),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Pedido3()));
            },
            leading: Image.asset(
              'assets/entrega.png',
              height: 50,
              width: 50,
            ),
          ),
          Divider(
            height: 2.0,
            color: Colors.grey[350],
          ),
        ],
      ),
    );
  }
}
