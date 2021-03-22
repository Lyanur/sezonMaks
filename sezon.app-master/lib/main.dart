import 'package:app_sezon/screens/BonusScreenExt.dart';
import 'package:app_sezon/screens/akciiscreen.dart';
import 'package:app_sezon/screens/bonuscard.dart';
import 'package:app_sezon/screens/check.dart';
import 'package:app_sezon/screens/checkscreenext.dart';
import 'package:app_sezon/screens/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'login/login.dart';
import 'models/akciimodel.dart';
import 'models/bonusTableModel.dart';
import 'models/tabIcon_data.dart';
import 'app_theme.dart';
import 'network/login1c.dart';
import 'screens/mainscreen.dart';
import 'screens/bonus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart' as g;
import 'package:provider/provider.dart';
import 'dart:ui';
import 'dart:core';
import 'package:intl/intl.dart';
import 'models/checkmodel.dart';
import 'dart:io';
import 'package:barcode/barcode.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DataLoader()),
        ],
        child: MyApp(),
      )
  );
}

class DataLoader with ChangeNotifier, DiagnosticableTreeMixin {
  String _name = "Клиент";
  String _bonus = "0";
  String _level = "1";
  String _phone = "00000000000";
  String _cardnumber = "00000000000";
  String _checkJson = "[]";
  String _akciiJson = "[]";
  String _akciiTotalJson = "[]";
  String _shopWorkTime = "";
  String _shopName = "";
  String _shopID = "";
  String _shopAddress = "";
  String _sumTotal = "";
  String _bonusTableJson = "[]";

  String get name => _name;
  String get bonus => _bonus;
  String get level => _level;
  String get phone => _phone;
  String get cardnumber => _cardnumber;
  String get checkJson => _checkJson;
  String get akciiJson => _akciiJson;
  String get shopAddress => _shopAddress;
  String get shopName => _shopName;
  String get shopID => _shopID;
  String get shopWorkTime => _shopWorkTime;
  String get sumTotal => _sumTotal;
  String get bonusTableJson => _bonusTableJson;

  void loadName()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _phone = await prefs.getString('phone');
    //_phone = '9622185135'; //await prefs.getString('phone');
    notifyListeners();

    /// Загружаем ИМЯ пользователя
    var ret = await remote().clientInfo(phone);
    // print("client info " + ret.toString());
    //print("Таблица " + ret.toString());
    String name1 = ret["data"]["Таблица"]["ФИО"];
    String shopName1 = ret["data"]["Таблица"]["НаименованиеМагазина"];
    String shopId1 = ret["data"]["Таблица"]["Магазин"];
    String shopWorkTime1 = ret["data"]["Таблица"]["ВремяРаботыМагазина"];
    String shopAddress1 = ret["data"]["Таблица"]["АдресМагазина"];
    await prefs.setString('name', name1);
    _name = name1;
    _shopName = shopName1;
    _shopID= shopId1;
    _shopWorkTime = shopWorkTime1;
    _shopAddress = shopAddress1;
    notifyListeners();

    /// Загружаем КАРТУ пользователя и бонусы
    ret = await remote().cardInfo(phone);
    print("cardInfo " + ret.toString());
    String cardnumber1 = ret["data"]["Таблица"]["Код"];
    print("cardnumber " + cardnumber1);
    String level1 = ret["data"]["Таблица"]["Уровень"].toString().replaceAll(
        "Уровень - ", "");
    print("level1 " + level1);
    String bonus1 = ret["data"]["Таблица"]["СуммаБонусов"];
    print("bonus1 " + bonus1);
    await prefs.setString('cardnumber', cardnumber1);
    await prefs.setString('level', level1);
    await prefs.setString('bonus', bonus1);
    _cardnumber = cardnumber1;

    _level = level1;

    _bonus = bonus1;

    notifyListeners();

    loadCheck();

    loadBonus();

    loadAkcii();

  }
  void loadCheck() async {   /// Загружаем КАРТУ пользователя и бонусы
    var ret = await remote().check(phone);
    print ("CheckInfo "+ret["data"]["Таблица"].toString());
    _checkJson= getChecks(ret);
    print("_checkJson "+_checkJson);
    notifyListeners();
  }

  void loadAkcii() async {   /// Загружаем КАРТУ пользователя и бонусы
    var ret = await remote().akciiInfo(shopID);
    print ("akciiInfo "+ret["data"]["Таблица"].toString());
    _akciiJson= getAkcii(ret);
    print("akciiInfo "+_checkJson);
    notifyListeners();
  }

  void loadBonus() async {   /// Загружаем КАРТУ пользователя и бонусы
    var ret = await remote().bonus(phone);
    print("bonusInfo " + ret.toString());
    String sumTotal = ret["data"]["СуммаПокупок"];
    _sumTotal = sumTotal;
    _bonusTableJson= getBonusTable(ret);
    notifyListeners();
  }

  String getChecks(var jjj) {
    List<CheckData> ret = <CheckData>[];
    if (jjj.isNotEmpty) {
      for(var i in jjj["data"]["Таблица"]){
        if (i["Дата"]!=null) {
          DateTime d1 = DateTime.parse(i["Дата"]);
          String date = DateFormat('dd.MM.yy').format(d1);
          CheckData add=new CheckData(
              date: date,
              sum: i["СуммаПокупки"],
              bonus:i["НачисленоБаллов"]
          );
          ret.add(add);
        }
      }
    }
    print('checks json = '+json.encode(ret).toString());
    return json.encode(ret);
  }

  String getAkcii(var a) {
    List<AkciiData> ret = <AkciiData>[];
    if (a.isNotEmpty) {
      for(var i in a["data"]["ТаблицаТоваров"]["ТаблицаТоваров"]){
          String type='price';

          if (i["ПодгруппаМагазина_Идентификатор"]=="Новинка"){
            type='novinka';
          }
          if (i["ПодгруппаМагазина_Идентификатор"]=="Выгодно"){
            type='vigodno';
          }
          if (i["ПодгруппаМагазина_Идентификатор"]=="Хит сезона"){
            type='hit';
          }

          AkciiData add=new AkciiData(
              ostatok: i["Остаток"],
              price: i["Цена"],
              GUID: i["GUID"],
              skidka: i["Скидка"],
              oldprice: i["Цена_Старая"],
              type: type,
              akcii: i["Акция_Идентификатор"],
              foto: i["Фото"],
              group: i["ГруппаМагазина_Идентификатор"],
              podgroup: i["ПодгруппаМагазина_Идентификатор"],
              articul: i["Артикул"],
              title: i["Наименование"]
          );

          print(i["Скидка"] + " " + i["Цена"]);
          ret.add(add);
      }
    }
    print('checks json = '+json.encode(ret).toString());
    return json.encode(ret);
  }


  String getBonusTable(var jjj) {
    List<BonusTableModel> ret = <BonusTableModel>[];
    if (jjj.isNotEmpty) {
      for(var i in jjj["data"]["ТаблицаУровней"]){

        BonusTableModel add=new BonusTableModel(
            name: i["Наименование"],
            percent: i["ПроцентНачисления"],
            sum:i["СуммаПерехода"]
        );
        ret.add(add);
        print(add.toString());
      }
    }
    print('checks json = '+json.encode(ret).toString());
    return json.encode(ret);
  }



  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('checkJson', checkJson));
    properties.add(StringProperty('cardnumber', cardnumber));
    properties.add(StringProperty('level', level));
    properties.add(StringProperty('bonus', bonus));
    properties.add(StringProperty('phone', phone));
    properties.add(StringProperty('shopName', shopName));
    properties.add(StringProperty('shopWorkTime', shopWorkTime));
    properties.add(StringProperty('shopAddress', shopAddress));


  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  final navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      title: 'Сезон',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //  home: LoginPage(context),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => LoginPage(context),
        '/bonus': (BuildContext context) => BonusScreenExt(context),
        '/check': (BuildContext context) => CheckScreenExt(context),
        '/home': (BuildContext context) => MyHomePage(context),
      },
      onUnknownRoute: (RouteSettings settings) => _getRoute(context, settings),
      initialRoute: "/",
    );
  }

  Route<dynamic> _getRoute(BuildContext context, RouteSettings settings) {
    Route page;
    print("router try to route " + settings.name);
    switch (settings.name) {
      case "/":
        Navigator.popAndPushNamed(context, "/");
        page = MaterialPageRoute(
            builder: (context) => LoginPage(context)
        );
        return page;
        break;
      case "/home":
        page = MaterialPageRoute(
            builder: (context) => MyHomePage(context)
        );
        return page;
        break;
    }
    return page;
  }

}

class MyHomePage extends StatefulWidget with ChangeNotifier {

  MyHomePage( BuildContext context, {Key key}) : super(key: key);
  BuildContext context;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  String name = 'Клиент';
  Widget tabBody = Container(
    color: SezonAppTheme.background,
  );
  int _counter = 0;

  void load1c(){
    context.read<DataLoader>().loadName();
    // context.read<DataLoader>().loadCard();
  }

  @override
  void initState() {
    load1c();
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[3].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    tabBody =  ProfileScreen(animationController: animationController, context: context, callback:callback);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SezonAppTheme.background,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body:  Stack(
            children: <Widget>[
              tabBody,
              bottomBar(),
            ],
          )
      ),
    );
  }

  void callback() {
    // if (!mounted) {
    //   return;
    // }
    // setState(() {
    //   tabBody =
    //       BonusCardScreen(context: context,);
    // });
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
            tabIconsList: tabIconsList,
            callback: callback,
            addClick: () {},
            changeIndex: (int index) {
              if (index == 0) {
                animationController.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody =
                        MainScreen(animationController: animationController, callback: callback);
                  });
                });
              } else if (index == 1) {
                animationController.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody =
                        AkciiScreen(animationController: animationController, callback: callback);
                  });
                });
                //   } else if (index == -1) {
                // tabIconsList.forEach((TabIconData tab) {
                //   tab.isSelected = false;
                // });
                //
                // animationController.reverse().then<dynamic>((data) {
                //   if (!mounted) {
                //     return;
                //   }
                //   setState(() {
                //     tabBody =
                //         BonusCardScreen(context: context);
                //   });
                // });
              } else if (index == 2) {
                animationController.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody =
                        BonusCardScreen(animationController: animationController, context: context);
                    // CheckScreen(animationController: animationController, callback: callback);
                  });
                });
              } else if ( index == 3) {
                animationController.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody =
                        ProfileScreen(animationController: animationController, context: context, callback:callback);
                  });
                });
              }
            }
        ),
      ],
    );
  }
}



class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}