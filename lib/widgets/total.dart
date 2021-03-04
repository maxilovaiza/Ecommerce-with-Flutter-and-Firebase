import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalWidget extends StatefulWidget {
  final List<DocumentSnapshot> documentos;
  final double total;

  TotalWidget({Key key, this.documentos})
      : total = documentos
            .map((doc) => doc.data()['Subprecio'])
            .fold(0.0, (a, b) => a + b),
        super(key: key);

  @override
  _TotalWidgetState createState() => _TotalWidgetState();
}

class _TotalWidgetState extends State<TotalWidget> {
  totalpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('total', widget.total);
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
        Text(
          "Total: " + "\$${widget.total.toStringAsFixed(2)}",
          textAlign: TextAlign.center,
          style: Constants.boldHeading,
        ),
      ],
    );
  }
}
