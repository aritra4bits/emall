import 'package:flutter/material.dart';

class NetworkErrorPage extends StatelessWidget {
  const NetworkErrorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/icons/no-internet.png'),
      ),
    );
  }
}