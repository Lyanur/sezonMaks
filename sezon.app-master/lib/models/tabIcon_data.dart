import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.title = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  String title;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/bottom/1_off.png',
      selectedImagePath: 'assets/bottom/1.png',
      title: 'Магазин',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom/2_off.png',
      selectedImagePath:  'assets/bottom/2.png',
      title: 'Акции',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom/3_off.png',
      selectedImagePath: 'assets/bottom/3.png',
      title: 'Карта',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom/4_off.png',
      selectedImagePath: 'assets/bottom/4.png',
      title: 'Профиль',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
