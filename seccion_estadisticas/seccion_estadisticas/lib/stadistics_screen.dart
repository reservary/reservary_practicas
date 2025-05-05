import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class StadisticsScreen extends StatefulWidget {
  const StadisticsScreen({super.key});

  @override
  State<StadisticsScreen> createState() => _StadisticsScreenState();
}

class _StadisticsScreenState extends State<StadisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Estadisticas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.blue,
                        height: 200,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Reservas totales:'),
                            Text('Facturacion total:'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: const Color.fromARGB(255, 2, 2, 2),
                        height: 200,
                        width: 200,
                        child: Chart(
                          data: [
                            {'genre': 'Sports', 'sold': 275},
                            {'genre': 'Strategy', 'sold': 115},
                            {'genre': 'Action', 'sold': 120},
                            {'genre': 'Shooter', 'sold': 350},
                            {'genre': 'Other', 'sold': 150},
                          ],
                          variables: {
                            'genre': Variable(
                              accessor: (Map map) => map['genre'] as String,
                            ),
                            'sold': Variable(
                              accessor: (Map map) => map['sold'] as num,
                            ),
                          },
                          marks: [IntervalMark()],
                          coord: PolarCoord(
                            color: Color.fromRGBO(255, 254, 254, 1),
                          ),
                          axes: [
                            Defaults.horizontalAxis,
                            Defaults.verticalAxis,
                          ],

                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.green,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.green,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.blue,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.red,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
