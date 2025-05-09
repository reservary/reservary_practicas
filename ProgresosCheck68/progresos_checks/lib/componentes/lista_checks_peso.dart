import 'package:flutter/material.dart';
import 'package:progresos_checks/datos/post_model_check.dart';

class ListaChecksPeso extends StatefulWidget {
  final List<Check> todosLosChecks;
  final Set<Check> seleccionadosIniciales;
  final void Function(Set<Check>) onSeleccionChanged;

  const ListaChecksPeso({
    super.key,
    required this.todosLosChecks,
    required this.seleccionadosIniciales,
    required this.onSeleccionChanged,
  });

  @override
  State<ListaChecksPeso> createState() => _ListaChecksPesoState();
}

class _ListaChecksPesoState extends State<ListaChecksPeso> {
  late Set<Check> seleccionados;

  @override
  void initState() {
    super.initState();
    seleccionados = {...widget.seleccionadosIniciales};
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text("Seleccionar checks (${seleccionados.length})"),
        children: widget.todosLosChecks.map((check) {
          final seleccionado = seleccionados.contains(check);
          return CheckboxListTile(
            value: seleccionado,
            title: Text("Check ${check.checkWeight} kg - ${check.createdDate}"),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  seleccionados.add(check);
                } else {
                  seleccionados.remove(check);
                }
              });
              widget.onSeleccionChanged(seleccionados);
            },
          );
        }).toList(),
      ),
    );
  }
}

