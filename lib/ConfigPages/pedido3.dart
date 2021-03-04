import 'package:flutter/material.dart';

import '../constants.dart';

class Pedido3 extends StatefulWidget {
  @override
  _Pedido3State createState() => _Pedido3State();
}

class _Pedido3State extends State<Pedido3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            title: Text(
              "Pedido 3",
              style: Constants.boldHeadingw,
            ),
            backgroundColor: Colors.red[900],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Image.asset(
                  'assets/regalo.png',
                  height: 30,
                  width: 30,
                  color: Colors.orange[300],
                ),
                Text(" Productos Pendientes", style: Constants.boldHeading)
              ],
            ),
          ),
          Container(
            width: 400,
            height: 70,
            margin: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0)),
            child: Stack(
              children: [
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "J.W Black - ",
                          style: Constants.regularHeading,
                        ),
                        Text(
                          "Cantidad: " + "5",
                          style: TextStyle(fontSize: 18),
                        ),
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
                        Text(
                          "Sprite - ",
                          style: Constants.regularHeading,
                        ),
                        Text(
                          "Cantidad: " + "24",
                          style: TextStyle(fontSize: 18),
                        ),
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
                        Text(
                          "CocaCola - ",
                          style: Constants.regularHeading,
                        ),
                        Text(
                          "Cantidad: " + "24",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Image.asset(
                  'assets/caja.png',
                  height: 30,
                  width: 30,
                  color: Colors.orange[300],
                ),
                Text(" Detalles del Pedido", style: Constants.boldHeading)
              ],
            ),
          ),
          Container(
            width: 400,
            height: 90,
            margin: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0)),
            child: Stack(
              children: [
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Fecha de Compra: ",
                          style: Constants.regularHeading,
                        ),
                        Text(
                          "19/11/2020",
                          style: TextStyle(fontSize: 18),
                        ),
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
                        Image.asset(
                          'assets/entrega.png',
                          height: 30,
                          width: 30,
                        ),
                        Text(
                          "Pendiente",
                          style: TextStyle(
                              fontSize: 18, color: Colors.orange[300]),
                        ),
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
                        Text(
                          "Pago: ",
                          style: Constants.regularHeading,
                        ),
                        Text(
                          "No pagado",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  top: 66,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Total: ",
                          style: Constants.regularHeading,
                        ),
                        Text(
                          "\$8000",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
