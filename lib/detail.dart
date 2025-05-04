import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final incident = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(incident['titre'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lieu : ${incident['lieu']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Date : ${incident['date']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Groupe : ${incident['groupe']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Résumé :', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text(incident['resume'], style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
