import 'package:flutter/material.dart';

class ColumnExample extends StatelessWidget {
  const ColumnExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      height: 300,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Hola'),
          Text('Hola'),
          Text('Hola'),
          Text('Hola'),
          Text('Hola'),
          Text('Hola'),
          Text('Hola'),
          Text('Hola'),
        ],
      ),
    );
  }
}
