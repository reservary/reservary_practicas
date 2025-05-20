import 'package:flutter/material.dart';

class VentanaComparadorImagenes extends StatefulWidget {
  const VentanaComparadorImagenes({super.key});

  @override
  State<VentanaComparadorImagenes> createState() => _VentanaComparadorImagenesState();
}

class _VentanaComparadorImagenesState extends State<VentanaComparadorImagenes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Comparador Imagenes"),
        Row(
          children: [
            Column(
              children: [
                Text("Imagen 1:"),
                Image.asset('assets/imagenes/fuerte.png', width: 200,),
              ],
            ),
            Column(
              children: [
                Text("Imagen 2:"),
                Image.asset('assets/imagenes/gordo.png', width: 200,),
              ],
            )
          ],
        )
      ],
    );
  }
}