import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../globals.dart' as g;

class remote
{
  Future<String> getSMS(String phone) async {
    phone=phone.replaceAll(new RegExp(r"\s+"), "").replaceAll("+7", "");
    var queryParameters = {
      'key': g.API_KEY,
      'phone': phone,
      'tag': 'getkodproverki',
    };
    print("URL = " + Uri.https(g.URL_SERVER, "sezon.php", queryParameters).toString());
    final response = await http.get(Uri.https(g.URL_SERVER, "sezon.php", queryParameters));
   // print('response 1c ' + response.body.toString().trim());
    Map<String, dynamic> ret = json.decode(response.body.toString().trim());
    print("sms = "+ret["data"]["Описание"].toString());
    return ret["data"]["Описание"].toString();
  }

 Future<Map<String, dynamic>> clientInfo(String phone) async {
    phone=phone.replaceAll(new RegExp(r"\s+"), "").replaceAll("+7", "");
    var queryParameters = {
      'key': g.API_KEY,
      'phone': phone,
      'tag': 'clientinfo',
    };
    print("URL = " + Uri.https(g.URL_SERVER, "sezon.php", queryParameters).toString());
    final response = await http.get(Uri.https(g.URL_SERVER, "sezon.php", queryParameters));
    // print('response 1c ' + response.body.toString().trim());
    Map<String, dynamic> ret = json.decode(response.body.toString().trim());
    print("clientInfo = "+ret["data"].toString());
    return ret;
  }

 Future<Map<String, dynamic>> akciiInfo(String id) async {
    var queryParameters = {
      'key': g.API_KEY,
      'id': id,
      'tag': 'akcii',
    };
    print("URL = " + Uri.https(g.URL_SERVER, "sezon.php", queryParameters).toString());
    final response = await http.get(Uri.https(g.URL_SERVER, "sezon.php", queryParameters));
    // print('response 1c ' + response.body.toString().trim());
    Map<String, dynamic> ret = json.decode(response.body.toString().trim());
    print("akciiInfo = "+ret["data"].toString());
    return ret;
  }

 Future<Map<String, dynamic>> cardInfo(String phone) async {
    phone=phone.replaceAll(new RegExp(r"\s+"), "").replaceAll("+7", "");
    var queryParameters = {
      'key': g.API_KEY,
      'phone': phone,
      'tag': 'card',
    };
    print("URL = " + Uri.https(g.URL_SERVER, "sezon.php", queryParameters).toString());
    final response = await http.get(Uri.https(g.URL_SERVER, "sezon.php", queryParameters));
    // print('response 1c ' + response.body.toString().trim());
    Map<String, dynamic> ret = json.decode(response.body.toString().trim());
    print("clientInfo = "+ret["data"].toString());
    return ret;
  }

 Future<Map<String, dynamic>> check(String phone) async {
    phone=phone.replaceAll(new RegExp(r"\s+"), "").replaceAll("+7", "");
    var queryParameters = {
      'key': g.API_KEY,
      'phone': phone,
      'tag': 'check',
    };
    print("URL = " + Uri.https(g.URL_SERVER, "sezon.php", queryParameters).toString());
    final response = await http.get(Uri.https(g.URL_SERVER, "sezon.php", queryParameters));
// print('response 1c ' + response.body.toString().trim());
    Map<String, dynamic> ret = json.decode(response.body.toString().trim());
    print("clientInfo = "+ret["data"].toString());
    return ret;
  }

 Future<Map<String, dynamic>> bonus(String phone) async {
    phone=phone.replaceAll(new RegExp(r"\s+"), "").replaceAll("+7", "");
    var queryParameters = {
      'key': g.API_KEY,
      'phone': phone,
      'tag': 'bonus',
    };
    print("URL = " + Uri.https(g.URL_SERVER, "sezon.php", queryParameters).toString());
    final response = await http.get(Uri.https(g.URL_SERVER, "sezon.php", queryParameters));
    // print('response 1c ' + response.body.toString().trim());
    Map<String, dynamic> ret = json.decode(response.body.toString().trim());
    print("clientInfo = "+ret["data"].toString());
    return ret;
  }
}