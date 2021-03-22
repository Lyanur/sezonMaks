import '../app_theme.dart';
import '../main.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
class BonusView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  //Function() callback;

  BonusView({Key key, this.animationController, this.animation})
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
                    0.0, 30 * (1.0 - animation.value), 0.0),
                child: GestureDetector(
                  onTap: (){
                    print("tap");
                    // widget.callback();
                    Navigator.of(context).pushNamed('/bonus');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          SezonAppTheme.red, SezonAppTheme.red
                        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                            topRight: Radius.circular(12.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: SezonAppTheme.grey.withOpacity(0.6),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                    height: 70,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8, right: 8, top: 4),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[

                                                    Text(
                                                      'Ваши бонусы',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: SezonAppTheme.fontName,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                        letterSpacing: 0.0,
                                                        color: SezonAppTheme.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                                                      child: Text(
                                                        //context.watch<DataLoader>().name+'\n\n'+
                                                        context.watch<DataLoader>().bonus+'\n'
                                                        // "Уровень - " + context.watch<DataLoader>().level+''
                                                        ,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily: SezonAppTheme.fontName,
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 32,
                                                          letterSpacing: 0.0,
                                                          color: SezonAppTheme.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          ),
                                          Expanded(
                                              child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[

                                                    Text(
                                                      'Уровень',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: SezonAppTheme.fontName,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                        letterSpacing: 0.0,
                                                        color: SezonAppTheme.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                                                      child: Text(
                                                        //context.watch<DataLoader>().name+'\n\n'+
                                                        // context.watch<DataLoader>().bonus+'\n'
                                                        context.watch<DataLoader>().level+''
                                                        ,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily: SezonAppTheme.fontName,
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 32,
                                                          letterSpacing: 0.0,
                                                          color: SezonAppTheme.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  )

                            ]
                        ),
                      ),
                    )
                ))
            )
        );
      },
    );
  }
}
