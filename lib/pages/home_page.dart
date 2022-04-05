import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Caverna do Tesouro',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: const [
              ListTile(
                title: Text('Água'),
                subtitle: Text('R\$ 250'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chat');
            },
            child: const Text('Nova Atividade'),
          ),
        ],
      ),
    );
  }
}
