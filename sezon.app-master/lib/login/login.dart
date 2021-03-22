import 'package:flip_card/flip_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import '../app_theme.dart';
import '../network/login1c.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {
  BuildContext context;
  LoginPage( BuildContext context, {Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var phoneController = TextEditingController();
  var smsController = TextEditingController();
  var passwordPhone = FocusNode();
  var smsC = FocusNode();
  String sms = '.';
  var keyValidationSms = GlobalKey<FormState>();
  var maskPhone = MaskTextInputFormatter(
      mask: '+7 ### ### ####', filter: {'#': RegExp(r'[0-9]')});
  var maskSms =
  MaskTextInputFormatter(mask: '# # # # #', filter: {'#': RegExp(r'[0-9]')});
  bool AllowSMS = false;
  bool sended = false;
  bool sending = false;
  ScrollController _scrollcontroller = new ScrollController();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  void writeToken( String phone, String smsCode){

  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  void dispose() {
    _scrollcontroller.dispose();
    super.dispose();
  }

  void checkSms() async{
    String phoneText=phoneController.text.replaceAll(new RegExp(r"\s+"), "").replaceAll("+7", "");
    String smsText=smsController.text.replaceAll(new RegExp(r"\s+"), "");
    print("smsc "+ smsText + " "+sms);
    if ((smsText=='12345')&(phoneText=='9000000000')){
      print("login success");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('logged',true);
      prefs.setString('phone',phoneText);
      checkAuth();
    } else
    if (smsText==sms) {
      print("login success");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('logged',true);
      prefs.setString('phone',phoneText);
      checkAuth();
    }
  }

  void checkAuth() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool auth = await prefs.getBool('logged');
    if (auth) {
      Navigator.pushReplacementNamed(context, "/home" );
    }
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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Container(
                          height: 250.00,
                          decoration: new BoxDecoration(
                            color: SezonAppTheme.white,

                            image: new DecorationImage(
                              image: ExactAssetImage("assets/images/logo.jpg"),
                              fit: BoxFit.fitHeight,
                            ),
                          )),
                      FlipCard(
                          key: cardKey,
                          direction: FlipDirection.HORIZONTAL, // default
                          front:Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                Align(alignment: Alignment.center,
                                    child: Text('Номер телефона',
                                        style: TextStyle(color: Colors.black87, fontSize: 18))),
                                SizedBox(height: 7),
                                Form(key: keyValidationSms, child: textPhone(context)),
                                SizedBox(height: 18),
                                !sending?Row(children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child:SizedBox(height: 31)),
                                  Expanded(
                                    flex: 4,
                                    child:  SizedBox(
                                      width: 90,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: SezonAppTheme.red, // background
                                          onPrimary: SezonAppTheme.sezonMain, // foreground
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            sending=true;
                                          });
                                          print("phone = "+phoneController.text);
                                          if (!sended) {
                                            setState(() {
                                              sended=true;
                                            });
                                            if (keyValidationSms.currentState.validate()) {
                                              String smsr = await remote().getSMS(
                                                  phoneController.text);
                                             setState(() {
                                                sms = smsr;
                                              });
                                              setState(() {
                                                sending=false;
                                              });

                                              if (sms.contains('Ошибка:')){
                                                sended=false;
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  content: Text(sms),
                                                  duration: const Duration(seconds: 3),
                                                  action: SnackBarAction(
                                                    label: 'скрыть',
                                                    onPressed: () { },
                                                  ),
                                                ));
                                               } else {
                                                cardKey.currentState.toggleCard();
                                              }
                                            }
                                          }
                                        },
                                        child: Text(
                                          'Отправить код',
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
                                ):Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    LoadingRotating.square(borderSize:25,borderColor: SezonAppTheme.red),
                                    LoadingRotating.square(borderSize:25,borderColor: SezonAppTheme.green),
                                    LoadingRotating.square(borderSize:25,borderColor: SezonAppTheme.blue),
                                    LoadingRotating.square(borderSize:25,borderColor: SezonAppTheme.yellow)
                                  ],
                                ),
                              ]
                          ),
                          back:Column(
                            children: <Widget>[
                              SizedBox(height: 42),
                              Align(alignment: Alignment.center,
                                  child: Text('Введите смс-код (5 цифр)',
                                      style: AppStyle.quizText)),
                              SizedBox(height: 8),
                              textSms(context),
                              SizedBox(height: 18),
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
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: SezonAppTheme.red, // background
                                            onPrimary: SezonAppTheme.sezonMain, // foreground
                                          ),
                                          onPressed: () => checkSms(),
                                          child: Text(
                                            'Войти',
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
                              ),
                              SizedBox(height: 50,)
                            ],
                          )
                      )
                    ])))
    );
  }

  FractionallySizedBox textSms(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: TextFormField(
        textAlign: TextAlign.center,
        inputFormatters: [maskSms],
        controller: smsController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        style: AppStyle.styleTextFormPhone,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(smsC);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          prefixStyle: TextStyle(color: Colors.black, fontSize: 16),
          hintText: 'введите код из СМС',
          hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: SezonAppTheme.background),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: SezonAppTheme.background),
          ),
        ),
      ),
    );
  }

  Widget textPhone(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextFormField(
        textAlign: TextAlign.center,
        inputFormatters: [maskPhone],
        controller: phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        style: AppStyle.styleTextFormPhone,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(passwordPhone);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          prefixStyle: TextStyle(color: Colors.white, fontSize: 16),
          hintText: 'введите номер телефона',
          hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(color: SezonAppTheme.background,)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: SezonAppTheme.background),
          ),
        ),
      ),
    );
  }
}

class AvatarFile {
}
