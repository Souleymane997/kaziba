import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kaziba/service.dart';

Future<void> callEdgeFunction() async {
  const functionUrl = url;
  const anonKey = key;

  final response = await http.post(
    Uri.parse(functionUrl),
    headers: {
      'Authorization': 'Bearer $anonKey',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (kDebugMode) {
      print("Fonction exécutée avec succès : $data");
    }
  } else {
    if (kDebugMode) {
      print("Erreur ${response.statusCode} : ${response.body}");
    }
  }
}


Future<List<Map<String, dynamic>>?> fetchSahelArticles(String query) async {
  const apiKey = '5571783ad29e48f299a95b7c0fb3c930';

  final queryTrim = Uri.encodeComponent(query);


  final url = Uri.parse(
  'https://newsapi.org/v2/everything?q=$queryTrim+terrorisme+AND+(Burkina+OR+Mali+OR+Niger)&language=fr&apiKey=$apiKey',
  );


  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List articles = data['articles'];

  final List<Map<String, dynamic>>  allArticles = articles.map<Map<String, dynamic>>((article) {
      return {
        'titre': article['title'],
        'resume': article['description'],
        'url': article['url'],
        'source': article['source']['name'],
        'date': article['publishedAt'],
      };
    }).toList();

  print(allArticles.length) ;
  print(allArticles.first) ;

    return allArticles.where((article) {
      return article['titre'].toLowerCase().contains(query) ||
          article['resume'].toLowerCase().contains(query);
    }).toList();


  } else {
    throw Exception('Erreur API NewsAPI : ${response.statusCode}');
  }
}

