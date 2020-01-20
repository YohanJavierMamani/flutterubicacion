import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class Mapa {
  
  GeoFirePoint coordenadas;
  DocumentReference reference;


  Mapa({this.coordenadas});

  Mapa.fromMap(Map<String, dynamic> map, {this.reference}){
    coordenadas= map["coordenadas"];
  } 

  Mapa.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {'coordenadas': coordenadas};
  }

}