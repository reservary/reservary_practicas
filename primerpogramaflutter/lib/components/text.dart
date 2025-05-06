import 'package:flutter/material.dart';

class TextExample extends StatelessWidget {
  const TextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(),
        Text("Texto básico"),
        Text("Texto Grande", style: TextStyle(fontSize: 25)),
        Text(
          "Texto Grande",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.red,
          ),
        ),
        Text(
          "Texto curvado",
          style: TextStyle(
            color: Colors.blue,
            fontStyle: FontStyle.italic,
            fontSize: 25,
            backgroundColor: Colors.amber,
          ),
        ),
        Text(
          "Decorador",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
            fontSize: 25,
            decorationColor: Colors.deepOrangeAccent,
          ),
        ),
        Text(
          "Espacio entre letras",
          style: TextStyle(
            letterSpacing: 5,
            fontSize: 25,
          ),),
          Text(
          "Texto largo Texto largo Texto largo Texto largo Texto largo Texto largo Texto largo Texto largo Texto largo Texto largo Texto largo Texto largo",
          style: TextStyle(
            
            fontSize: 25,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,),
        Spacer(),
      ],
    );
  }
}
