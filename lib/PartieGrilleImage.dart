import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:streaming_app/IdentificationStreaming.dart';

class PartieGrilleImage extends StatelessWidget {
  const PartieGrilleImage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<Map<String, String>> emissions = [
      {
        'tag': 'Documentaires',
        'image': 'assets/images/doc.jpg',
        'nom': 'Documentaires',
        'chaine': 'Radio 1'
      },
      {
        'tag': 'Tendances Mode',
        'image': 'assets/images/mode.jpg',
        'nom': 'Tendances Mode',
        'chaine': 'Radio 2'
      },
      {
        'tag': 'Enquêtes Criminelles',
        'image': 'assets/images/crime.jpg',
        'nom': 'Enquêtes Criminelles',
        'chaine': 'Radio 3'
      },
      {
        'tag': 'Match de Foot',
        'image': 'assets/images/foot.jpg',
        'nom': 'Match de Foot',
        'chaine': 'Radio 4'
      },
      {
        'tag': 'Streaming Mitio',
        'image': 'assets/images/mitio.jpg',
        'nom': 'Streaming Mitio',
        'chaine': 'Radio 5'
      },
      {
        'tag': 'Que des news',
        'image': 'assets/images/news.jpg',
        'nom': 'Que des news',
        'chaine': 'Radio 6'
      },
    ];

    return ResponsiveGridList(
      desiredItemWidth: 150, 
      minSpacing: 10,       
      children: emissions.map((emission) {
        return IdentificationStreaming(
          tagStream: emission['tag']!,
          imageStream: emission['image']!,
          nomStream: emission['nom']!,
          chaineRadio: emission['chaine']!,
        );
      }).toList(),
    );
  }
}