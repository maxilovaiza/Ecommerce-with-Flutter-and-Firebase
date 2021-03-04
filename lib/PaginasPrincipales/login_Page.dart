import 'file:///E:/Ecommerce/e_commerce/lib/homePages/home_Page.dart';
import 'package:e_commerce/constants.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/PaginasPrincipales/register_page.dart';
import 'package:e_commerce/widgets/custom_btn.dart';
import 'package:e_commerce/widgets/custom_imput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Cerrar Dialogo"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  // Create a new user account
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    // Set the form to loading state
    setState(() {
      _loginFormLoading = true;
    });

    // Run the create account method
    String _loginFeedback = await _loginAccount();

    // If the string is not null, we got error while create account.
    if (_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  // Default Form Loading State
  bool _loginFormLoading = false;

  // Form Input Field Values
  String _loginEmail = "";
  String _loginPassword = "";

  // Focus Node for input fields
  FocusNode _passwordFocusNode;
  TextCapitalization _imputCap = TextCapitalization.none;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  googlesingin() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: Text(
                      "Bienvenido a E-commerceApp,\nInicia sesion",
                      textAlign: TextAlign.center,
                      style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0, bottom: 60.0),
                    child: Column(
                      children: [
                        CustomImput(
                          hintText: "Email...",
                          textCap: _imputCap,
                          onChanged: (value) {
                            _loginEmail = value;
                          },
                          onSubmitted: (value) {
                            _passwordFocusNode.requestFocus();
                          },
                          textImputAction: TextInputAction.next,
                        ),
                        CustomImput(
                          hintText: "Contraseña...",
                          onChanged: (value) {
                            _loginPassword = value;
                          },
                          focusNode: _passwordFocusNode,
                          isPassField: true,
                          onSubmitted: (value) {
                            _submitForm();
                          },
                        ),
                        CustomBtn(
                          text: "Iniciar Sesion",
                          onPressed: () {
                            _submitForm();
                          },
                          isLoading: _loginFormLoading,
                        ),
                        GoogleSignInButton(
                          onPressed: () {
                            googlesingin();
                          },
                          borderRadius: 12.0,
                          text: "Continuar con Google",
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16.0,
                    ),
                    child: CustomBtn(
                      text: "Crear Cuenta",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      outlineBtn: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
