import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class HealthBar extends StatelessWidget {
  final int percentage;
  HealthBar({this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Disponibilidad',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 25),
          percentage > 1
              ? Container()
              : Align(
                alignment: Alignment.centerLeft,
                  child: Text(
                    'Sin fondos',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: Colors.red
                            // fontSize: 25,
                            ),
                  ),
                ),
          SizedBox(height: 5),
          FAProgressBar(
            currentValue: percentage > 1 ? percentage : 0,
            size: 25,
            maxValue: 100,
            backgroundColor: percentage < 1 ? Colors.grey : Colors.white,
            progressColor: percentage >= 70
                ? Colors.lightGreen
                : percentage <= 30 ? Colors.red : Colors.deepOrange,
            animatedDuration: const Duration(milliseconds: 300),
            direction: Axis.horizontal,
            verticalDirection: VerticalDirection.up,
            displayText: '%',
          ),
        ],
      ),
    );
  }
}
