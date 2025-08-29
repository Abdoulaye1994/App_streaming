import 'package:flutter/material.dart';
import 'dart:math'; 

class AlbumStreaming extends StatelessWidget {
  final String tagStream;
  final String imageStream;
  final String nomStream;
  final String chaineRadio;

  const AlbumStreaming({
    Key? key,
    required this.tagStream,
    required this.imageStream,
    required this.nomStream,
    required this.chaineRadio,
  }) : super(key: key);

 
  String _generateRandomDate() {
    final random = Random();
    final year = 2023; 
    final month = random.nextInt(12) + 1; 
    final day = random.nextInt(28) + 1; 
    return "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(nomStream), 
      ),
      body: SingleChildScrollView( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        
            Hero(
              tag: tagStream, 
              child: Image.asset(
                imageStream,
                fit: BoxFit.cover,
                height: 250, 
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.deepPurple, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nomStream,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    chaineRadio,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // Section des diffusions
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Diffusions précédentes:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                 
                  for (int i = 1; i <= 5; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.volume_up, color: Colors.deepPurple), 
                              const SizedBox(width: 8),
                              Text(
                                'Diffusion $i',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            'Date: ${_generateRandomDate()}', 
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}