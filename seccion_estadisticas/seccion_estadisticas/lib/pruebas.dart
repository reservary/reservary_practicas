import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class Pruebas extends StatelessWidget {
  const Pruebas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pruebas')),
      body: Column(
        children: [
          // SizedBox(
          //   height: 500,
          //   width: 900,
          //   child: Chart(
          //     data: [
          //       {'genre': 'Sports', 'sold': 275},
          //       {'genre': 'Strategy', 'sold': 115},
          //       {'genre': 'Action', 'sold': 120},
          //       {'genre': 'Shooter', 'sold': 350},
          //       {'genre': 'Other', 'sold': 150},
          //     ],
          //     variables: {
          //       'genre': Variable(
          //         accessor: (Map map) => map['genre'] as String,
          //       ),
          //       'sold': Variable(accessor: (Map map) => map['sold'] as num),
          //     },
          //     transforms: [Proportion(variable: 'sold', as: 'percent')],
          //     marks: [
          //       IntervalMark(
          //         position: Varset('genre') * Varset('percent'),
          //         //modifiers: [StackModifier()],
          //         label: LabelEncode(
          //           encoder: (tuple) => Label(tuple['genre'].toString()),
          //         ),
          //         shape: ShapeEncode(
          //           value: RectShape(
          //             borderRadius: BorderRadius.all(Radius.circular(10)),
          //           ),
          //         ),
          //         color: ColorEncode(
          //           variable: 'genre',
          //           values: [
          //             Color(0xFF00FF95),
          //             Color(0xFF02F7F7),
          //             Color(0xFFF7F702),
          //             Color(0xFF000000),
          //             Color(0xFFF70202),
          //           ],
          //         ),
          //         elevation: ElevationEncode(value: 5),
          //         size: SizeEncode(value: 200),
          //       ),
          //     ],
          //     coord: PolarCoord(startRadius: 0.1, endRadius: 1),
          //   ),
          //),
          // SizedBox(
          //   height: 500,
          //   width: 900,
          //   child: Chart(
          //     data: [
          //       {'genre': 'Sports', 'sold': 275},
          //       {'genre': 'Strategy', 'sold': 115},
          //       {'genre': 'Action', 'sold': 120},
          //       {'genre': 'Shooter', 'sold': 350},
          //       {'genre': 'Other', 'sold': 150},
          //     ],
          //     variables: {
          //       'genre': Variable(
          //         accessor: (Map map) => map['genre'] as String,
          //       ),
          //       'sold': Variable(accessor: (Map map) => map['sold'] as num),
          //     },
          //     marks: [IntervalMark(
          //       label: LabelEncode(
          //         encoder: (tuple) => Label(tuple['sold'].toString()),

          //       ),
          //       gradient: GradientEncode(
          //         value: LinearGradient(
          //           colors: [
          //             Color.fromARGB(255, 195, 213, 253),
          //             Color.fromARGB(255, 146, 179, 248),
          //             Color.fromARGB(255, 116, 158, 250),
          //             Color.fromARGB(255, 106, 151, 248),
          //             Color.fromARGB(255, 5, 81, 247),
          //           ],
          //         ),
          //       ),
          //     )],
          //     coord : RectCoord(
          //       transposed: true,
          //     ),
          //     axes: [
          //       Defaults.horizontalAxis,
          //       Defaults.verticalAxis,
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 500,
          //   width: 900,
          //   child: Chart(
          //     data: [
          //       {'genre': 'Sports', 'sold': 275},
          //       {'genre': 'Strategy', 'sold': 115},
          //       {'genre': 'Action', 'sold': 120},
          //       {'genre': 'Shooter', 'sold': 350},
          //       {'genre': 'Other', 'sold': 150},
          //     ],
          //     variables: {
          //       'genre': Variable(
          //         accessor: (Map map) => map['genre'] as String,
          //       ),
          //       'sold': Variable(accessor: (Map map) => map['sold'] as num),
          //     },
          //     marks: [
          //       IntervalMark(
          //         label: LabelEncode(
          //           encoder: (tuple) => Label(tuple['genre'].toString()),
          //         ),
          //         color: ColorEncode(
          //           variable: 'genre',
          //           values: [
          //             Color(0xFF00FF95),
          //             Color(0xFF02F7F7),
          //             Color(0xFFF7F702),
          //             Color(0xFF000000),
          //             Color(0xFFF70202),
          //           ],
          //         ),
          //       ),
          //     ],
          //     coord: PolarCoord(transposed: true, startAngle: 0),
          //     axes: [Defaults.radialAxis..label = null, Defaults.circularAxis],
          //   ),
          //),
        ],
      ),
    );
  }
}
