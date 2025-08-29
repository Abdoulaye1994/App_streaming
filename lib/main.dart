import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:streaming_app/MaPremierePage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // L'étape cruciale : s'assurer que les widgets sont initialisés avant de lancer l'initialisation de Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MonApplication());
}

class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vos émissions en streaming',
      // Vous pouvez ici ajouter un thème global
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MaPremierePage(),
    );
  }
}