import 'package:flutter/material.dart';
import '../../core/estilosyfuentes.dart';
import '../../core/tema.dart';

class NumberSelector extends StatefulWidget {
  final String title;
  final int value;
  final Function() onDecrement;
  final Function() onIncrement;

  const NumberSelector(
      {super.key,
      required this.title,
      required this.value,
      required this.onDecrement,
      required this.onIncrement});

  @override
  State<NumberSelector> createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundComponent,
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(widget.title, style: TextStyles.bodyText),
            Text(widget.value.toString(),
                style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 38,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    widget.onDecrement();
                  },
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.remove, color: Colors.white),
                ),
                SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    widget.onIncrement();
                  },
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}