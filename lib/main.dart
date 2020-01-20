import 'package:aplicacionreto/src/pages/alert_page.dart';
import 'package:aplicacionreto/src/routes/routes.dart';
import 'package:flutter/material.dart';
 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      //home: HomePage()
      initialRoute: '/',  
      routes: getAplicationRoutes(),
      onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: ( BuildContext context ) =>AlertPage()
        );
      },

    );
  }
}