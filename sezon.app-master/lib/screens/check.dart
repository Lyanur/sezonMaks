import 'package:app_sezon/models/checkmodel.dart';
import 'package:app_sezon/ui_view/area_list_view.dart';
import 'package:app_sezon/ui_view/bonuscard.dart';
import 'package:app_sezon/ui_view/checklistitem.dart';
import 'package:app_sezon/ui_view/checklistview.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class CheckScreen extends StatefulWidget {
  CheckScreen({Key key, this.animationController, this.callback}) : super(key: key);
  Function() callback;
  final AnimationController animationController;
  @override
  _CheckScreenState createState() => _CheckScreenState(animationController,callback);
}

class _CheckScreenState extends State<CheckScreen>
    with TickerProviderStateMixin {
  Function() callback;
  AnimationController animationController;
  Animation<double> topBarAnimation;
  _CheckScreenState(AnimationController animationController, Function() callback) {
    this.animationController = animationController;
    this.callback = callback;
  }

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

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


  }

  Future<bool> getData(BuildContext context) async {
    /// widget.animationController.reverse();

    var checks = json.decode(context.watch<DataLoader>().checkJson);

    int count = checks.length;
    listViews.clear();
    double step = 1/count;

    print("check count "+checks.length.toString());

    listViews.add(
        CheckListItem(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
        //number:i.toString(),
        check:CheckData(date:"",sum:"",bonus:"Бонус")
    ));

    int n=0;
    for (var i in checks){
      print(i["date"]);
      listViews.add(
          CheckListItem(
              animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animationController,
                  curve: Interval((1 / count) * n, 1.0, curve: Curves.fastOutSlowIn))),
              animationController: animationController,
              //number:i.toString(),
              check:CheckData(date:i["date"],sum:i["sum"],bonus: i["bonus"])
          )
      );
      n++;
    }
    //  widget.animationController.forward();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SezonAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),

          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    getData(context);
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(
            top: ///AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
                60,
            bottom: 62 + MediaQuery.of(context).padding.bottom,
          ),
          itemCount: listViews.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            widget.animationController.forward();
            return listViews[index];
          },
        )
    );
  }

  //
  //           List<Widget>.generate(
  //             json.decode(context.watch<DataLoader>().checkJson).length,
  //                 (int index) {
  //               final int count = json.decode(context.watch<DataLoader>().checkJson).length;
  //               final Animation<double> animation =
  //               Tween<double>(begin: 0.0, end: 1.0).animate(
  //                 CurvedAnimation(
  //                   parent: widget.animationController,
  //                   curve: Interval((1 / count) * index, 1.0,
  //                       curve: Curves.fastOutSlowIn),
  //                 ),
  //               );
  //               widget.animationController.forward();
  //               return new Container(
  //                   width: 100.00,
  //                   height: 100.00,
  //                   decoration: new BoxDecoration(
  //                       color: SezonAppTheme.white,
  //                       borderRadius: const BorderRadius.all(Radius.circular(9.0)),
  //                       boxShadow: <BoxShadow>[
  //                         BoxShadow(
  //                             color: SezonAppTheme.grey.withOpacity(0.4),
  //                             offset: const Offset(1.1, 1.1),
  //                             blurRadius: 10.0),
  //                       ]),child:
  //               Padding(
  //                   padding: const EdgeInsets.all(8),
  //                   child:Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: <Widget>[
  //                         Text(
  //                           'Дата',
  //                           style: TextStyle(
  //                             fontFamily: SezonAppTheme.fontName,
  //                             fontWeight: FontWeight.w700,
  //                             fontSize: 12,
  //                             letterSpacing: 1.2,
  //                             color: SezonAppTheme.dark_grey,
  //                           ),
  //                         ),
  //                         Text(
  //                             json.decode(context.watch<DataLoader>().checkJson)[index]['date'],
  //                             style: TextStyle(
  //                               fontFamily: SezonAppTheme.fontName,
  //                               fontWeight: FontWeight.w700,
  //                               fontSize: 16,
  //                               letterSpacing: 1.2,
  //                               color: SezonAppTheme.sezonMain,
  //                             )),
  //
  //                         SizedBox(height: 4,),
  //                         Text(
  //                           'Сумма',
  //                           style: TextStyle(
  //                             fontFamily: SezonAppTheme.fontName,
  //                             fontWeight: FontWeight.w700,
  //                             fontSize: 12,
  //                             letterSpacing: 1.2,
  //                             color: SezonAppTheme.dark_grey,
  //                           ),
  //                         ),
  //                         Text(
  //                           json.decode(context.watch<DataLoader>().checkJson)[index]['sum'],
  //                           style: TextStyle(
  //                             fontFamily: SezonAppTheme.fontName,
  //                             fontWeight: FontWeight.w700,
  //                             fontSize: 20,
  //                             letterSpacing: 1.2,
  //                             color: SezonAppTheme.sezonMain,
  //                           ),
  //                         ),
  //
  //                         SizedBox(height: 4,),
  //                         Text(
  //                           'Бонус',
  //                           style: TextStyle(
  //                             fontFamily: SezonAppTheme.fontName,
  //                             fontWeight: FontWeight.w700,
  //                             fontSize: 12,
  //                             letterSpacing: 1.2,
  //                             color: SezonAppTheme.dark_grey,
  //                           ),
  //                         ),
  //                         Text(
  //                           json.decode(context.watch<DataLoader>().checkJson)[index]['bonus'],
  //                           style: TextStyle(
  //                             fontFamily: SezonAppTheme.fontName,
  //                             fontWeight: FontWeight.w700,
  //                             fontSize: 20,
  //                             letterSpacing: 1.2,
  //                             color: SezonAppTheme.red,
  //                           ),
  //                         ),
  //                       ]
  //                   )
  //               )
  //               );
  //             },
  //           ),
  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             mainAxisSpacing: 24.0,
  //             crossAxisSpacing: 24.0,
  //             childAspectRatio: 1.0,
  //           ),
  //         )
  //     );
  //   }

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
                                  'ЧЕКИ',
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
