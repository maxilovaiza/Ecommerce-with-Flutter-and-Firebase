import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class CustomInfo extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textImputAction;
  final bool isPassField;
  final TextInputType textimput;
  final TextCapitalization textCap;
  CustomInfo({this.hintText,this.onChanged,this.onSubmitted,this.focusNode,this.textImputAction,this.isPassField,this.textimput,this.textCap});
  @override
  Widget build(BuildContext context) {
    bool _isPassField = isPassField??false;
    TextInputType _textImput=textimput??TextInputType.text;
    TextCapitalization _textCap = textCap??TextCapitalization.sentences;

    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blueGrey)
      ),
      child: TextField(
        obscureText: _isPassField,
        textAlign: TextAlign.center,
        readOnly: true,
        enableSuggestions: true,
        textCapitalization: _textCap,
        keyboardType: _textImput,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textImputAction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "Hint Text...",
            contentPadding: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0
            )
        ),
        style: Constants.regularHeading,
      ),
    );
  }
}
