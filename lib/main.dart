import 'package:flutter/material.dart';
import 'package:kaziba/search_screen.dart';
import 'package:kaziba/service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'detail.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: url,
    anonKey: key,
  );
  await initializeDateFormatting('fr_FR', null); // ← Initialisation ici
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sahel Terror Search',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailScreen(),
      },
    );
  }
}



