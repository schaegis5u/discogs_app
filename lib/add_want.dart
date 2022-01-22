// ignore_for_file: file_names

import 'dart:io';

import 'package:discogs_app/artiste.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddWant {


}

class AddWantPage extends StatefulWidget {
  const AddWantPage({Key? key, required this.idVer, required this.titre})
      : super(key: key);

  final int idVer;
  final String titre;

  @override
  State<AddWantPage> createState() => AddWantState();
}

class AddWantState extends State<AddWantPage> {
  int get idV => widget.idVer;

  Future<void> getData() async {
    var response = await http.put(
        Uri.parse('https://api.discogs.com/users/AuSCH/wants/${idV}'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Discogs token=LqXFmMYSllUgcVDXbLarAqGYjDhEaTdkNVQdrsFg'
        });
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
        title: Text("Ajouté : " + widget.titre),
      ),
      drawer: Menu(context),
    );
  }
}
