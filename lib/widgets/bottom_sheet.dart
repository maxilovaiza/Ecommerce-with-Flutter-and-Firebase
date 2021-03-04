import 'package:flutter/material.dart';

class BottomSheetU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0))),
        child: Column(
          children: [
            Text(
              "Hola",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
