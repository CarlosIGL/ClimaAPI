import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/openwheater.dart';
import 'package:proyecto_final/models/openwheaterdayli.dart';

class OpenWheater extends ChangeNotifier{
  String city = '';
  final String _urlBase = 'api.openweathermap.org';
  final String _apiKey = '644e9b7fdec26a462e22438318bc7d9e';

  String temAmbienteC = '';
  String ciudad = '';
  String velocidad = '';
  String humedad = '';
  String pais = '';
  int timeZone = 0;
  List<ListElement> tempManiana =[];

  List<Weather> condiciones = [];
  OpenWheater({required this.city}){
    getService();
  }
  
  getService() async{
    var ciudadABuscar = city;
    if(ciudadABuscar.isEmpty){
      ciudadABuscar = 'Ensenada';
    }
    final url = Uri.http(_urlBase, 'data/2.5/weather',{'q':ciudadABuscar,'appid':_apiKey});
    final urlDayli = Uri.http(_urlBase, 'data/2.5/forecast',{'q':ciudadABuscar,'appid':_apiKey});
    final respuesta = await http.get(url);
    final respuesta2 = await http.get(urlDayli);
    final clima = Welcome.fromJson(respuesta.body);
    final clima2 = Climas.fromJson(respuesta2.body);

    //------------------Clima Actual----------------------------------------//
    int tempAmbienteCen = (clima.main.feelsLike.toDouble() -273.15).toInt() ;
    pais = clima.sys.country;
    condiciones = clima.weather;
    temAmbienteC = tempAmbienteCen.toString();
    ciudad = clima.name;
    humedad = clima.main.humidity.toString();
    velocidad = (clima.wind.speed *3.6).toInt().toString();
    timeZone = clima.timezone;
    //---------------------Clima Proximas horas------------------------------//
    tempManiana = clima2.list;

    notifyListeners();
  }
}