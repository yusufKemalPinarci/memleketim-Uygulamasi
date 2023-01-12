import 'package:flutter/material.dart';

class AnasayfaPage extends StatefulWidget {
  const AnasayfaPage({Key? key}) : super(key: key);

  @override
  State<AnasayfaPage> createState() => _AnasayfaPageState();
}

class _AnasayfaPageState extends State<AnasayfaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ElevatedButton(onPressed: () async {
          Map<String, dynamic> data = Map();
          data["bilgi"] = "Ali";
          data["yas"] = 70;
        }, child: Text("veri ekle"),)
      ]),
    );
  }
}
