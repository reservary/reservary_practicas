import 'package:flutter/material.dart';
import 'package:progresos_checks/nucleo/app_colores.dart';
import 'package:progresos_checks/nucleo/estilos_texto.dart';

class DesplegableMedidas extends StatefulWidget {
  final String titulo;
  final List<String> medidasDisponibles;
  final Function(List<String>) onSelectionChanged;

  const DesplegableMedidas({
    Key? key,
    required this.titulo,
    required this.medidasDisponibles,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<DesplegableMedidas> createState() => _DesplegableMedidasState();
}

class _DesplegableMedidasState extends State<DesplegableMedidas> {
  bool mostrarDesplegable = false;
  Set<String> seleccionadas = {};

  void toggleSeleccion(String medida, bool? isSelected) {
    setState(() {
      if (isSelected == true) {
        seleccionadas.add(medida);
      } else {
        seleccionadas.remove(medida);
      }
    });
    widget.onSelectionChanged(seleccionadas.toList());
  }

  void toggleMarcarTodas(bool? value) {
    setState(() {
      if (value == true) {
        seleccionadas = widget.medidasDisponibles.toSet();
      } else {
        seleccionadas.clear();
      }
    });
    widget.onSelectionChanged(seleccionadas.toList());
  }

  @override
  Widget build(BuildContext context) {
    final todasMarcadas =
        seleccionadas.length == widget.medidasDisponibles.length;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => setState(() => mostrarDesplegable = !mostrarDesplegable),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.titulo, style: EstilosTexto.titulos),
                const SizedBox(width: 8),
                Icon(
                  mostrarDesplegable ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: AppColores.componentes,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (mostrarDesplegable)
          Container(
            decoration: BoxDecoration(
              color: AppColores.fondoComponentes,
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(maxHeight: 300),
            child: Scrollbar(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CheckboxListTile(
                    value: todasMarcadas,
                    onChanged: toggleMarcarTodas,
                    title: Text("Marcar todas", style: EstilosTexto.checks),
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                  ...widget.medidasDisponibles.map(
                    (medida) => CheckboxListTile(
                      value: seleccionadas.contains(medida),
                      onChanged: (value) => toggleSeleccion(medida, value),
                      title: Text(medida, style: EstilosTexto.checks),
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
