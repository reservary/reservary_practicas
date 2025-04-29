import 'package:flutter/material.dart';

class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //no puede ser const si tiene una funcion
      children: [
        Spacer(),
        ElevatedButton(
          onPressed: () {
            print("Pulsado");
          },
          child: Text("Soy un boton :)"),
          onLongPress: () {
            print("Pulsadooooooooo");
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.amberAccent),
          ),
        ),
        OutlinedButton(onPressed: null, child: Text("OutlinedButton")),
        TextButton(onPressed: null, child: Text("TextButton")),
        FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
        IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
        Spacer(),
      ],
    );
  }
}
