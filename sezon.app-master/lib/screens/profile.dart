import 'package:app_sezon/ui_view/bonuscard.dart';
import 'package:app_sezon/ui_view/bonussmall.dart';
import 'package:app_sezon/ui_view/kupon_carusel.dart';
import 'package:flip_card/flip_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../ui_view/area_list_view.dart';
import '../ui_view/discount_list_view.dart';
import '../ui_view/running_view.dart';
import '../ui_view/title_view.dart';
import '../ui_view/workout_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import 'package:barcode_widget/barcode_widget.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.animationController,this.context, this.callback}) : super(key: key);
  Function() callback;
  BuildContext context;
  final AnimationController animationController;
  @override
  _ProfileScreenState createState() => _ProfileScreenState(animationController,context,callback);
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  Function() callback;
  BuildContext context;
  AnimationController animationController;
  _ProfileScreenState(AnimationController animationController,   BuildContext context, Function() callback) {
    this.animationController = animationController;
    this.context = context;
    this.callback = callback;
  }

  int level = 1;
  double topBarOpacity = 0.0;

  @override
  void initState() {
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

  void logout() async{
    //print("smsc "+smsController.text.replaceAll(new RegExp(r"\s+"), "") + " "+sms);
    //   if (smsController.text.replaceAll(new RegExp(r"\s+"), "")==sms) {
    print("logout");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged',false);
    Navigator.popAndPushNamed(context, "/");
    // }
  }


  void addAllListData(String cardnumber, String level) {
    const int count = 5;

    listViews.clear();

    listViews.add(
      AboutView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      BonusView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,

      ),
    );

    // listViews.add(
    //
    //       BonusSmall(
    //         level: int.parse(level)>0?int.parse(level):1,
    //         animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //             parent: widget.animationController,
    //             curve: Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
    //         animationController: widget.animationController,
    //       ),
    //     )
    // );

    // listViews.add(
    //   TitleView(
    //     titleTxt: 'Мои купоны (4 шт.)',
    //     subTxt: 'все',
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController,
    //         curve:
    //         Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController,
    //   ),
    // );
    //
    // listViews.add(
    //   KuponCarusel(
    //     mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //         CurvedAnimation(
    //             parent: widget.animationController,
    //             curve: Interval((1 / count) * 5, 1.0,
    //                 curve: Curves.fastOutSlowIn))),
    //     mainScreenAnimationController: widget.animationController,
    //   ),
    // );
    // listViews.add(
    //     SizedBox(height: 18,)
    // );

    listViews.add(
      YourShopView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
        SizedBox(height: 36,)
    );

    listViews.add(
        Row(children: <Widget>[
          Expanded(
              flex: 2,
              child:SizedBox(height: 31)),
          Expanded(
              flex: 4,
              child:  SizedBox(
                width: 90,
                child:SizedBox(
                  width: 138,
                  child: RaisedButton(
                    color: SezonAppTheme.red,
                    onPressed: () => logout(),
                    child: Text(
                      'Сменить пользователя',
                      style: AppStyle.alreadyCart,
                    ),
                  ),
                ),
              )
          ),
          Expanded(
              flex: 2,
              child:SizedBox(height: 31)
          ),
        ]
        )
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    addAllListData(context.watch<DataLoader>().cardnumber,
        context.watch<DataLoader>().level);
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
                                  'ПРОФИЛЬ',
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

class AboutView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const AboutView({Key key, this.animationController, this.animation})
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
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    SezonAppTheme.sezonMain,
                    HexColor("#6F56E8")
                  ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
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
                    child:

                    FlipCard(
                      direction: FlipDirection.HORIZONTAL, // default
                      front:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ваши данные',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: SezonAppTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color: SezonAppTheme.white,
                            ),
                          ),
                          Text(
                            '${context.watch<DataLoader>().name}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: SezonAppTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              letterSpacing: 0.0,
                              color: SezonAppTheme.white,
                            ),
                          ),
                        ],
                      ),
                      back:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ваши данные',
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
                              padding: const EdgeInsets.only(top: 8.0),
                              child:  Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.phone,
                                    color: SezonAppTheme.white,
                                    size: 24,
                                  ),
                                  Text(
                                    '+7'+context.watch<DataLoader>().phone,

                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: SezonAppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                      letterSpacing: 0.0,
                                      color: SezonAppTheme.white,
                                    ),
                                  ),
                                ],
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Text(
                  //       'Ваши данные',
                  //       textAlign: TextAlign.left,
                  //       style: TextStyle(
                  //         fontFamily: SezonAppTheme.fontName,
                  //         fontWeight: FontWeight.normal,
                  //         fontSize: 14,
                  //         letterSpacing: 0.0,
                  //         color: SezonAppTheme.white,
                  //       ),
                  //     ),
                  //     Text(
                  //       '${context.watch<DataLoader>().name}',
                  //       textAlign: TextAlign.left,
                  //       style: TextStyle(
                  //         fontFamily: SezonAppTheme.fontName,
                  //         fontWeight: FontWeight.normal,
                  //         fontSize: 20,
                  //         letterSpacing: 0.0,
                  //         color: SezonAppTheme.white,
                  //       ),
                  //     ),
                  //     Padding(
                  //         padding: const EdgeInsets.only(top: 8.0),
                  //         child:  Row(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: <Widget>[
                  //             Icon(
                  //               Icons.phone,
                  //               color: SezonAppTheme.white,
                  //               size: 24,
                  //             ),
                  //             Text(
                  //               '+7'+context.watch<DataLoader>().phone,
                  //
                  //               textAlign: TextAlign.left,
                  //               style: TextStyle(
                  //                 fontFamily: SezonAppTheme.fontName,
                  //                 fontWeight: FontWeight.normal,
                  //                 fontSize: 20,
                  //                 letterSpacing: 0.0,
                  //                 color: SezonAppTheme.white,
                  //               ),
                  //             ),
                  //           ],
                  //         )
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 4),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


class YourShopView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const YourShopView({Key key, this.animationController, this.animation})
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 0),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: SezonAppTheme.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
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
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 100,
                                          right: 16,
                                          top: 16,
                                        ),
                                        child: Text(
                                          "Ваш магазин",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                            SezonAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color:SezonAppTheme.grey
                                                .withOpacity(0.5)
                                            ,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100,
                                      bottom: 12,
                                      top: 4,
                                      right: 16,
                                    ),
                                    child: Text(
                                      context.watch<DataLoader>().shopName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: SezonAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color: SezonAppTheme.sezonMain,
                                      ),
                                    ),
                                  ),
                                  context.watch<DataLoader>().shopWorkTime!=""?
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100,
                                      right: 16,
                                      top: 0,
                                    ),
                                    child: Text(
                                      "Время работы",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                        SezonAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color:SezonAppTheme.grey
                                            .withOpacity(0.5)
                                        ,
                                      ),
                                    ),
                                  ):Container(),
                                  context.watch<DataLoader>().shopWorkTime!=""?
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100,
                                      bottom: 12,
                                      top: 4,
                                      right: 16,
                                    ),
                                    child: Text(
                                      context.watch<DataLoader>().shopWorkTime,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: SezonAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color: SezonAppTheme.sezonMain,
                                      ),
                                    ),
                                  ):Container(),

                                  context.watch<DataLoader>().shopAddress!=""?
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100,
                                      right: 16,
                                      top: 0,
                                    ),
                                    child: Text(
                                      "Адрес",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                        SezonAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color:SezonAppTheme.grey
                                            .withOpacity(0.5)
                                        ,
                                      ),
                                    ),
                                  ):Container(),
                                  context.watch<DataLoader>().shopAddress!=""?
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100,
                                      bottom: 12,
                                      top: 4,
                                      right: 16,
                                    ),
                                    child: Text(
                                      context.watch<DataLoader>().shopAddress,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: SezonAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color: SezonAppTheme.sezonMain,
                                      ),
                                    ),
                                  ):Container(),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -12,
                        left: 0,
                        child: SizedBox(
                          width: 80,
                          height: 100,
                          child: Image.asset("assets/images/bag.png"),
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

class CardView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const CardView({Key key, this.animationController, this.animation})
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
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    SezonAppTheme.whiteEb
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
                      BarcodeWidget(
                        barcode: Barcode.ean13(drawEndChar: true),
                        data: context.watch<DataLoader>().cardnumber,
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        style: TextStyle(
                          fontFamily:
                          SezonAppTheme.fontName,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color:
                          SezonAppTheme.sezonMain,
                        ),
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
