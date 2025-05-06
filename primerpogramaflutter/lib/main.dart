import 'package:flutter/material.dart';
import 'package:primerpogramaflutter/components/button.dart';
import 'package:primerpogramaflutter/components/images.dart';
import 'package:primerpogramaflutter/components/textfield.dart';
import 'package:primerpogramaflutter/layouts/column.dart';
import 'package:primerpogramaflutter/layouts/row.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mi app"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.abc))
          ],
        ), // se quita el const para que se pueda ver appbar
        backgroundColor: Colors.amber,
        body: ImageExample(),
        floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add)),
      ),
    );
  }
}
