import 'package:flutter/material.dart';
import 'package:streaming_app/firestore_service.dart';
import 'package:streaming_app/redacteur.dart';
import 'package:streaming_app/ajouter_redacteur_page.dart';
import 'package:streaming_app/modifier_redacteur_page.dart'; // Importez la page de modification

class ListeRedacteursPage extends StatefulWidget {
  const ListeRedacteursPage({Key? key}) : super(key: key);

  @override
  _ListeRedacteursPageState createState() => _ListeRedacteursPageState();
}

class _ListeRedacteursPageState extends State<ListeRedacteursPage> {
  final FirestoreService _firestoreService = FirestoreService();

  void _supprimerRedacteur(BuildContext context, String redacteurId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: const Text('Êtes-vous sûr de vouloir supprimer ce rédacteur ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _firestoreService.removeRedacteur(redacteurId);
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rédacteur supprimé avec succès !')),
                  );
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur lors de la suppression: $e')),
                  );
                }
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Rédacteurs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AjouterRedacteurPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Redacteur>>(
        stream: _firestoreService.getRedacteurs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun rédacteur trouvé.'));
          }

          final redacteurs = snapshot.data!;

          return ListView.builder(
            itemCount: redacteurs.length,
            itemBuilder: (context, index) {
              final redacteur = redacteurs[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.deepPurple),
                  title: Text(redacteur.nom),
                  subtitle: Text(redacteur.specialite),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Navigue vers la page de modification en passant l'objet du rédacteur
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ModifierRedacteurPage(redacteur: redacteur),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Appelle la fonction de suppression
                          _supprimerRedacteur(context, redacteur.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}