import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
      show: true,
      leftTitles: SideTitles(
          showTitles: true,
          reservedSize: 15,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 6),
          getTitles: (value) {
            switch (value.toInt()) {
              case 20:
                return '20kg';
              case 60:
                return '60kg';
              case 100:
                return '100kg';
              case 140:
                return '140kg';
              case 180:
                return '180kg';
            }
            return '';
          }),
      bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 10),
          getTitles: (value) {
            print(value);
            switch (value.toInt()) {
              case 11:
                return 'Under';
              case 18:
                return 'Normal';
              case 24:
                return 'Over';
              case 30:
                return 'Obesity';
            }
            return '';
          }));
}
