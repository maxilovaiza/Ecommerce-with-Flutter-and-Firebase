import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getUser() {
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("Users");
  final CollectionReference productRef =
      FirebaseFirestore.instance.collection("Productos");
  final CollectionReference pedidoRef =
      FirebaseFirestore.instance.collection("Pedidos");
}
