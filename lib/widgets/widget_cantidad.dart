import 'package:flutter/material.dart';
class CantidadProducto extends StatefulWidget {
  final String productoId;

  CantidadProducto({this.productoId});


  @override
  _CantidadProductoState createState() => _CantidadProductoState();
}

class _CantidadProductoState extends State<CantidadProducto> {
  int cantidad = 1;
  final int limitSelectQuantity;
  final int value;
  final double width;
  final double height;
  final Function onChanged;
  final Color color;
  _CantidadProductoState({this.value, this.width = 180.0, this.height = 42.0, this.limitSelectQuantity = 100, this.color, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),
        borderRadius: BorderRadius.circular(3),
      ),
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  cantidad--;
                  if(cantidad<1){
                    cantidad = 1;
                  }
                });
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  cantidad.toString(),
                  style: TextStyle(fontSize: 15, color: color),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    cantidad++;
                    print( cantidad);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
