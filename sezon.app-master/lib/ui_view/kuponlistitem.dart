import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../app_theme.dart';
class ListSets extends StatelessWidget {
  ListSets(
      {Key key,
        this.function,
        this.url})
      : super(key: key);
  final Function function;
  final String url;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
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
                    image: ExactAssetImage(url),
                    fit: BoxFit.fitHeight,
                  ),
                ))
          ],
        ),
      ),
    );
  }

}