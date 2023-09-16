import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FriendshipBar extends StatelessWidget {
  final double percent;

  const FriendshipBar(String s, {super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      percent: percent,
      width: 200.0,
      animation: true,
      animationDuration: 300,
      lineHeight: 10.0,
      trailing: const Text('❤️'),
      barRadius: const Radius.circular(10),
    );
  }
}
