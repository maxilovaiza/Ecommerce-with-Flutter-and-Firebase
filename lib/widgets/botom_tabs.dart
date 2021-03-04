import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTabs;
  final Function(int) tabPress;
  BottomTabs({this.selectedTabs, this.tabPress});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTabs = 0;
  @override
  Widget build(BuildContext context) {
    _selectedTabs = widget.selectedTabs ?? 0;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.red[900].withOpacity(0.05),
                  spreadRadius: 1.0,
                  blurRadius: 30.0)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabsBtn(
              imagePath: "assets/casa.png",
              selected: _selectedTabs == 0 ? true : false,
              onPressed: () {
                widget.tabPress(0);
              },
            ),
            BottomTabsBtn(
              imagePath: "assets/catalogo.png",
              selected: _selectedTabs == 1 ? true : false,
              onPressed: () {
                widget.tabPress(1);
              },
            ),
            BottomTabsBtn(
              imagePath: "assets/me-gusta.png",
              selected: _selectedTabs == 2 ? true : false,
              onPressed: () {
                widget.tabPress(2);
              },
            ),
            BottomTabsBtn(
                imagePath: "assets/usuario.png",
                selected: _selectedTabs == 3 ? true : false,
                onPressed: () {
                  widget.tabPress(3);
                })
          ],
        ));
  }
}

class BottomTabsBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  BottomTabsBtn({this.imagePath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2.0))),
        padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
        child: Image(
          image: AssetImage(
            imagePath ?? "assets/ic_home.png",
          ),
          height: 22.0,
          width: 22.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
