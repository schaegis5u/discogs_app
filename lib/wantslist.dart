import 'package:flutter/material.dart';
import 'menu.dart';

void main() {
  runApp(const WantsList());
}

class WantsList extends StatelessWidget {
  const WantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WantsList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WantsPage(title: 'Wantslist'),
    );
  }
}

class WantsPage extends StatefulWidget {
  const WantsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WantsPage> createState() => WantsState();
}

class WantsState extends State<WantsPage> {
  TextEditingController _ctrlRecherche = TextEditingController();

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
      ),
      drawer: Menu(context),
    );
  }
}
