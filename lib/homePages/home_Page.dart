import 'file:///E:/Ecommerce/e_commerce/lib/ConfigPages/Config.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/CatalogoPages/catalogo_tab.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/FavoritoPage/favorito_tab.dart';
import 'file:///E:/Ecommerce/e_commerce/lib/homePages/home_tab.dart';
import 'package:e_commerce/widgets/botom_tabs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  PageController _tabsPageController;
  int _selectedTabs = 0;
  String _homeScreenText = "";

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: PageView(
            controller: _tabsPageController,
            onPageChanged: (num) {
              setState(() {
                _selectedTabs = num;
              });
            },
            children: [HomeTab(), CatalogoTab(), FavoritoTab(), ConfigTab()],
          )),
          BottomTabs(
            selectedTabs: _selectedTabs,
            tabPress: (num) {
              _tabsPageController.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          ),
        ],
      )),
    );
  }
}
