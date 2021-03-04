import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
 static const kBackgroundColor = Color(0xFFF1EFF1);
 static const kPrimaryColor = Color(0xFF035AA6);
 static const kSecondaryColor = Color(0xFFFFA41B);
 static const kTextColor = Color(0xFF000839);
 static const kTextLightColor = Color(0xFF747474);
 static const kBlueColor = Color(0xFF40BAD5);

 static const kDefaultPadding = 20.0;

// our default Shadow
 static const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
 );
 static const regularHeading =
 TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);
 static const regularHeadingP =
 TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.red);
 static const boldHeading =
 TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);
 static const textDark =
 TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);
 static const bold2 =
 TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);
 static const boldHeadingw =
 TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.white);
 static const boldHeadingR =
 TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: Color(0xFFB71C1C));
}