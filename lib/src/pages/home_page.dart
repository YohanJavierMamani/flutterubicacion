import 'package:aplicacionreto/src/providers/menu_provider.dart';
import 'package:aplicacionreto/src/utils/icono_string_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snaphot) {
        print('builder');
        print(snaphot.data);

        return ListView(
          children: _listaItems(snaphot.data, context),
        );
      },
    );

/*   menuProvider.cargarData().then((opciones){
    print(opciones);
  });

  return ListView(
    children: _listaItems(),
      ); */
  }

  List<Widget> _listaItems(List<dynamic> data, context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final WidgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getICon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
            Navigator.pushNamed(context, opt['ruta']);
/*           final route = MaterialPageRoute(builder: (context) {
            return AlertPage();
          });
          Navigator.push(context, route); */
        },
      );

      opciones..add(WidgetTemp)..add(Divider());
    });
    return opciones;
  }
}
