import 'package:app_sezon/ui_view/discount_list_view.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter/widgets.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flip_card/flip_card.dart';




class KuponCarusel extends StatefulWidget {
  const KuponCarusel(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  @override
  _KuponCaruselState createState() => _KuponCaruselState();
}

class _KuponCaruselState extends State<KuponCarusel>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<String> areaListData = <String>[
    'assets/images/07.jpg',
    'assets/images/08.jpg',
    'assets/images/09.jpg',
    'assets/images/10.jpg',
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 190,
        child: AnimatedBuilder(
          animation: widget.mainScreenAnimationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
                opacity: widget.mainScreenAnimation,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child:  ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: areaListData.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                      padding: const EdgeInsets.only(left: 8.0, bottom:10, right: 8),
                                      child: new Container(

                                          height: 190.00,
                                          width: 250,
                                          decoration: new BoxDecoration(
                                              color: SezonAppTheme.white,
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(16.0),
                                                  bottomLeft: Radius.circular(0.0),
                                                  bottomRight: Radius.circular(0.0),
                                                  topRight: Radius.circular(0.0)),
                                          ),
                                          child: FlipCard(
                                              direction: FlipDirection.HORIZONTAL, // default
                                              front:  Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                child:
                                                ClipRRect(
                                                borderRadius: BorderRadius.circular(16.0),
                                                child:
                                                    Image.asset(areaListData[index]),
                                                  )
                                              ),
                                              back: BarcodeWidget(
                                                barcode: Barcode.qrCode(),
                                                data: context.watch<DataLoader>().cardnumber,
                                                width: MediaQuery.of(context).size.width,
                                                height: 180,
                                                style: TextStyle(
                                                  fontFamily:
                                                  SezonAppTheme.fontName,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                  color: SezonAppTheme.grey,
                                                ),
                                              )

                                          )
                                      )
                                  )
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 8.0, right: 8),
                            //     child: new Container(
                            //
                            //       height: 190.00,
                            //       decoration: new BoxDecoration(
                            //           color: SezonAppTheme.white,
                            //           borderRadius: const BorderRadius.only(
                            //               topLeft: Radius.circular(16.0),
                            //               bottomLeft: Radius.circular(16.0),
                            //               bottomRight: Radius.circular(16.0),
                            //               topRight: Radius.circular(16.0)),
                            //           boxShadow: <BoxShadow>[
                            //             BoxShadow(
                            //                 color: SezonAppTheme.grey.withOpacity(0.4),
                            //                 offset: const Offset(1.1, 1.1),
                            //                 blurRadius: 10.0),
                            //           ]
                            //       ),
                            //       child:Image.asset(
                            //         areaListData[index],
                            //         fit: BoxFit.fitWidth,
                            //       ),
                            //     )
                            // )
                          )
                      ),
                    ),
                )
            );
          },
        )
    );
  }
}

class AreaView extends StatelessWidget {
  const AreaView({
    Key key,
    this.imagepath,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final String imagepath;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: new Container(
                width: 100.00,
                height: 100.00,
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
                    fit: BoxFit.fitHeight,
                  ),
                )),
          ),
        );
      },
    );
  }
}
