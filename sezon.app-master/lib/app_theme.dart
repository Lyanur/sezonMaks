import 'package:flutter/material.dart';

class SezonAppTheme {
  SezonAppTheme._();
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteEb = Color(0xFFebebeb);
  static const Color background = Color(0xFFFFFFFF);
  static const Color sezonMain = Color(0xFF6a1b9a);

  static const Color red = Color(0xFFec4235);
  static const Color blue = Color(0xFF4285f6);
  static const Color green = Color(0xFF34a855);
  static const Color yellow = Color(0xFFfabc05);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Helios';



  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}

class AppStyle {
  static const TextStyle tsMenuMobile = TextStyle(
    fontFamily: 'Museo',
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  static const TextStyle quizTextBig = TextStyle(
    fontFamily: 'Museo',
    fontWeight: FontWeight.w600,
    fontSize: 28,
  );
  static const TextStyle quizText = TextStyle(
    fontFamily: 'Museo',
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static const TextStyle quizTextYou = TextStyle(
      fontFamily: 'Museo',
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: SezonAppTheme.red);
  static const TextStyle blocName = TextStyle(
      fontFamily: 'Museo',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1);
  static const TextStyle wineSelection = TextStyle(
      fontFamily: 'Museo',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.5);
  static const TextStyle bottomText = TextStyle(
      fontFamily: 'Museo',
      fontWeight: FontWeight.w400,
      fontSize: 13,
      height: 1.5);
  static const TextStyle alreadyCart = TextStyle(
      fontFamily: 'Museo',
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Colors.white);
  static const TextStyle addCart = TextStyle(
    fontFamily: 'Museo',
    fontWeight: FontWeight.w600,
    fontSize: 13,
  );
  static const TextStyle newWine = TextStyle(
      fontFamily: 'Museo',
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 1.5);
  static const TextStyle discount = TextStyle(
      fontFamily: 'Museo',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.white);
  static const TextStyle price = TextStyle(
      fontFamily: 'Museo',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.4);
  static const TextStyle numberBottles = TextStyle(
      fontFamily: 'Museo',
      fontWeight: FontWeight.w300,
      fontSize: 12,
      height: 1.8);
  static const TextStyle numberBottlesGrey =
  TextStyle(fontFamily: 'Museo', fontSize: 12, color: SezonAppTheme.dark_grey);
  static const TextStyle subscriptionName =
  TextStyle(fontFamily: 'Museo', fontSize: 16, fontWeight: FontWeight.w600);
  static const TextStyle mountNameBrend =
  TextStyle(fontFamily: 'Museo', fontSize: 13, fontWeight: FontWeight.w300);
  static const TextStyle flagText = TextStyle(
      fontFamily: 'Museo',
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.white);
  static const TextStyle priceChange = TextStyle(
    fontFamily: 'Museo',
    fontSize: 16,
  );
  static const TextStyle cartQuantity = TextStyle(
      fontFamily: 'Museo',
      fontSize: 9,
      fontWeight: FontWeight.w600,
      color: Colors.white);
  static const TextStyle quizTextRed = TextStyle(
      fontFamily: 'Museo',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: SezonAppTheme.red);
  static const TextStyle styleTextFormPhone = TextStyle(
      fontFamily: 'Museo',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      wordSpacing: 10);

  static const TextStyle stylePrice =
  TextStyle(fontFamily: 'Museo', fontSize: 16, fontWeight: FontWeight.w400);
}
