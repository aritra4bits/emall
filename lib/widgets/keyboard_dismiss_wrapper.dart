import 'package:flutter/material.dart';

class KeyboardDismissWrapper extends StatelessWidget {
  final Widget child;
  const KeyboardDismissWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    unFocus(BuildContext context){
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
    return GestureDetector(
      onTapDown: (onTapDown) {
        unFocus(context);
      },
      onVerticalDragStart: (onDragStart) {
        unFocus(context);
      },
      onHorizontalDragStart: (onDragStart) {
        unFocus(context);
      },
      child: child,
    );
  }
}