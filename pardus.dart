import 'package:ornek/finans.dart';

import 'cariekle.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//liste yapar tablo olrak göstermek için bu sayfa hazırlanmıştır.

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class pardus extends StatefulWidget {
  @override
  _pardusState createState() => _pardusState();
}

class _pardusState extends State<pardus> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('cariler').snapshots();
  /*TextEditingController t1 = TextEditingController();
  TextEditingController carigrubu = TextEditingController();
  TextEditingController cariname = TextEditingController();
  TextEditingController paraBirimi = TextEditingController();

  ////veri ekleme
  addCari(context) {
    Map<String, dynamic> data = {
      'carigrup': carigrubu,
      "cariname": cariname.value,
      "amount": 0,
      "currency": paraBirimi.value,
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('cariler');
    collectionReference.add(
        data); //.then((value) => dataAddSuccess(context)).catchError((error)=>dataAddError(context));
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Iskele()));
            },
            child: Text("Test Menu"),
          ),
        ],
      ),
//BODY KISMI
      body: Container(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('cariler')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                        // margin: EdgeInsets.only(left: displayWidth(context)*0.5,top: displayHeight(context)*0.5),
                        child: CircularProgressIndicator());
                  }
                  return new DataTable(
                    columns: <DataColumn>[
                      new DataColumn(
                        label: Text('Name Group'),
                      ),
                      new DataColumn(
                        label: Text('Name'),
                      ),
                      new DataColumn(
                        label: Text('Balance'),
                      ),
                      new DataColumn(
                        label: Text('Current Unit'),
                      ),
                      new DataColumn(
                        label: Text('EditName'),
                      ),
                      new DataColumn(
                        label: Text('AddMoney'),
                      ),
                      new DataColumn(
                        label: Text('Delete'),
                      ),
                    ],
                    rows: _createRows(snapshot.data!, context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////_createRows FONKSİYONU/////////////////
List<DataRow> _createRows(QuerySnapshot snapshot, context) {
  List<DataRow> newList =
      snapshot.docs.map((DocumentSnapshot documentSnapshot) {
    return new DataRow(cells: [
      DataCell(Text(documentSnapshot['carigrup'].toString())),
      DataCell(Text(documentSnapshot['cariname'].toString())),
      DataCell(Text(documentSnapshot['amount'].toString())),
      DataCell(Text(documentSnapshot['currency'].toString())),
      DataCell(IconButton(
        onPressed: () {
          print("DÜZENLEME BUTONU başarılı");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => cariekle()));
        },
        icon: Icon(
          Icons.edit,
          color: Colors.blue,
        ),
      )),
      DataCell(IconButton(
        onPressed: () {
          print("DÜZENLEME BUTONU başarılı");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => finans()));
        },
        icon: Icon(
          Icons.edit_attributes,
          color: Color.fromARGB(255, 35, 240, 8),
        ),
      )),
      // ignore: prefer_const_constructors
      DataCell(
        IconButton(
          onPressed: () {
            print("sil butonu çalışıyor");
          },
          iconSize: 20,
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    ]);
  }).toList();

  return newList;
}
