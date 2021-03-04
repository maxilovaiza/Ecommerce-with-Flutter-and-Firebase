import 'package:flutter/material.dart';

import '../constants.dart';

class Pedido1 extends StatefulWidget {
  @override
  _Pedido1State createState() => _Pedido1State();
}

class _Pedido1State extends State<Pedido1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            title: Text(
              "Pedido 1",
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
                  color: Colors.green[300],
                ),
                Text(" Productos Entregados", style: Constants.boldHeading)
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
                          "Dada N° 1 - ",
                          style: Constants.regularHeading,
                        ),
                        Text(
                          "Cantidad: " + "20",
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
                //Telefono
                Positioned(
                  left: 0.0,
                  top: 44,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "FernetBranca - ",
                          style: Constants.regularHeading,
                        ),
                        Text(
                          "Cantidad: " + "8",
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
                  color: Colors.green[300],
                ),
                Text(" Detalles de envio", style: Constants.boldHeading)
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
                          "Fecha de Entrega: ",
                          style: Constants.regularHeading,
                        ),
                        Text(
                          "20/11/2020",
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
                          'assets/enviado.png',
                          height: 30,
                          width: 30,
                        ),
                        Text(
                          " Entregado",
                          style:
                              TextStyle(fontSize: 18, color: Colors.green[300]),
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
                          "En Efecctivo",
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
                          "\$5000",
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
