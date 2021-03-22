import 'package:flutter/material.dart';

import '../app_theme.dart';

class DiscountListView extends StatefulWidget {
  const DiscountListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  @override
  _DiscountListViewState createState() => _DiscountListViewState();
}

class _DiscountListViewState extends State<DiscountListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<String> areaListData = <String>[
    'assets/images/akcia1.png',
    'assets/images/akcia2.png',
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List _buildList() {
    List<Widget> listItems = List();

    for (var i in areaListData) {
      listItems.add(
          Padding(
              padding: const EdgeInsets.all(8),
              child: DiscountView(imagepath: i
      )));
    }

    return listItems;
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    children:_buildList())
                ),
              );
      },
    );
  }
}

class DiscountView extends StatelessWidget {
  const DiscountView({
    Key key,
    this.imagepath,
  }) : super(key: key);

  final String imagepath;

  @override
  Widget build(BuildContext context) {
    return new Container(

                height: 190.00,
                decoration: new BoxDecoration(
                  color: SezonAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: SezonAppTheme.grey.withOpacity(0.4),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                  image: new DecorationImage(
                    image: ExactAssetImage(imagepath),
                    fit: BoxFit.fitWidth,
                  ),
                )

    );
  }
}
