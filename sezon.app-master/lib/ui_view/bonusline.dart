import '../app_theme.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as g;

import 'package:provider/provider.dart';
class BonusLineView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final String number;
  final bool active;

  const BonusLineView({Key key, this.animationController, this.animation, this.active, this.number})
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
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      !active? Opacity(
                          opacity: 0.2,
                          child:Container(
                              height: 32.00,
                              decoration: new BoxDecoration(
                                color: SezonAppTheme.white,

                                image: new DecorationImage(
                                  image: ExactAssetImage('assets/images/b'+number+'.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                          )
                      ):Container(
                          height: 40.00,
                          decoration: new BoxDecoration(
                            color: SezonAppTheme.white,

                            image: new DecorationImage(
                              image: ExactAssetImage('assets/images/b'+number+'.png'),
                              fit: BoxFit.fitWidth,
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
