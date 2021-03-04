import 'package:flutter/material.dart';

class ImagenSwep extends StatefulWidget {
  final imagenList;
  ImagenSwep({this.imagenList});

  @override
  _ImagenSwepState createState() => _ImagenSwepState();
}

class _ImagenSwepState extends State<ImagenSwep> {

  int _selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num){
              setState(() {
                _selectedImage = num;
              });
            },
              children: [
          for(var i=0;i< widget.imagenList.length;i++)
          Container(
            child: Image.network(
              "${widget.imagenList[i]}",
              fit: BoxFit.cover,
            ),
     ),
              ],
    ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i=0;i< widget.imagenList.length;i++)
                  AnimatedContainer(
                    duration: Duration(
                      milliseconds: 300
                    ),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0
                    ),
                    width: _selectedImage==i?35.0:10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0)
                    ),

                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
