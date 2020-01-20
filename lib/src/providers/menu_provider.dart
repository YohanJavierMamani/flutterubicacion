import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

class _MenuProvider{
   List<dynamic> options = [];


   _MenuProvider(){
     cargarData();
   }

   Future<List<dynamic>>cargarData() async {
     final resp = await rootBundle.loadString('data/menu_opts.json');
          Map dataMap = json.decode(resp);
          print(dataMap['nombreApp']);
          options = dataMap['rutas'];

          return options;
   }


  Future<List<dynamic>>cargarData2() async {
     final resp = await rootBundle.loadString('data/menu_opts.json');
          Map dataMap = json.decode(resp);
          print(dataMap['nombreApp']);
          options = dataMap['rutas2'];
          return options;
   }
}


final menuProvider = new _MenuProvider();