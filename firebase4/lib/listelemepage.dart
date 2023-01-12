import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase4/yereklepage.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("admin sayfası")),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>YerEklePage()));}),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("yerler").snapshots(),
        builder: (context, snaphot){
          return !snaphot.hasData
              ? CircularProgressIndicator()
              : ListView.builder(
              itemCount: snaphot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot mypost = snaphot.data!.docs[index];
                Future<void> _showChoiseDialog(BuildContext context) {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text(
                              "Silmek istediğinize emin misiniz?",
                              textAlign: TextAlign.center,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                            content: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        firestore.collection("yerler").doc(mypost.id).delete();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Evet",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Vazgeç",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )));
                      });
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _showChoiseDialog(context);
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
                                  backgroundImage: NetworkImage("${mypost['url']}"),
                                  radius: size.height * 0.08,
                                )),
                          ],
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
