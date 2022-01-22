// ignore_for_file: file_names

import 'dart:io';

import 'package:discogs_app/artiste.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'version.dart';

class Oeuvre {
  final int id;
  final String nom;
  final String vignette;
  //final int annee;

  Oeuvre(
      {required this.id,
      required this.nom,
      required this.vignette,
      /*required this.annee*/});

  factory Oeuvre.fromJson(Map<String, dynamic> json) {
    return Oeuvre(
      id: json['id'],
      nom: json['title'],
      vignette: json['thumb'],
      //annee: json['year'],
    );
  }
}

class OeuvrePage extends StatefulWidget {
  const OeuvrePage({Key? key, required this.idArt, required this.titre})
      : super(key: key);

  final int idArt;
  final String titre;

  @override
  State<OeuvrePage> createState() => OeuvreState();
}

class OeuvreState extends State<OeuvrePage> {
  List<Oeuvre> oeuvres = [];
  int get idA => widget.idArt;

  Future<void> getData() async {
    var response = await http.get(
        Uri.parse('https://api.discogs.com/artists/${idA}/releases?sort=year&per_page=100'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Discogs token=LqXFmMYSllUgcVDXbLarAqGYjDhEaTdkNVQdrsFg'
        });
    if (response.statusCode == 200) {
      setState(() {
        List j = json.decode(response.body)['releases'];
        oeuvres = j.map((obj) => Oeuvre.fromJson(obj)).toList();
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Oeuvres de : " + widget.titre),
        ),
        drawer: Menu(context),
        body: ListView.builder(
            itemCount: oeuvres.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(oeuvres[index].nom),
                  onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VersionPage(
                          idOeu: oeuvres[index].id, titre: oeuvres[index].nom,
                        ),
                      ));
                },
                  //subtitle: ('Année de sortie : ${oeuvres[index].annee}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(oeuvres[index].vignette),
                  ));
            }));
  }
}
