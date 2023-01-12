import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase4/adminpage.dart';
import 'package:firebase4/harita.dart';
import 'package:firebase4/listelemepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

import 'package:flutter/src/widgets/image.dart';
import 'package:image_picker/image_picker.dart';

class YerEklePage extends StatefulWidget {
  double enlem;
  double boylam;

  YerEklePage({this.enlem = 0.0, this.boylam = 0.0}) {}

  @override
  State<YerEklePage> createState() => _YerEklePageState();
}

String mediaUrl = "";

class _YerEklePageState extends State<YerEklePage> {
  late LocationPermission permission;
  TextEditingController bilgiController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  Completer<GoogleMapController> haritakontrol = Completer();
  XFile? resim1;
  String downloadUrl="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          DrawerHeader(
            child: Text("Naber müdür"),
          ),
          ListTile(
            title: Text("profil"),
            trailing: Icon(Icons.person),
          )
        ]),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.blue,
                          width: 4,
                          style: BorderStyle.solid),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                              child: TextField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                      hintText: "başlık giriniz",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white))))),
                          TextField(
                              controller: bilgiController,
                              decoration: InputDecoration(
                                  hintText: "yer hakkında bilgi veriniz",
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)))),
                          resim(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final picker = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  resim1 = XFile(picker!.path);
                                  setState((){
                                    mediaUrl = resim1!.path;
                                  });


                                },
                                child: Icon(Icons.camera_alt),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                child: Icon(Icons.photo_library),
                                onTap: () async{

                                    final picker = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    resim1 = XFile(picker!.path);
                                    setState((){
                                    mediaUrl = resim1!.path;
                                  });

                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HaritaPage()));
                  },
                  child: Text("konum gir")),
              ElevatedButton(
                  onPressed: () async{
                    print(widget.enlem.toString());
                    final FirebaseStorage storage = FirebaseStorage.instance;
                    Reference ref = FirebaseStorage.instance
                        .ref()
                        .child('hello');
                    final uploadTask = ref.putFile(File(mediaUrl));
                     downloadUrl = await ref.getDownloadURL();
                    _addMarker(
                        widget.enlem.toDouble(),
                        widget.boylam.toDouble(),
                        bilgiController.text,
                        titleController.text,
                        downloadUrl
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyWidget()));
                  setState(() {
                    mediaUrl="";
                  });
                    },
                  child: Text("Ekle")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AdminScreen()));
                  },
                  child: Text("anasayfa")),
            ],
          ),
        ],
      ),
    );
  }
}

class resim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (mediaUrl == "") {
      return CircleAvatar(
        radius: 100,
        backgroundColor: Colors.blue,
      );
    } else {
      return CircleAvatar(
        radius: 100,
        backgroundImage: FileImage(File(mediaUrl),scale: 100),

      );
    }
  }
}

void _addMarker(
    double enlem, double boylam, String bilgi, String baslik,String url) async {
  GeoPoint geoPoint = GeoPoint(enlem, boylam);
  FirebaseFirestore.instance.collection('yerler').add(
      {'baslik': baslik, 'bilgi': bilgi, 'geopoint': GeoPoint(enlem,boylam),'url':url});
}
