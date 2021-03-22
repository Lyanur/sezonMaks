import 'dart:convert';

import 'package:app_sezon/models/akciimodel.dart';
import 'package:app_sezon/ui_view/akcii_karusel.dart';
import 'package:app_sezon/ui_view/bonuscard.dart';

import '../main.dart';
import '../ui_view/area_list_view.dart';
import '../ui_view/discount_list_view.dart';
import '../ui_view/running_view.dart';
import '../ui_view/title_view.dart';
import '../ui_view/workout_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key,  this.animationController, this.callback}) : super(key: key);
  Function() callback;
  final AnimationController animationController;
  @override
  _MainScreenState createState() => _MainScreenState(animationController,callback);
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin {
  Function() callback;
  AnimationController animationController;
  Animation<double> topBarAnimation;
  _MainScreenState(AnimationController animationController, Function() callback) {
    this.animationController = animationController;
    this.callback = callback;
  }


  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  List<String> areaListData = <String>[
    'assets/akcii/1.jpg',
    'assets/akcii/2.jpg',
  ];
  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
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
    const int count = 6;
    listViews.clear();
    // listViews.add(
    //   RunningView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: animationController,
    //         curve:
    //         Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: animationController,
    //   ),
    // );

    listViews.add(
      SizedBox(height: 32,)
    );
    //
    // listViews.add(
    //     AkciiKarusel(
    //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //           parent: animationController,
    //           curve:
    //           Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
    //       animationController: animationController,
    //       areaListData: <String>[
    //         'assets/akcii/1.jpg',
    //         'assets/akcii/3.jpg',
    //         'assets/akcii/4.jpg',
    //         'assets/akcii/5.jpg'
    //       ],
    //     )
    // );

    var akcii = json.decode(context.watch<DataLoader>().akciiJson);

    print("akcii "+akcii.toString());

    List<AkciiData> novinka = <AkciiData>[];

    for (var i in akcii){
      AkciiData x;
      if (AkciiData.fromJson(i).group=='Новинки'){
        novinka.add(AkciiData.fromJson(i));
      }
    }

    List<AkciiData> woman = <AkciiData>[];

    for (var i in akcii){
      AkciiData x;
      if (AkciiData.fromJson(i).group=='Женщинам'){
        woman.add(AkciiData.fromJson(i));
      }
    }

    List<AkciiData> men = <AkciiData>[];

    for (var i in akcii){
      AkciiData x;
      if (AkciiData.fromJson(i).group=='Мужчинам'){
        men.add(AkciiData.fromJson(i));
      }
    }

    List<AkciiData> child = <AkciiData>[];

    for (var i in akcii){
      AkciiData x;
      if (AkciiData.fromJson(i).group=='Детям'){
        child.add(AkciiData.fromJson(i));
      }
    }
    List<AkciiData> sezon = <AkciiData>[];

    for (var i in akcii){
      AkciiData x;
      if (AkciiData.fromJson(i).group=='Сезон'){
        sezon.add(AkciiData.fromJson(i));
      }
    }

    listViews.add(
      TitleView(
        titleTxt: 'Новинки',
        subTxt: 'все',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
            Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );

    listViews.add(
        AkciiSuperKarusel(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
          animationController: animationController,
          areaListData: novinka,
        )
    );

    listViews.add(
      TitleView(
        titleTxt: 'Женщинам',
        subTxt: 'все',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
            Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );

    listViews.add(
        AkciiSuperKarusel(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController,
              curve:
              Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
          animationController: animationController,
          areaListData: woman,
        )
    );
    listViews.add(
      TitleView(
        titleTxt: 'Мужчинам',
        subTxt: 'все',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
            Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );

    listViews.add(
        AkciiSuperKarusel(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController,
              curve:
              Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
          animationController: animationController,
          areaListData: men,
        )
    );
    listViews.add(
      TitleView(
        titleTxt: 'Детям',
        subTxt: 'все',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
            Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );

    listViews.add(
        AkciiSuperKarusel(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController,
              curve:
              Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
          animationController: animationController,
          areaListData: child,
        )
    );
    listViews.add(
      TitleView(
        titleTxt: 'Сезон',
        subTxt: 'все',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
            Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );

    listViews.add(
        AkciiSuperKarusel(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController,
              curve:
              Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
          animationController: animationController,
          areaListData: sezon,
        )
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
              top: //AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24+32,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              animationController.forward();
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
                                  'СЕЗОН',
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
