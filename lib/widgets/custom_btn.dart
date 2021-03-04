import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  CustomBtn({this.text,this.onPressed,this.outlineBtn,this.isLoading});
  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading??false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.white : Colors.red[900],
          border: Border.all(
              color: Colors.red[900],
              width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 24.0
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false:true,
                child: Center(
                  child: Text(
                  text ?? "Text",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: _outlineBtn ? Colors.red[900]: Colors.white,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

