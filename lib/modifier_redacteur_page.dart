import 'package:flutter/material.dart';
import 'package:streaming_app/firestore_service.dart';
import 'package:streaming_app/redacteur.dart';

class ModifierRedacteurPage extends StatefulWidget {
  final Redacteur redacteur;

  const ModifierRedacteurPage({Key? key, required this.redacteur}) : super(key: key);

  @override
  _ModifierRedacteurPageState createState() => _ModifierRedacteurPageState();
}

class _ModifierRedacteurPageState extends State<ModifierRedacteurPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomController;
  late final TextEditingController _specialiteController;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    // Initialise les contrôleurs avec les données du rédacteur
    _nomController = TextEditingController(text: widget.redacteur.nom);
    _specialiteController = TextEditingController(text: widget.redacteur.specialite);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }

  Future<void> _enregistrerModifications() async {
    if (_formKey.currentState!.validate()) {
      final updatedRedacteur = Redacteur(
        id: widget.redacteur.id, // On garde le même ID
        nom: _nomController.text,
        specialite: _specialiteController.text,
      );

      try {
        await _firestoreService.setRedacteur(updatedRedacteur);
        _showSuccessDialog();
      } catch (e) {
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
          content: const Text('Le rédacteur a été mis à jour avec succès.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
                Navigator.of(context).pop(); // Revient à la page de liste
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
          content: Text('Impossible de mettre à jour le rédacteur. Erreur: $error'),
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
        title: const Text('Modifier un rédacteur'),
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
                onPressed: _enregistrerModifications,
                child: const Text('Enregistrer les modifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}