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
    final CollectionReference kitapRef = _database.collection('kitaplar');
    //final hobbitRef = _database.collection('kitaplar').doc('Hobbit');
    final hobbitRef = kitapRef.doc('Hobbit');

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("CLOUD CRUD İŞLEMLERİ "))),
      body: Center(
        child: Column(
          children: [
            Text(
              "VERİLER ",
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            Text(
              "${kitapRef.id} ile ${hobbitRef.path} ",
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () async {
                DocumentSnapshot documentSnapshot = await hobbitRef.get();
                Object? data = documentSnapshot.data();
                print(data);

                // Koleksiyon referansı ile get metodu

                QuerySnapshot collectionSnapshot = await kitapRef.get();
                List<DocumentSnapshot> docs = collectionSnapshot.docs;
                print(docs.length);
                print(docs[1]);
                docs.forEach((e) {
                  print(e['yazar']);
                });
              },
              child: Text("GET DATA"),
            ),
            StreamBuilder(

                ///stream akışı 3 durumu
                ///1.hata gelmiş, oluşmuş
                ///2.veri bekleniyor.
                ///3. veri geldi ve kullanılabilir.
                stream: hobbitRef.snapshots(),
                builder: (context, AsyncSnapshot snap) {
                  if (snap.hasError) {
                    return Center(
                      child: Text('BİR HATA OLUSTU'),
                    );
                  } else {
                    if (!snap.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    // asyncsnapshot içinden önce documentsnapshot çıkarılacak
                    // sonra document içinden mapi çıkarıcaz.

                    var documentSnapshot = snap.data;

                    print("veri değişimi oldu");
                    return Text('${snap.data['yazar']}');
                  }
                })
          ],
        ),
      ),
    );
  }
}
