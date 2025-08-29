

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streaming_app/redacteur.dart'; // Assurez-vous que ce fichier existe

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // READ : Obtenir la liste de tous les rédacteurs
  Stream<List<Redacteur>> getRedacteurs() {
    return _db.collection('redacteurs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Redacteur(
          id: doc.id,
          nom: doc.data()['nom'] ?? '',
          specialite: doc.data()['specialite'] ?? '',
        );
      }).toList();
    });
  }

  // CREATE / UPDATE : Ajouter ou mettre à jour un rédacteur
  Future<void> setRedacteur(Redacteur redacteur) {
    var options = SetOptions(merge: true);
    return _db.collection('redacteurs').doc(redacteur.id).set(redacteur.toFirestore(), options);
  }

  // DELETE : Supprimer un rédacteur
  Future<void> removeRedacteur(String redacteurId) {
    return _db.collection('redacteurs').doc(redacteurId).delete();
  }
}