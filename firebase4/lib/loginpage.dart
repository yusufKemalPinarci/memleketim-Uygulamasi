import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase4/listelemepage.dart';
import 'package:firebase4/singinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'adminpage.dart';
import 'normalpage.dart';

enum SingingCharacter { admin, normal }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();

  TextEditingController sifreController = new TextEditingController();
  SingingCharacter? _character = SingingCharacter.normal;
  String deger = "normal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Center(child: Text("Memleketim Uygulaması"))),
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    label: Text("email"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                obscureText: true,
                controller: sifreController,
                decoration: InputDecoration(
                    label: Text("password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = sifreController.text;
                  UserCredential giriskullanici = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password);

                  final querySnapshot = await FirebaseFirestore.instance
                      .collection('kullanicilar')
                      .where('mail', isEqualTo: email)
                      .get();

                  if (querySnapshot.docs.isEmpty) {
                    // Kullanıcı adı veya şifre hatalı
                  } else {
                    final userType = querySnapshot.docs[0]['tip'];
                    if (userType == 'admin') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminScreen(),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NormalScreen(),
                        ),
                      );
                    }
                  }
                },
                child: Text("Giriş Yap")),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninScreen()));
                },
                child: Text("kullanıcı oluşturr"))
          ],
        ),
      ));

  }
}
