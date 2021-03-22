import 'package:app_sezon/screens/profile.dart';
import 'package:app_sezon/ui_view/bonusline.dart';
import 'package:app_sezon/ui_view/bonussmall.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import '../app_theme.dart';

import '../main.dart';
import 'package:provider/provider.dart';


class BonusScreenExt extends StatefulWidget {
  BuildContext context;
  BonusScreenExt( BuildContext context, {Key key}) : super(key: key);

  @override
  _BonusScreenExtState createState() => _BonusScreenExtState();
}

class _BonusScreenExtState extends State<BonusScreenExt>
    with TickerProviderStateMixin {
  ScrollController scrollController = new ScrollController();

  List<Widget> listViews = <Widget>[];
  List<Widget> listViewsBack = <Widget>[];

  AnimationController animationController;
  Animation defAnimation;
  double _height = 0;
  double _height2 = 0;

  int level = 1;

  @override
  void initState() {

    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    animationController.reverse();
    defAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn)));
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

  void addAllListData(String level) {

    // int lev = 10;//int.parse(level);

    int count =10;

    listViews.clear();

    listViews.add(
        SizedBox(height: 60,)
    );

    listViews.add(
      BonusSmall(
        level:int.parse(level),
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
            Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );

    listViews.add(
        AnimatedContainer(
          // Use the properties stored in the State class.
          height: _height,
          width: MediaQuery.of(context).size.width,
          // Define how long the animation should take.
          duration: Duration(seconds: 1),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.fastOutSlowIn,
          child:Container (
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/levels_snake'+level+'.jpg', fit: BoxFit.fitWidth )
          ),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 20),

        )
    );
    listViews.add(
        AnimatedContainer(
          // Use the properties stored in the State class.
          height: _height2,
          width: MediaQuery.of(context).size.width,
          // Define how long the animation should take.
          duration: Duration(seconds: 1),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.fastOutSlowIn,
          child:Container (
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/levels_snake_bw'+level+'.jpg', fit: BoxFit.fitWidth )
          ),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 20),

        )
    );

    listViews.add(
        SizedBox(height: 0,)
    );

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
    listViews.add(
        SizedBox(height: 24,)
    );

  }

  @override
  Widget build(BuildContext context) {

    level = int.parse(context.watch<DataLoader>().level);

    addAllListData(level.toString());

    getData();

    return  Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //   controller: scrollController,
            child: Container(
                color: Colors.white,
                child:  Stack(
                    children: <Widget>[
                      Column(children: listViews),
                    ]
                )
            )
        )
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    setState(() {
      _height = level.toDouble()*80+55;
      _height2 = (10-level).toDouble()*80+30;
    });
    animationController.forward();
    return true;
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
              top: ///AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top +
                  60,
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
}

