import 'package:flutter/material.dart';

class Player {
  final id;
  final color;
  Image marker;

  Player(
      this.id,
      this.color,
      String asset,
      ): marker = Image.asset(asset);
}