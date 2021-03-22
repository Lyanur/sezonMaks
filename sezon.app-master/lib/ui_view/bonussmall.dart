
import 'dart:convert';

import 'package:app_sezon/models/bonusTableModel.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../globals.dart' as g;

class BonusSmall extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final int level;


  BonusSmall({Key key, this.animationController, this.animation, this.level})
      : super(key: key);

  String bonusText='';

  @override
  Widget build(BuildContext context) {
    if (level==10) {
      bonusText = 'У вас максимальный уровень';
    } else {
      int sum = 0;
        List<dynamic> bonusTable = json.decode(context
            .watch<DataLoader>()
            .bonusTableJson);
      try {
        int.parse(bonusTable[level]["sum"]) - int.parse(context
            .watch<DataLoader>()
            .sumTotal);
      } catch (e) {
      }
      bonusText = sum.toString() + ' до следующего уровня';
      }
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 0),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child:
                        Container(
                          decoration: BoxDecoration(
                            color: SezonAppTheme.sezonMain,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.0),
                                bottomLeft: Radius.circular(3.0),
                                bottomRight: Radius.circular(3.0),
                                topRight: Radius.circular(3.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: SezonAppTheme.grey.withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 110,
                                      bottom: 0,
                                      top: 4,
                                      right: 16,
                                    ),
                                    child: Text(
                                      g.bonusTitle[level-1],//context.watch<DataLoader>().shopName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: SezonAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24,
                                        letterSpacing: 0.0,
                                        color: SezonAppTheme.white,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 110,
                                      bottom: 0,
                                      top: 0,
                                      right: 16,
                                    ),
                                    child: Text(
                                      context.watch<DataLoader>().sumTotal!=''?
                                      context.watch<DataLoader>().sumTotal +' сумма накоплений':
                                      '',//context.watch<DataLoader>().shopName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: SezonAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        letterSpacing: 0.0,
                                        color: SezonAppTheme.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 110,
                                      bottom: 14,
                                      top: 4,
                                      right: 16,
                                    ),
                                    child: Text(
                                      bonusText,//context.watch<DataLoader>().shopName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: SezonAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        letterSpacing: 0.0,
                                        color: SezonAppTheme.whiteEb,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 4,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: SezonAppTheme.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  bottomLeft: Radius.circular(50.0),
                                  bottomRight: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: SezonAppTheme.grey.withOpacity(0.4),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            )
                          ),
                        )
                      ),
                   Positioned(
                        top: 4,
                        left: 14,
                        child: SizedBox(
                          width: 80,
                          height: 100,
                          child: Image.asset("assets/images/levels"+level.toString()+".png"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
