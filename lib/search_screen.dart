import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Padding(
        padding: const EdgeInsets.all(10.0),
        child: const Text('KAZIBA Search', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36, color: Colors.blue),),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Recherche sur le terrorisme ...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            !(_isLoading) ?
            Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Effectuer une recherche sur le terrorisme'),
                    ) :
              FutureBuilder(
                future: fetchSahelArticles(_controller.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Erreur : ${snapshot.error}");
                  } else {

                    final articles = snapshot.data as List<Map<String, dynamic>>;
                    print(articles.length) ;
                    return (articles.isEmpty)?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(" Aucun n'article "),
                    ) :

                      Expanded(
                        child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return Card(
                            child: ListTile(
                              title: Text(article['titre'] ?? 'Sans titre', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.blue),),
                              subtitle: Text(article['resume'] ?? ''),
                              onTap: () {
                                launchUrl(Uri.parse(article['url']));
                              },
                            ),
                          );
                        },
                                            ),
                      );
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}
