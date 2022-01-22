// ignore_for_file: file_names

import 'dart:io';

import 'package:discogs_app/add_want.dart';
import 'package:discogs_app/artiste.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Version {
  final int id;
  final String nom;
  final String vignette;
  final String label;
  final String pays;
  final List majorFormat;

  Version({
    required this.id,
    required this.nom,
    required this.vignette,
    required this.label,
    required this.pays,
    required this.majorFormat,
  });

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      id: json['id'],
      nom: json['title'],
      vignette: json['thumb'],
      label: json['label'],
      pays: json['country'],
      majorFormat: json['major_formats'],
    );
  }
}

class VersionPage extends StatefulWidget {
  const VersionPage({Key? key, required this.idOeu, required this.titre})
      : super(key: key);

  final int idOeu;
  final String titre;

  @override
  State<VersionPage> createState() => VersionState();
}

class VersionState extends State<VersionPage> {
  List<Version> versions = [];
  int get idO => widget.idOeu;

  Future<void> getData() async {
    var response = await http.get(
        Uri.parse('https://api.discogs.com/masters/${idO}/versions'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Discogs token=LqXFmMYSllUgcVDXbLarAqGYjDhEaTdkNVQdrsFg'
        });
    print(response.statusCode);
    print(idO);
    if (response.statusCode == 200) {
      setState(() {
        List j = json.decode(response.body)['versions'];
        versions = j.map((obj) => Version.fromJson(obj)).toList();
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
          title: Text("Versions de : " + widget.titre),
        ),
        drawer: Menu(context),
        body: ListView.builder(
            itemCount: versions.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(versions[index].nom),
                  subtitle: Text("Label : " +
                      versions[index].label +
                      " ; Pays : " +
                      versions[index].pays +
                      " ; Format : " +
                      versions[index].majorFormat[0]),
                      onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddWantPage(
                          idVer: versions[index].id, titre: versions[index].nom,
                        ),
                      ));
                },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(versions[index].vignette),
                  ));
            }));
  }
}
