import 'package:flutter/material.dart';

// EACH TAB BUTTON (UNIQUE) in the navigation on the bottom of each tab
class TabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  final String label;
  TabBtn({this.imagePath, this.selected, this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {

    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 28.0,
          horizontal: 24,
        ),
        decoration: BoxDecoration(

            border: Border(
              top: BorderSide(
                color: _selected ? Colors.redAccent : Colors.transparent,
                width: 2.0,
              ),
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(
                  imagePath ?? "assets/images/home_tap.png"
              ),
              width: 22.0,
              height: 22.0,
              color: _selected ? Colors.redAccent : Colors.black,
            ),
            Text(
                label,
            ),
          ],
        ),
      ),
    );
  }
}
