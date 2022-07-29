import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ornek/cariekle.dart';
import 'package:ornek/finans.dart';
import 'package:ornek/pardus.dart';
//import 'dart:html';

//cari hareket eklemek için, bu sayfa hazırlanmıştır.

class finans extends StatefulWidget {
  //DocumentSnapshot docid;
  //finans({required this.docid});

  @override
  State<finans> createState() => _finansState();
}

class _finansState extends State<finans> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController t4 = TextEditingController(); //alacak
  TextEditingController t5 = TextEditingController(); //borç
  TextEditingController t6 = TextEditingController(); //açıklama
  TextEditingController t7 = TextEditingController(); //proje kodu

  ////veri ekleme
  addHareket() {
    Map<String, dynamic> data = {
      'alacak': t4.text,
      "borç": t5.text,
      "açıklama": t6.text,
      "kodu": t7.text,
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('hareket');
    collectionReference.add(
        data); //.then((value) => dataAddSuccess(context)).catchError((error)=>dataAddError(context));
  }

  /* finans() {
    FirebaseFirestore.instance.collection("cariler").doc('cari').set({
      'cari bilgileri': {
        'carigrup': t4.text,
        'cariad': t5.text,
        'bakiye': t6.text,
        'parabirimi': t7.text,
      },
    }).whenComplete(() => print("Cari Eklendi"));
    //burası: map yapısıdır. değişken olarak tanımlanabilir
    // devre dışı bırakıldı, fonksiyon ilave edince eskileri siliyor
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
                  context, MaterialPageRoute(builder: (_) => pardus()));
            },
            child: Text("Hareket Listesi"),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'baslik',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  //expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'icerik',
                  ),
                ),
              ),
            ),
            //container lar üst üste gelmiştir. ölçü ver alt alta al,  bunu çöz
            //expands : true devre dışı bırakılınca düzeldi.
            Container(
              //color: Colors.red.shade400,
              child: Column(
                children: [
                  TextField(
                    //ALACAK
                    textAlign: TextAlign.center,
                    controller: t4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'alacak giriniz',
                    ),
                  ),
                  TextField(
                    //BORÇ
                    textAlign: TextAlign.center,
                    controller: t5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'borç giriniz',
                    ),
                  ),
                  TextField(
                    //gruplandırma
                    textAlign: TextAlign.center,
                    controller: t6,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'açıklama giriniz',
                    ),
                  ),
                  TextField(
                    //AÇIKLAMA
                    textAlign: TextAlign.center,
                    controller: t7,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Proje kodu Giriniz',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => pardus()));
                              },
                              child: Text("LİSTELE")),
                          ElevatedButton(
                              onPressed: addHareket,
                              child: Text("FİNANS_EKLE")),
                          ElevatedButton(onPressed: () {}, child: Text("boş1")),
                          ElevatedButton(onPressed: () {}, child: Text("boş2")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
