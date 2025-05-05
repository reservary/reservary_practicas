import 'package:ejercicio8/core/colores_app.dart';
import 'package:ejercicio8/core/estilos.dart';
import 'package:flutter/material.dart';

class AlturaSelector extends StatefulWidget {
  final double selectedAltura;
  final Function(double) onAlturaChange;
  const AlturaSelector({
    super.key,
    required this.selectedAltura,
    required this.onAlturaChange,
  });

  @override
  State<AlturaSelector> createState() => _AlturaSelectorState();
}

class _AlturaSelectorState extends State<AlturaSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: ColoresApp.backgroundComponent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("ALTURA", style: Estilos.bodyText),
            ),
            Text(
              "${widget.selectedAltura.toStringAsFixed(0)} cm",
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: widget.selectedAltura,
              onChanged: (newAltura) {
                widget.onAlturaChange(newAltura);
              },
              min: 150,
              max: 220,
              divisions: 70,
              label: "${widget.selectedAltura.toStringAsFixed(0)} cm",
              activeColor: ColoresApp.primary,
            ),
          ],
        ),
      ),
    );
  }
}
