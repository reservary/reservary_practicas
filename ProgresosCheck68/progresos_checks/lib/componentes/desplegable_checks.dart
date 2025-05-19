import 'package:flutter/material.dart';
import 'package:progresos_checks/datos/post_model_check.dart';
import 'package:progresos_checks/nucleo/app_colores.dart';
import 'package:progresos_checks/nucleo/estilos_texto.dart';

class DesplegableChecks extends StatefulWidget {
  final String titulo;
  final List<Check> elementos;
  final Function(List<Check>) onSelectionChanged;

  const DesplegableChecks({
    Key? key,
    required this.titulo,
    required this.elementos,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<DesplegableChecks> createState() => _DesplegableChecksState();
}

class _DesplegableChecksState extends State<DesplegableChecks> {
  bool mostrarDesplegable = false;
  Set<int> idsSeleccionados = {};

  void toggleSeleccion(Check check, bool? isSelected) {
    setState(() {
      if (isSelected == true) {
        idsSeleccionados.add(check.postId);
      } else {
        idsSeleccionados.remove(check.postId);
      }
    });
    widget.onSelectionChanged(widget.elementos
        .where((c) => idsSeleccionados.contains(c.postId))
        .toList());
  }

  void toggleMarcarTodos(bool? value) {
    setState(() {
      if (value == true) {
        idsSeleccionados =
            widget.elementos.map((c) => c.postId).toSet();
      } else {
        idsSeleccionados.clear();
      }
    });
    widget.onSelectionChanged(widget.elementos
        .where((c) => idsSeleccionados.contains(c.postId))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    final todosMarcados =
        idsSeleccionados.length == widget.elementos.length;

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
                  mostrarDesplegable
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
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
                    value: todosMarcados,
                    onChanged: toggleMarcarTodos,
                    title: Text("Marcar todos", style: EstilosTexto.checks),
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                  ...widget.elementos.map(
                    (check) => CheckboxListTile(
                      value: idsSeleccionados.contains(check.postId),
                      onChanged: (value) => toggleSeleccion(check, value),
                      title: Text(check.postTitle, style: EstilosTexto.checks),
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
