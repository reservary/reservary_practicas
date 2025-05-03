import 'package:ejercicio8/core/colores_app.dart';
import 'package:ejercicio8/core/estilos.dart';
import 'package:flutter/material.dart';

class NumeroSelector extends StatefulWidget {
  final String title;
  final int value;
  final Function() onDecrement;
  final Function() onIncrement;

  const NumeroSelector({
    super.key,
    required this.title,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  State<NumeroSelector> createState() => _NumeroSelectorState();
}

class _NumeroSelectorState extends State<NumeroSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColoresApp.backgroundComponent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(widget.title, style: Estilos.bodyText),
            Text(
              widget.value.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    widget.onDecrement();
                  },
                  shape: CircleBorder(),
                  backgroundColor: ColoresApp.primary,
                  child: Icon(Icons.remove, color: Colors.white),
                ),
                SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    widget.onIncrement();
                  },
                  shape: CircleBorder(),
                  backgroundColor: ColoresApp.primary,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
