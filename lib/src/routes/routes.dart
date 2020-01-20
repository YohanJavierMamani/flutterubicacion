import 'package:aplicacionreto/src/pages/alert_page.dart';
import 'package:aplicacionreto/src/pages/avatar_page.dart';
import 'package:aplicacionreto/src/pages/codigo.dart';
import 'package:aplicacionreto/src/pages/home_page.dart';
import 'package:aplicacionreto/src/pages/lecturas.dart';
import 'package:aplicacionreto/src/pages/mapa.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => FireBaseFireStoreDemo(),
    'lecturas' : (BuildContext context) => LecturasPage(),
    'qr': (BuildContext context) => FireBaseFireStoreDemo(),
    'barras': (BuildContext context) => FireBaseFireStoreDemo(),
    'codigos': (BuildContext context) => CodigoPage(),
    'mapa': (BuildContext context) => MapaPage(),
  };
}
