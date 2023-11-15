import 'package:flutter/material.dart';

class SizeUtils {
  final BuildContext context;
  final TabController tabController;
  SizeUtils(this.context, this.tabController);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get tabWidth => screenWidth / tabController.length;
  double get leftPosition =>
      (tabController.index + tabController.offset) * tabWidth;
  double get rightPosition =>
      (tabController.length -
          (tabController.index + tabController.offset + 1)) *
      tabWidth;
  double get marginValue => screenWidth / (tabController.length * 2) - 4;
}

double calculateMargin(double value, double desired) {
  value = value.abs();
  return value <= 0.5 ? (value * 2 * desired) : ((1 - value) * 2 * desired);
}
