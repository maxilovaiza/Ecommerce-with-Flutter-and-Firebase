import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Services/services.dart';
import 'package:flutter/material.dart';


class TotalPedidosWidget extends StatefulWidget {
  final List<DocumentSnapshot> documentos;
  final int total;


  TotalPedidosWidget({Key key, this.documentos})
      :
        total = documentos.map((doc) => doc.data()['cantidad'])
            .fold(0, (a, b) => 1 + b),
        super(key: key);

  @override
  _TotalPedidosWidgetState createState() => _TotalPedidosWidgetState();
}

class _TotalPedidosWidgetState extends State<TotalPedidosWidget> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  Future incrementar(int cantidad){
    return _firebaseServices.pedidoRef.doc(_firebaseServices.getUser()).collection("cantidad").doc("cantidad").set({
      "cantidad":cantidad
    });
  }
  Future incrementarPedido(int nropedido){
    return _firebaseServices.pedidoRef.doc(_firebaseServices.getUser()).collection("Pedido "+nropedido.toString()).add({});
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _expenses(),
      ],
    );

  }

  Widget _expenses() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(

          onTap: () async {
            incrementar(widget.total);
            incrementarPedido(widget.total);

          },
          child:


          Container(
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

      ],
    );
  }
}