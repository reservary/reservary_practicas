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
                      child: SizedBox(
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
                      child: SizedBox(
                        height: 300,
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
                          marks: [LineMark()],
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
                      child: SizedBox(
                        height: 300,
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
                          transforms: [
                            Proportion(
                              variable: 'sold',
                              as: 'percent',
                            ), //transforma los valores a porcentajes
                          ],
                          marks: [
                            IntervalMark(
                              position: Varset('percent') / Varset('genre'),
                              modifiers: [
                                StackModifier(),
                              ], //acumula los valores en vez de sobreponerlos
                              color: ColorEncode(
                                variable: 'genre',
                                values: [
                                  Color.fromARGB(255, 0, 255, 149),
                                  Color(0xFF02F7F7),
                                  Color(0xFFF7F702),
                                  Color(0xFFDCE2DE),
                                  Color(0xFFF70202),
                                ],
                              ),
                            ),
                          ],
                          coord: PolarCoord(dimCount: 1, transposed: true),
                        ),
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
                      child: SizedBox(
                        
                        height: 300,
                        width: 400,
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
                          transforms: [
                            Proportion(variable: 'sold', as: 'percent'),
                          ],
                          marks: [
                            IntervalMark(
                              position: Varset('genre') * Varset('percent'),
                              modifiers: [StackModifier()],
                              label: LabelEncode(
                                encoder:
                                    (tuple) => Label(tuple['genre'].toString()),
                              ),
                              shape: ShapeEncode(
                                value: RectShape(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              color: ColorEncode(
                                variable: 'genre',
                                values: [
                                  Color.fromARGB(255, 0, 255, 149),
                                  Color(0xFF02F7F7),
                                  Color(0xFFF7F702),
                                  Color(0xFF000000),
                                  Color(0xFFF70202),
                                ],
                              ),
                              elevation: ElevationEncode(value: 5),
                              size: SizeEncode(value: 200),
                            ),
                          ],
                          coord: PolarCoord(startRadius: 0.1),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 300,
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
                          marks: [
                            IntervalMark(
                              label: LabelEncode(
                                encoder:
                                    (tuple) => Label(tuple['sold'].toString()),
                              ),
                              gradient: GradientEncode(
                                value: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 195, 213, 253),
                                    Color.fromARGB(255, 146, 179, 248),
                                    Color.fromARGB(255, 116, 158, 250),
                                    Color.fromARGB(255, 106, 151, 248),
                                    Color.fromARGB(255, 5, 81, 247),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          coord: RectCoord(transposed: true),
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
                      child: SizedBox(
                        height: 300,
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
                          
                          marks: [
                            IntervalMark(
                              label: LabelEncode(
                                encoder:
                                    (tuple) => Label(tuple['genre'].toString()),
                              ),
                              color: ColorEncode(
                                variable: 'genre',
                                values: [
                                  Color(0xFF00FF95),
                                  Color(0xFF02F7F7),
                                  Color(0xFFF7F702),
                                  Color(0xFF000000),
                                  Color(0xFFF70202),
                                ],
                              ),
                            ),
                          ],
                          coord: PolarCoord(
                            transposed: true, 
                            startAngle: 0,
                          ),
                          axes: [
                            Defaults.radialAxis..label = null,
                            Defaults.circularAxis,
                          ],
                        ),
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
