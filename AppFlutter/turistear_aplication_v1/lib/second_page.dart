import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página en Construcción'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'En Construcción',
              style: TextStyle(fontSize: 24.0),
            ),
            Icon(
              Icons.build,
              size: 48.0,
            ),
          ],
        ),
      ),
    );
  }
}
