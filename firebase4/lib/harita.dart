import 'dart:async';

import 'package:firebase4/yereklepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HaritaPage extends StatefulWidget {
  const HaritaPage({Key? key}) : super(key: key);

  @override
  State<HaritaPage> createState() => _HaritaPageState();
}

class _HaritaPageState extends State<HaritaPage> {
  double enlem = 0.0;
  double boylam = 0.0;
  List<Marker> isaret = <Marker>[];
  TextEditingController bilgiController = new TextEditingController();
  Completer<GoogleMapController> haritakontrol = Completer();
  var ilkkonum =
      CameraPosition(target: LatLng(38.7412482, 26.1844276), zoom: 4);
  late LocationPermission permission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
            width: 400,
            height: 300,
            child: GoogleMap(onTap: (LatLng location){
              setState(() {
                enlem=location.latitude;
                boylam=location.longitude;
                print(enlem.toString()+boylam.toString());
              });
            },
              initialCameraPosition: CameraPosition(
                target: LatLng(41.017657, 28.965752),
                zoom: 12.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("marker1"),
                  position: LatLng(enlem, boylam),
                  infoWindow: InfoWindow(
                    title: "Konum",
                    snippet: "Enlem: $enlem, Boylam: $boylam",
                  ),
                  onTap: () {
                    // Marker'a tıklandığında yapılacak işlemler
                  },
                ),
              },




            ),),
        ElevatedButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>YerEklePage(enlem:enlem ,boylam: boylam,)));
        }, child: Text("markeri ekle"))
      ]),
    );
  }
}


