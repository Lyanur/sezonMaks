
import 'package:app_sezon/screens/profile.dart';
import 'package:app_sezon/ui_view/workout_view.dart';

import '../main.dart';
import '../ui_view/title_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flip_card/flip_card.dart';

class BonusCardScreen extends StatefulWidget {
  BonusCardScreen({Key key, this.animationController, this.context, this.callback}) : super(key: key);
  Function() callback;
  BuildContext context;
  final AnimationController animationController;
  @override
  _BonusCardScreenState createState() => _BonusCardScreenState(animationController,context,callback);
}

class _BonusCardScreenState extends State<BonusCardScreen>
    with TickerProviderStateMixin {
  Function() callback;
  BuildContext context;
  AnimationController animationController;
  Animation<double> topBarAnimation;
  _BonusCardScreenState(AnimationController animationController,   BuildContext context, Function() callback) {
    this.animationController = animationController;
    this.context = context;
    this.callback = callback;
  }
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {

    // addAllListData();
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));


    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 3;

    listViews.clear();

    listViews.add(
      BonusView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,

      ),
    );

    listViews.add(
        SizedBox(height: 20,)
    );

    listViews.add(
        QRView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: animationController,
                curve:
                Interval(0.2, 1.0, curve: Curves.fastOutSlowIn))),
            animationController: animationController)
    );
    listViews.add(
        SizedBox(height: 20,)
    );

    listViews.add(
        CardView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: animationController,
                curve:
                Interval(0.4, 1.0, curve: Curves.fastOutSlowIn))),
            animationController: animationController)
    );

  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    addAllListData();
    return Container(
      color: SezonAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: SezonAppTheme.sezonMain,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0 * topBarOpacity),
                      bottomRight: Radius.circular(16.0 * topBarOpacity),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: SezonAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'КАРТА',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: SezonAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: SezonAppTheme.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class CardView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const CardView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
                opacity: animation,
                child: new Transform(
                    transform: new Matrix4.translationValues(
                        0.0, 30 * (1.0 - animation.value), 0.0),
                    child:
                    FlipCard(
                      direction: FlipDirection.HORIZONTAL, // default
                      front: Container(
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child:
                                  Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child:Image.asset("assets/images/card1.png")
                                  ),
                                    Positioned(
                                        bottom: 8,
                                        left: 24,
                                        child: Text(context.watch<DataLoader>().cardnumber,
                                          style: TextStyle(
                                            fontFamily:
                                            SezonAppTheme.fontName,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 24,
                                            letterSpacing: 1.2,
                                            color:Colors.black,
                                          ),
                                        )
                                    ),
                                  ],
                                  )
                              )
                          )
                      ),
                      back: Container(
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.white,
                                    Colors.white,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 20,),
                                      BarcodeWidget(
                                        barcode: Barcode.ean13(
                                            drawEndChar: false),
                                        data: context.watch<DataLoader>().cardnumber,
                                        width: MediaQuery.of(context).size.width,
                                        height: 140,
                                        style: TextStyle(
                                          fontFamily:
                                          SezonAppTheme.fontName,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 0,
                                          letterSpacing: 0.0,
                                          color:
                                          SezonAppTheme.sezonMain,
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                    ],
                                  ),
                                ),
                              )
                          )
                      ),
                    )
                )
            );
          }
      );
  }
}

class QRView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const QRView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
                opacity: animation,
                child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child:
                  BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: context.watch<DataLoader>().cardnumber,
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    style: TextStyle(
                      fontFamily:
                      SezonAppTheme.fontName,
                      fontWeight: FontWeight.w400,
                      fontSize: 0,
                      letterSpacing: 0.0,
                      color:
                      SezonAppTheme.sezonMain,
                    ),
                  ),
                )
            );
          }
      );
  }
}
