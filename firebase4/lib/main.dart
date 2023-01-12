import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase4/anasayfa.dart';
import 'package:firebase4/deneme.dart';
import 'package:firebase4/loginpage.dart';
import 'package:firebase4/singinpage.dart';
import 'package:firebase4/yerguncelle.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'adminpage.dart';
import 'listelemepage.dart';
import 'normalpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:  YerGuncellePage()));
}
