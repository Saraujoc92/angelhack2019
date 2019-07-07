import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class HealthBar extends StatelessWidget {
  final int percentage;
  HealthBar({this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FAProgressBar(
        currentValue: percentage,
        size: 25,
        maxValue: 100,
        backgroundColor: Colors.white,
        progressColor: percentage >= 70
            ? Colors.lightGreen
            : percentage <= 30 ? Colors.red : Colors.orange,
        animatedDuration: const Duration(milliseconds: 300),
        direction: Axis.horizontal,
        verticalDirection: VerticalDirection.up,
        displayText: '%',
      ),
    );
  }
}
