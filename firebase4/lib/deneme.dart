import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import
'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Anasayfa(),
    );
  }
}
class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);
  @override
  _AnasayfaState createState() => _AnasayfaState();
}
class _AnasayfaState extends State<Anasayfa> {
  //AIzaSyAb5Q_Uf3JFGpcBIhTvqgsGC02YRSNqp1Y eskisi
//AIzaSyCt5U1QNDFhTMb80UwaEv4N64cSyyx058c
  double enlem=0.0;
  double boylam=0.0;
  late LocationPermission permission;
  Completer<GoogleMapController> haritakontrol=Completer();
  var ilkkonum=CameraPosition(target: LatLng(38.7412482,26.1844276), zoom: 4);
  List<Marker> isaret=<Marker>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("Enlem = $enlem", style: TextStyle(fontSize: 25),),
            Text("Boylam = $boylam", style: TextStyle(fontSize: 25),),
            ElevatedButton(onPressed: () async{
              permission = await Geolocator.checkPermission();
              print(permission);
              if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();}
              print(permission);
              await Geolocator.getPositionStream().listen((event) { });
              var konum=await Geolocator.getCurrentPosition(desiredAccuracy:
              LocationAccuracy.high);
              setState(() {
                enlem=konum.latitude;
                boylam=konum.longitude;
              });
            }, child: Text("Konum Al")),
            SizedBox(width: 400, height: 300,
              child: GoogleMap(initialCameraPosition: ilkkonum,
                mapType: MapType.normal,
                markers: Set<Marker>.of(isaret),
                myLocationButtonEnabled: true,
                myLocationEnabled:true,
                onMapCreated: (GoogleMapController controller){
                  haritakontrol.complete(controller);
                },),
            ),
            ElevatedButton(onPressed: () async {
              GoogleMapController kontrol=await haritakontrol.future;
              var gidilecekkonum=CameraPosition(target:
              LatLng(37.871540,32.498914), zoom: 8);

              kontrol.animateCamera(CameraUpdate.newCameraPosition(gidilecekkonum));
              var gidilecekisaret= Marker(markerId: MarkerId("Id"),
                position: LatLng(37.871540,32.498914),
                infoWindow: InfoWindow(title: "KONYA", snippet: "Okul"),
                //draggable: true,
              );
              setState(() {
                isaret.add(gidilecekisaret);
                print(isaret);
              });
            }, child: Text("Konuma Git")),
          ],
        ),
      ),
    );
  }
}
