import 'package:app_sezon/models/checkmodel.dart';

import '../app_theme.dart';
import '../main.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
class CheckListItem extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final CheckData check;
  final bool active;

  const CheckListItem({Key key, this.animationController, this.animation, this.active, this.check})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
            opacity: animation,
            child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 1 * (1.0 - animation.value), 0.0),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 0, bottom: 0),
                    child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            //leading: Icon(Icons.list),
                            trailing:
                            Text( "+" + check.bonus,
                                style: TextStyle(
                                  fontFamily: SezonAppTheme.fontName,
                                  fontWeight: FontWeight.w700,
                                  fontSize:  24,
                                  letterSpacing: 1.2,
                                  color: SezonAppTheme.red,
                                )
                            ),
                            title:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    check.date,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: SezonAppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      letterSpacing: 1.2,
                                      color: SezonAppTheme.sezonMain,
                                    ),
                                  ),
                                // check.sum!=''?Text(
                                //     "  Сумма  ",
                                //     textAlign: TextAlign.left,
                                //     style: TextStyle(
                                //       fontFamily: SezonAppTheme.fontName,
                                //       fontWeight: FontWeight.w400,
                                //       fontSize: 14,
                                //       letterSpacing: 1.2,
                                //       color: SezonAppTheme.grey,
                                //     ),
                                // ):Container(),
                                // Text(
                                //     check.sum,
                                //     textAlign: TextAlign.left,
                                //     style: TextStyle(
                                //       fontFamily: SezonAppTheme.fontName,
                                //       fontWeight: FontWeight.w700,
                                //       fontSize: 14,
                                //       letterSpacing: 1.2,
                                //       color: SezonAppTheme.sezonMain,
                                //     ),
                                //   ),
                              ],
                            ),
                          )
                        ]
                    )
                )
            )

        );
      },
    );
  }
}
