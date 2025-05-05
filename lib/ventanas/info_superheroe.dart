import 'package:flutter/material.dart';
import 'package:segundoejercicioflutter/contenidos/modelo/detalles_superheroes.dart';

class VentanaDetallesSuperheroe extends StatelessWidget {
  final SuperheroDetailResponse superhero;

  const VentanaDetallesSuperheroe({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(superhero.name)),
      body: Column(
        children: [
          Image.network(
            superhero.url,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Text(
            superhero.name.toUpperCase(),
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(superhero.realName, style: TextStyle(fontSize: 20)),

          SizedBox(
            width: double.infinity,
            height: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: double.parse(superhero.powerstats.intelligence),
                      color: getColorByValue(
                        double.parse(superhero.powerstats.intelligence),
                      ),
                    ),
                    Text(
                      superhero.powerstats.intelligence,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("Intelligence", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: double.parse(superhero.powerstats.strength),
                      color: getColorByValue(
                        double.parse(superhero.powerstats.strength),
                      ),
                    ),
                    Text(
                      superhero.powerstats.strength,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("Strength", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: double.parse(superhero.powerstats.speed),
                      color: getColorByValue(
                        double.parse(superhero.powerstats.speed),
                      ),
                    ),
                    Text(
                      superhero.powerstats.speed,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("Speed", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: double.parse(superhero.powerstats.durability),
                      color: getColorByValue(
                        double.parse(superhero.powerstats.durability),
                      ),
                    ),
                    Text(
                      superhero.powerstats.durability,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("Durability", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: double.parse(superhero.powerstats.power),
                      color: getColorByValue(
                        double.parse(superhero.powerstats.power),
                      ),
                    ),
                    Text(
                      superhero.powerstats.power,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("Power", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: double.parse(superhero.powerstats.combat),
                      color: getColorByValue(
                        double.parse(superhero.powerstats.combat),
                      ),
                    ),
                    Text(
                      superhero.powerstats.combat,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("Combat", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color getColorByValue(double value) {
    if (value < 20) {
      return Colors.red;
    } else if (value < 35) {
      return Colors.orange;
    } else if (value < 50) {
      return Colors.yellow;
    } else if (value < 65) {
      return Colors.greenAccent;
    } else {
      return Colors.green;
    }
  }
}
