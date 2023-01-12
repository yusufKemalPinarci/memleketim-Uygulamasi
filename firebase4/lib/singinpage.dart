import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'adminpage.dart';
import 'loginpage.dart';
import 'normalpage.dart';

enum SingingCharacter { admin, normal }

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = new TextEditingController();

  TextEditingController sifreController = new TextEditingController();
  SingingCharacter? _character = SingingCharacter.normal;
  String deger = "normal";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("kayıt sayfası"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.login_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));}







              // do something
              ,
            )
          ],),
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
                ListTile(
                  title: const Text('normal'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.normal,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        deger = "normal";
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('admin'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.admin,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        deger = "admin";
                        _character = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text;
                      String password = sifreController.text;
                      try {
                        UserCredential kullanicikimlik = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                            email: email, password: password);
                        var kullanici = kullanicikimlik.user;
                        print(kullanici.toString());
                        FirebaseFirestore.instance.collection('kullanicilar')
                            .add({
                          'mail': email,
                          'sifre': password,
                          'tip': deger,
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                        } catch (e)
                        {
                          print("HATAAAAA $e");
                        }
                      },
                    child: Text("kullanıcı oluştur"))
              ],
            ),
          )),
    );
  }
}