import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase4/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class YerGuncellePage extends StatefulWidget {
  const YerGuncellePage({Key? key}) : super(key: key);

  @override
  State<YerGuncellePage> createState() => _YerGuncellePageState();
}

FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController baslikController = TextEditingController();
bool tetik = false;

class _YerGuncellePageState extends State<YerGuncellePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  double enlem = 0.0;
  double boylam = 0.0;
  List<Marker> isaret = <Marker>[];
  Completer<GoogleMapController> haritakontrol = Completer();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController bilgiController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.login_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              if (auth.currentUser != null) {
                auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              } else {
                print("oturum zaten açık değil");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            }

            // do something
            ,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("yerler").snapshots(),
        builder: (context, snaphot) {
          return !snaphot.hasData
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: snaphot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snaphot.data!.docs[index];
                    GeoPoint geopoint = mypost['geopoint'] as GeoPoint;

                    Future<void> _showChoiseDialog(BuildContext context) {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: TextField(
                                  decoration: InputDecoration(
                                      hintText: "${mypost['baslik']}")),
                              content: Column(children: [
                                SizedBox(
                                  width: 400,
                                  height: 300,
                                  child: GoogleMap(
                                    onTap: (LatLng location) {
                                      setState(() {
                                        enlem = location.latitude;
                                        boylam = location.longitude;
                                        print(enlem.toString() +
                                            boylam.toString());


                                      });
                                    },
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(geopoint.latitude, geopoint.longitude),
                                      zoom: 12.0,
                                    ),
                                    markers: {
                                      Marker(
                                        markerId: MarkerId("${mypost["baslik"]}"),
                                        position: LatLng(geopoint.latitude, geopoint.longitude),
                                        infoWindow: InfoWindow(
                                          title: "${mypost["baslik"]}",
                                        ),
                                        onTap: () {
                                          // Marker'a tıklandığında yapılacak işlemler
                                        },
                                      ),
                                    },
                                  ),
                                ),

                              ]),
                              actions: [ ElevatedButton(onPressed: (){
                                setState(() {
                                  FirebaseFirestore.instance.collection('yerler').doc(mypost.id).update({'geopoint': new GeoPoint(enlem, boylam)},);
                                  Navigator.pop(context);
                                });


                              }, child: Text("guncelle"))],
                            );
                          });
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: size.height * .3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                               _showChoiseDialog(context);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${mypost['baslik']}",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                      child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage("${mypost['url']}"),
                                    radius: size.height * 0.08,
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}

class Pencere extends StatefulWidget {
  @override
  State<Pencere> createState() => _PencereState();
}

class _PencereState extends State<Pencere> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (tetik == true) {
      return ExpansionTile(
        title: Text("Form"),
        children: <Widget>[
          // Form widgetları
        ],
      );
    } else {
      return ExpansionTile(
        title: Text("Form"),
        children: <Widget>[
          Card(
            child: Text("fdsafsd"),
          )

          // Form widgetları
        ],
      );
    }
  }
}
