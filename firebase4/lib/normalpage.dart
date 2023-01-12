import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase4/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NormalScreen extends StatefulWidget {
  const NormalScreen({Key? key}) : super(key: key);

  @override
  State<NormalScreen> createState() => _NormalScreenState();
}
FirebaseAuth auth = FirebaseAuth.instance;

class _NormalScreenState extends State<NormalScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        title: Text('My App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.login_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              if (auth.currentUser != null){auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));}
              else{
                print("oturum zaten açık değil");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));}
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
                     final Geopoint = mypost['geopoint'] as GeoPoint;

                    Future<void> _showChoiseDialog(BuildContext context) {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text(
                                  "${mypost['bilgi']}",
                                  textAlign: TextAlign.center,
                                ),actions: [
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(Geopoint.latitude, Geopoint.longitude),
                                    zoom: 12.0,
                                  ),

                                  markers: {

                                  Marker(
                                      markerId: MarkerId("marker1"),
                                      position: LatLng(Geopoint.latitude, Geopoint.longitude),
                                      infoWindow: InfoWindow(
                                        title: "Konum",

                                      ),
                                      onTap: () {
                                        // Marker'a tıklandığında yapılacak işlemler
                                      },
                                    ),
                                  },




                                ),),
                            ],
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                                content: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                     ));
                          });
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {

                        },
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
                              onTap: (){
                                _showChoiseDialog(context);

                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
