import 'package:aplicacionreto/src/cloudstore/mapa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:rxdart/rxdart.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: Scaffold(body: FireMap()));
  }
}

class FireMap extends StatefulWidget {
  @override
  State createState() => FireMapState();
}

class FireMapState extends State<FireMap> {
  BitmapDescriptor customIcon;
  GoogleMapController mapController;
  final Set<Marker> _markers = {};
  static const _initialPosition = LatLng(12.97, 77.58);
  Location location = new Location();  
  Location locacion = new Location();
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  BehaviorSubject<double> radius = BehaviorSubject.seeded(100.0);
  Stream<dynamic> query;
  StreamSubscription subscription;
  LatLng _lastPosition = _initialPosition;
  double lati;
  double longi;
  var cadena = "Usuario Anonimo";
  bool ubicacion=false;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //DATOS DEL CRUDDDDDDDDDDDDDDDD
  bool showTextField = false;
  TextEditingController controller = TextEditingController();
  String collectionName = "ub";
  bool isEditing = false;
  Mapa mapaindividual;


  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/ubicacion.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  build(context) {
    createMarker(context);
    return Stack(children: [
      GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(-12.0881764, -77.0144123), zoom: 16),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
        mapType: MapType.normal,
        markers: Set<Marker>.of(markers.values),
        compassEnabled: true,
      ),
      Positioned(
          bottom: 50,
          right: 10,
          child: FlatButton(
              child: Icon(Icons.pin_drop, color: Colors.white),
              color: Colors.green,
              onPressed: () => _addMarker() )),
      Positioned(
          bottom: 50,
          left: 10,
          child: Slider(
              min: 100.0,
              max: 500.0,
            divisions: 10,
            value: radius.value,
            label: 'Radius ${radius.value}km',
            activeColor: Colors.green,
            inactiveColor: Colors.green.withOpacity(0.2),
            onChanged: _updateQuery,
          ))
    ]);


  }

  void _onMapCreated(GoogleMapController controller) {
    //_verificarubicacion();
    _startQuery();  
    setState(() {
      mapController = controller;
    });
  }

  /*   _addMarker() {
            var marker = Marker(
                position: mapController.cameraPosition.target,
                icon: BitmapDescriptor.defaultMarker,
                infoWindowText: InfoWindowText('Magic Marker', '🍄🍄🍄'));
            mapController.addMarker(marker);
          } */

  _addMarker() async {
    /*print("Documents");
              _startQuery();
              _addGeoPoint();
              _insertadatos();*/
    
    print("Documents");
    var markerIdVal = "123";
    final MarkerId markerId = MarkerId(markerIdVal);
    _animateToUser();
    var marker = Marker(
        markerId: markerId,
        position: LatLng(lati, longi),
        icon: customIcon,
        infoWindow: InfoWindow(title: 'USUARIO: $cadena', snippet: 'CARGO: Analista Asistente de TI'));
   
    _startQuery();
     setState(() {
      markers[markerId] = marker;
    });

/*             setState(() {
              _markers.add(Marker(
                  markerId: MarkerId(_lastPosition.toString()),
                  position: _lastPosition,
                  infoWindow: InfoWindow(title: "Se encuentra Aquí", snippet: "🍄🍄🍄"),
                  icon: BitmapDescriptor.defaultMarker));
            }); */
  }


  _agregarMarkers() async {
    /*print("Documents");
              _startQuery();
              _addGeoPoint();
              _insertadatos();*/
    print("Documents");
    var markerIdVal = "123";
    final MarkerId markerId = MarkerId(markerIdVal);
    _animateToUser();
    var marker = Marker(
        markerId: markerId,
        position: LatLng(lati, longi),
        icon: customIcon,
        infoWindow: InfoWindow(title: 'USUARIO: $cadena', snippet: 'CARGO: Analista Asistente de TI'));
    setState(() {
      markers[markerId] = marker;
    });

/*             setState(() {
              _markers.add(Marker(
                  markerId: MarkerId(_lastPosition.toString()),
                  position: _lastPosition,
                  infoWindow: InfoWindow(title: "Se encuentra Aquí", snippet: "🍄🍄🍄"),
                  icon: BitmapDescriptor.defaultMarker));
            }); */
  }




  _animateToUser() async {
    var pos = await location.getLocation();
    lati = pos.latitude;
    longi = pos.longitude;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 17.0,
    )));
  }

  _insertadatos() async {

    var pos = await location.getLocation();
    GeoFirePoint point =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);
    Mapa mapas = Mapa(coordenadas: point);

    ///////////////////////
    /*   Firestore.instance
                            .collection('users')
                            .document("EXACTS")
                            .collection('Locations')
                            .document()
                        .setData({
                          "position": point.data
                        }); */
    ////////////////////////////
    try {
      Firestore.instance.runTransaction(
        (Transaction transaction) async {
          await Firestore.instance
              .collection(collectionName)
              .document()
              .setData({"position": point.data});
        },
      );
    } catch (e) {
      print(e.toString());
    }
  
  }

  _insertadatos2() {
    print("Documents");
    var markerIdVal = "123";
    final MarkerId markerId = MarkerId(markerIdVal);
    _animateToUser();

    var marker = Marker(
        markerId: markerId,
        position: LatLng(lati, longi),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Magic Marker', snippet: '🍄🍄🍄'));
    setState(() {
      markers[markerId] = marker;
    });
  }

  Future<DocumentReference> _addGeoPoint() async {
    var pos = await location.getLocation();

    GeoFirePoint point =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);

    Firestore.instance
        .collection('locationss')
        .document()
        .setData({"position": point.data});

    return firestore
        .collection('locations')
        .add({'position': point.data, 'name': 'Yay I can be queried!'});
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    print(documentList);
    
      markers.clear();

    String a = "EXACT";
    int num = 0;

    documentList.forEach((DocumentSnapshot document) {
      num++;
      final MarkerId markerId = MarkerId(a+"$num");
      GeoPoint pos = document.data['position']['geopoint'];
      var nombre = document.data['name'];
/*       var xd = Firestore.instance.collection("group").document().get();
 */      double distance = document.data['distance'];
        var marker = Marker(
        position: LatLng(pos.latitude, pos.longitude),
        icon: customIcon,
        infoWindow: InfoWindow(title: "USUARIO : $nombre", snippet: "CARGO: Analista Asistente de TI 🍄"),
        markerId: markerId
      );
      
      /////////MODIFICANDO POR SIACA
      if(cadena!=nombre){
      setState(() {
      markers[markerId] = marker;
      });
      }

    });
  }

  void listarmarkets(List<DocumentSnapshot> documentList) {
    print(documentList);
    _markers.clear();
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint pos = document.data['position']['geopoint'];
      double distance = document.data['distance'];
      var marker = Marker(
        position: LatLng(pos.latitude, pos.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Otro", snippet: "🍄🍄🍄"),
        markerId: null,
      );
      _markers.add(marker);
    });
  }





  _startQuery() async {
    // Get users location
    

     print("Deberíabicación");
    
    var pos = await location.getLocation();
    double lat = pos.latitude;
    double lng = pos.longitude;
    // Make a referece to firestore
    var ref = Firestore.instance.collection(collectionName);
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
    // subscribe to query
    subscription = radius.switchMap((rad) {
      //var collection = geo.collection(collectionRef: ref);
      return geo.collection(collectionRef: ref).within(
          center: center, radius: rad, field: 'position', strictMode: true);
    }).listen(_updateMarkers);
  }

  @override
  initState() {
    super.initState();
    locacion = new Location();
    /* var pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
 */
    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    locacion.onLocationChanged().listen((LocationData currentLocation) {
        print("Es mi camino ninja");
        _verificarubicacion();
    });
  }

  _updateQuery(value) {
    setState(() {
      radius.add(value);
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  _verificarubicacion() {
    if(ubicacion==false){
      print("INGRESAR A AGREGAR UBICACIÓN");
        _agregarubicacion();
    }else{
      print("INGRESAR A MODIFICAR UBICACIÓN");
        _modificarubicacion();
    }
  }


/*   update(User user, String newName) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(user.reference, {'name': newName});
      });
    } catch (e) {
      print(e.toString());
    }
  } */

  _modificarubicacion() async {

    print("Ingreso a modificar");  

    var pos = await location.getLocation();

    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);

    DocumentReference traer = await Firestore.instance.collection(collectionName).document(cadena);
    
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(traer, {
          'name': cadena,
          'position': point.data
          });
      });
    } catch (e) {
      print(e.toString());
    }


  }  




  /* Future<DocumentReference> */ 
   _agregarubicacion() async {
    print("continua");  
    var pos = await location.getLocation();
    print("POINT");  
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);


    var traer = await Firestore.instance.collection(collectionName).getDocuments();

    try{
    if(traer.documents[0] != null){
        //cadena = "probandoII";
        print(  traer.documents.length );
        var cantidaddoc = traer.documents.length+1;
        var numerodocumentos = cantidaddoc.toString(); 
        print( "Número de documentos $numerodocumentos");

        cadena = "Usuario Anonimo $numerodocumentos";
    }
    }catch(e){
        print("Hubo un error");
    }


    try {
      Firestore.instance.runTransaction(
        (Transaction transaction) async {
          await Firestore.instance
              .collection(collectionName)
              .document(cadena)
              .setData({
                "name": cadena,
                "position": point.data
                });
        },
      );
      ubicacion= true;
    } catch (e) {
      print(e.toString());
    }
  }
}


