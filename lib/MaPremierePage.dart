import 'package:flutter/material.dart';
import 'package:streaming_app/PartieGrilleImage.dart';
import 'package:streaming_app/ajouter_redacteur_page.dart';
import 'package:streaming_app/liste_redacteurs_page.dart';

class MaPremierePage extends StatefulWidget {
  const MaPremierePage({super.key});

  @override
  State<MaPremierePage> createState() => _MaPremierePageState();
}

class _MaPremierePageState extends State<MaPremierePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Vos émissions en streaming'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.amber),
              child: Text(
                'Menu de Navigation',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Ajouter un rédacteur'),
              onTap: () {
                // Ferme le drawer
                Navigator.pop(context);
                // Navigue vers la page d'ajout
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AjouterRedacteurPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Informations des rédacteurs'),
              onTap: () {
                // Ferme le drawer
                Navigator.pop(context);
                // Navigue vers la page de liste
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListeRedacteursPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const PartieGrilleImage(),
    );
  }
}
