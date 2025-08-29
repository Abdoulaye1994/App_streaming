import 'package:flutter/material.dart';
import 'package:streaming_app/firestore_service.dart';
import 'package:streaming_app/redacteur.dart';
import 'package:uuid/uuid.dart';

class AjouterRedacteurPage extends StatefulWidget {
  const AjouterRedacteurPage({Key? key}) : super(key: key);

  @override
  _AjouterRedacteurPageState createState() => _AjouterRedacteurPageState();
}

class _AjouterRedacteurPageState extends State<AjouterRedacteurPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _specialiteController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void dispose() {
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }

  Future<void> _enregistrerRedacteur() async {
    if (_formKey.currentState!.validate()) {
      // Génère un ID unique pour le nouveau rédacteur
      final newId = const Uuid().v4();
      final newRedacteur = Redacteur(
        id: newId,
        nom: _nomController.text,
        specialite: _specialiteController.text,
      );

      try {
        await _firestoreService.setRedacteur(newRedacteur);
        // Affiche une boîte de dialogue de succès
        _showSuccessDialog();
      } catch (e) {
        // Affiche une boîte de dialogue d'erreur si l'enregistrement échoue
        _showErrorDialog(e.toString());
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Succès !'),
          content: const Text('Le rédacteur a été ajouté avec succès.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
                Navigator.of(context).pop(); // Revient à la page précédente
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erreur !'),
          content: Text('Impossible d\'ajouter le rédacteur. Erreur: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
        title: const Text('Ajouter un rédacteur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _specialiteController,
                decoration: const InputDecoration(labelText: 'Spécialité'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une spécialité';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _enregistrerRedacteur,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}