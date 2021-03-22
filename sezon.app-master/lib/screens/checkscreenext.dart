import 'package:app_sezon/models/checkmodel.dart';
import 'package:app_sezon/ui_view/checklistitem.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import '../app_theme.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../main.dart';

class CheckScreenExt extends StatefulWidget {
  BuildContext context;
  CheckScreenExt( BuildContext context, {Key key}) : super(key: key);

  @override
  _CheckScreenExtState createState() => _CheckScreenExtState();
}

class _CheckScreenExtState extends State<CheckScreenExt>
    with TickerProviderStateMixin {
  ScrollController scrollController = new ScrollController();

  List<Widget> listViews = <Widget>[];

  AnimationController animationController;

  double topBarOpacity = 0.0;

  @override
  void initState() {

    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    animationController.reverse();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  static const TextStyle quizText = TextStyle(
    fontFamily: 'Museo',
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  Future<bool> getData(BuildContext context) async {
    /// widget.animationController.reverse();

    var checks = json.decode(context.watch<DataLoader>().checkJson);

    int count = checks.length;
    listViews.clear();
    double step = 1/count;

    print("check count "+checks.length.toString());

    listViews.add(
        Container(
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
            child:Column(
            children: <Widget>[
              SizedBox(
                height: 60,//ßMediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16 - 8.0,
                    bottom: 12 - 8.0 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Начисления бонусов',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: SezonAppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            letterSpacing: 1.2,
                            color: SezonAppTheme.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]
        )
        )
    );
    listViews.add(
        SizedBox(height: 24,)
    );

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

    listViews.add(
        Row(children: <Widget>[
          Expanded(
              flex: 2,
              child:SizedBox(height: 31)),
          Expanded(
            flex: 4,
            child:  SizedBox(
              width: 150,
              child: RaisedButton(
                color: SezonAppTheme.red,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Назад',
                  style: AppStyle.alreadyCart,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child:SizedBox(height: 31)
          ),
        ]
        )
    );

    //  widget.animationController.forward();
    return true;
  }


  @override
  Widget build(BuildContext context) {
    getData(context);
    animationController.forward();
    return  Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //   controller: scrollController,
            child: Container(
                color: Colors.white,
                child: Column(
                  children: listViews,
                )
            )
        )
    );
  }
}

