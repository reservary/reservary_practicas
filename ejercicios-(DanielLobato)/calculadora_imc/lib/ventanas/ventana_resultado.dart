import 'package:calculadora_imc/nucleo/app_colores.dart';
import 'package:calculadora_imc/nucleo/text_styles.dart';
import 'package:calculadora_imc/ventanas/ventana_home.dart';
import 'package:flutter/material.dart';

class VentanaResultado extends StatelessWidget {
  final int peso;
  final double altura;


  const VentanaResultado({super.key, required this.peso, required this.altura});

  @override
  Widget build(BuildContext context) {
    double alturaMetros = altura / 100;
    double imc = peso / (alturaMetros * alturaMetros);
    return Scaffold(
      backgroundColor: AppColores.fondo,
      appBar: AppBar(
        title: Text("Resultado"),
        backgroundColor: AppColores.fondoComponentes,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            
            Text("Tu resultado", style: TextStyles.numeros,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  
                  decoration: BoxDecoration(
                    color: AppColores.fondoComponentes,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(getTituloByImc(imc),style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: getColorByImc(imc)),),
                      Text(imc.toStringAsFixed(2), style: TextStyles.numeros,),
                      Text(getDescripcionByImc(imc),style: TextStyle(fontSize: 15, color: Colors.white),),
                    ],
                  ),
                  ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColores.componenteSeleccionado),
                  
                  ),
                  child: Text("Finalizar", style: TextStyle(color: Colors.white),),
                  ),
              ),
            ),
              
          ],

        ),
      ),
         
    );
  }
  Color getColorByImc(double imc){
    return switch(imc){
       < 18.5 => Colors.blue,
       < 24.9 => Colors.green,
       < 29.9 => Colors.orange,
       _ => Colors.red
        
    };
  }

  String getTituloByImc(double imc){
    return switch(imc){
      < 18.5 => "Bajo",
      < 24.9 => "Normal",
      < 29.9 => "Sobrepeso",
      _ => "Obeso"
    };
  }

  String getDescripcionByImc(double imc){
    return switch(imc){
      < 18.5 => "Tienes un peso bajo",
      < 24.9 => "Tienes un peso normal",
      < 29.9 => "Tienes un peso sobrepeso",
      _ => "Tienes un peso obeso"
    };
  }
}
