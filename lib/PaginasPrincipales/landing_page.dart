import 'file:///E:/Ecommerce/e_commerce/lib/homePages/home_Page.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/PaginasPrincipales/login_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initilization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initilization,
      builder: (context, snapshot) {
        //if snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error ${snapshot.error}"),
            ),
          );
        }
        //inicializacion con firebase
        if (snapshot.connectionState == ConnectionState.done) {
          //StreamBuilder chequea que haya un usuario iniciado
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              //if streamsnapshot has error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error ${streamSnapshot.error}"),
                  ),
                );
              }
              //Connection state active- Do the user login check inside the
              //if state
              if (streamSnapshot.connectionState == ConnectionState.active) {
                //Get the user
                User _user = streamSnapshot.data;
                //if the user is null, we're no logged in, head to loginpage
                if (_user == null) {
                  return LoginPage();
                } else {
                  //the user is login, head to homepage
                  return HomePage();
                }
              }
              //chequeando auth state
              return Scaffold(
                body: Center(),
              );
            },
          );
        }
        //conectando a firebase
        return Scaffold(
          body: Center(),
        );
      },
    );
  }
}
