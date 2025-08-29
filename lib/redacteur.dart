// lib/redacteur.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Redacteur {
  final String id;
  final String nom;
  final String specialite;

  // Constructeur de la classe
  Redacteur({
    required this.id,
    required this.nom,
    required this.specialite,
  });

  // Méthode pour créer un objet Redacteur à partir d'un Document Firestore
  factory Redacteur.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Redacteur(
      id: snapshot.id,
      nom: data?['nom'] ?? '',
      specialite: data?['specialite'] ?? '',
    );
  }

  // Méthode pour convertir un objet Redacteur en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'nom': nom,
      'specialite': specialite,
    };
  }
}