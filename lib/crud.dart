import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({Key? key}) : super(key: key);

  @override
  State<CrudPage> createState() => _CrudPageState();
}

final FirebaseFirestore _database = FirebaseFirestore.instance;

class _CrudPageState extends State<CrudPage> {
  @override
  Widget build(BuildContext context) {
    final kitapRef = _database.collection('kitaplar');

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("CLOUD CRUD İŞLEMLERİ "))),
      body: Center(
        child: Column(
          children: [
            Text(
              "VERİLER ",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
