import 'package:discogs_app/artiste.dart';
import 'package:discogs_app/main.dart';
import 'package:discogs_app/wantslist.dart';
import 'package:flutter/material.dart';
import 'barcode.dart';

Drawer Menu(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          title: Text('Accueil des artistes'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (ArtistePage(
                    title: 'Artistes',
                  )),
                ));
          },
        ),
        ListTile(
          title: Text('Wantslist'),
          leading: Icon(Icons.movie),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (WantsPage(
                    title: 'Wantslist',
                  )),
                ));
          },
        ),
        ListTile(
          title: Text('Code-barre'),
          leading: Icon(Icons.code),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (BarCodePage()),
                ));
          },
        ),
      ],
    ),
  );
}
