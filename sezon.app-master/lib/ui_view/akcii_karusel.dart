import 'package:app_sezon/models/akciimodel.dart';
import 'package:app_sezon/ui_view/discount_list_view.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../globals.dart' as g;
import 'package:cached_network_image/cached_network_image.dart';

class AkciiKarusel extends StatefulWidget {
  const AkciiKarusel(
      {Key key, this.animationController, this.areaListData, this.animation})
      : super(key: key);
  final List<String> areaListData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  @override
  _AkciiKaruselState createState() => _AkciiKaruselState();
}

class _AkciiKaruselState extends State<AkciiKarusel>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<String> areaListData ;

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
        height: 170,
        child: AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
                opacity: widget.animation,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.animation.value), 0.0),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 8),
                      child:  ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.areaListData.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                                  child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16.0),
                                        child:Image.asset(
                                          widget.areaListData[index],
                                          fit: BoxFit.fitWidth,
                                        ),

                                      )
                                  )
                              )
                      ),
                    ),
                  ),

                ));
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


class AkciiSuperKarusel extends StatefulWidget {
  const AkciiSuperKarusel(
      {Key key, this.animationController, this.areaListData, this.animation})
      : super(key: key);
  final List<AkciiData> areaListData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  @override
  _AkciiSuperKaruselState createState() => _AkciiSuperKaruselState();
}

class _AkciiSuperKaruselState extends State<AkciiSuperKarusel>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<String> areaListData ;

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
    return


      SizedBox(
          height: 120,
          child: AnimatedBuilder(
            animation: widget.animationController,
            builder: (BuildContext context, Widget child) {
              return FadeTransition(
                  opacity: widget.animation,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 30 * (1.0 - widget.animation.value), 0.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child:  ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.areaListData.length,
                            itemBuilder: (BuildContext context, int index) =>
                            widget.areaListData[index].skidka=='0'?Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 8),
                              child: GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (_) => ImageDialog(imagepath: g.FULL_URL_SERVER+"/images/"+
                                          widget.areaListData[index].foto+'.jpg',)
                                  );
                                },child:Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child:Stack(children: [
                                        Image.asset(
                                          'assets/akcii/'+widget.areaListData[index].type+'.jpg',
                                          fit: BoxFit.fitWidth,
                                        ),
                                        Positioned(
                                            right:100,
                                            top: 36,
                                            child: Text(widget.areaListData[index].price,
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 32,
                                                letterSpacing: -2,
                                                color: Colors.black,
                                              ),)
                                        ),
                                        Positioned(
                                            right:100,
                                            top: 64,
                                            child: Text('руб',
                                              style: TextStyle(
                                                fontFamily: SezonAppTheme.fontName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10,
                                                letterSpacing: -1.2,
                                                color: Colors.black,
                                              ),)
                                        ),
                                        Positioned(
                                            right:92,
                                            top: 88,
                                            child: Text(widget.areaListData[index].title.toUpperCase(),
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                letterSpacing: -0.3,
                                                color: SezonAppTheme.darkText,
                                              ),)
                                        ),
                                        Positioned(
                                            right:92,
                                            top: 102,
                                            child: Text("Арт. "+widget.areaListData[index].articul,
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9,
                                                letterSpacing: -0.5,
                                                color: SezonAppTheme.darkText,
                                              ),)
                                        ),
                                        Positioned(
                                            right:0,
                                            top: 0,
                                            child: Container(
                                              width: 90,
                                              child: new CachedNetworkImage(
                                                  imageUrl:g.FULL_URL_SERVER+"/images/"+
                                                      widget.areaListData[index].foto+'.jpg',
                                                  placeholder: (context, url) => Container(height:32,child:Theme(
                                                    data: Theme.of(context).copyWith(
                                                        backgroundColor: Colors.grey[100]
                                                    ),
                                                    child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey[100])
                                                      ,strokeWidth: 1.0,),
                                                  ))),

                                            )
                                        )
                                      ])
                                  )
                            ))
                            //////////////////////////////////// AKCII
                                :
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 8),
                              child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child:ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Stack(children: [
                                        Image.asset(
                                          'assets/akcii/'+widget.areaListData[index].type+'.jpg',
                                          fit: BoxFit.fitWidth,
                                        ),
                                        Positioned(
                                            right:140,
                                            top: 26,
                                            child: Text("-"+widget.areaListData[index].skidka+"%",
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                letterSpacing: -1,
                                                color: Colors.black,
                                              ),)
                                        ),
                                        Positioned(
                                            right:100,
                                            top: 40,
                                            child: Text("Было: " +widget.areaListData[index].oldprice,
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                letterSpacing: -1,
                                                color: Colors.black,
                                              ),)
                                        ),
                                        Positioned(
                                            right:100,
                                            top: 52,
                                            child: Text("Стало: ",
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                letterSpacing: -1,
                                                color: Colors.black,
                                              ),)
                                        ),
                                        Positioned(
                                            right:100,
                                            top: 60,
                                            child: Text(widget.areaListData[index].price,
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24,
                                                letterSpacing: -3,
                                                color: Colors.black,
                                              ),)
                                        ),
                                        Positioned(
                                            right:92,
                                            top: 64,
                                            child: Text("р",
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                letterSpacing: -3,
                                                color: Colors.black,
                                              ),)
                                        ),

                                        Positioned(
                                            right:92,
                                            top: 88,
                                            child: Text(widget.areaListData[index].title,
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10,
                                                letterSpacing: -1,
                                                color: SezonAppTheme.darkText,
                                              ),)
                                        ),
                                        Positioned(
                                            right:92,
                                            top: 102,
                                            child: Text("Арт. "+widget.areaListData[index].articul,
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 8,
                                                letterSpacing: -0.5,
                                                color: SezonAppTheme.darkText,
                                              ),)
                                        ),
                                        Positioned(
                                            right:0,
                                            top: 0,
                                            child: Container(
                                              width: 90,
                                              child: new CachedNetworkImage(
                                                  imageUrl:g.FULL_URL_SERVER+"/images/"+ widget.areaListData[index].foto+'.jpg',
                                                  placeholder: (context, url) => Container(height:32,child:Theme(
                                                    data: Theme.of(context).copyWith(
                                                        backgroundColor: Colors.grey[100]
                                                    ),
                                                    child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey[100])
                                                      ,strokeWidth: 1.0,),
                                                  )
                                                  )
                                              ),
                                            )
                                        )
                                      ]
                                      )
                                  )
                              ),
                            )
                        ),
                      ),
                    ),

              );
            },
          )
      );
  }

}

class ImageDialog extends StatelessWidget {


  const ImageDialog({
    Key key,
    this.imagepath
  }) : super(key: key);

  final String imagepath;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        child: new CachedNetworkImage(
        imageUrl:imagepath,
            placeholder: (context, url) => Container(height:32,child:Theme(
              data: Theme.of(context).copyWith(
                  backgroundColor: Colors.grey[100]
              ),
              child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey[100])
                ,strokeWidth: 1.0,),
            )
            )
        ),
        )
    );
  }
}