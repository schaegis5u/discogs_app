import 'dart:io';

import 'package:flutter/material.dart';
import 'Oeuvre.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Artiste {
  final int id;
  final String nom;
  final String vignette;

  Artiste({required this.id, required this.nom, required this.vignette});

  factory Artiste.fromJson(Map<String, dynamic> json) {
    return Artiste(
      id: json['id'],
      nom: json['title'],
      vignette: json['thumb'],
    );
  }
}

class ArtistePage extends StatefulWidget {
  const ArtistePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ArtistePage> createState() => ArtisteState();
}

class ArtisteState extends State<ArtistePage> {
  TextEditingController _ctrlRecherche = TextEditingController();
  List<Artiste> artistes = [];

  Future<void> getData() async {
    var response = await http.get(
        Uri.parse(
            'https://api.discogs.com/database/search?q=${_ctrlRecherche.text}&type=artist&per_page=100'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Discogs token=LqXFmMYSllUgcVDXbLarAqGYjDhEaTdkNVQdrsFg'
        });
    if (response.statusCode == 200) {
      setState(() {
        List j = json.decode(response.body)['results'];
        artistes = j.map((obj) => Artiste.fromJson(obj)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _ctrlRecherche.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            SizedBox(
                width: 150,
                child: TextFormField(
                  controller: _ctrlRecherche,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    getData();
                  });
                },
                icon: const Icon(Icons.search))
          ],
        ),
        drawer: Menu(context),
        body: ListView.builder(
            itemCount: artistes.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(artistes[index].nom),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OeuvrePage(
                          idArt: artistes[index].id, titre: artistes[index].nom,
                        ),
                      ));
                },
                 leading: CircleAvatar(
                          backgroundImage: NetworkImage(artistes[index].vignette),
              ))
              ;
            }));
  }
}
