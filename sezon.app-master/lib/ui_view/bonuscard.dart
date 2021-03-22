import '../main.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class BonusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 70,
      child: Image.asset("assets/images/bonuscard.png"),
    );
  }
}
