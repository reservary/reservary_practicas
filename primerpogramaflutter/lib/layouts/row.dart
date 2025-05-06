import 'package:flutter/material.dart';

class RowExample extends StatelessWidget {
  const RowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 86),
      child: SizedBox(
        //si se quiere solo cambiar el tamaño
        height: double.infinity,
        child: const Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //Spacer(), //ocupar espacio
            Text('Hola'),
            //Spacer(),
            Expanded(child: Text('Hola2')),
            Text('Hola'),
            Text('Hola'),
            Text('Hola'),
          ],
        ),
      ),
    );
  }
}
