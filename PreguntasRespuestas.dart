import 'package:flutter/material.dart';
import 'package:preguntas_respuestas_app/pages/examen_page.dart';
import 'package:preguntas_respuestas_app/pages/home_page.dart';
import 'package:preguntas_respuestas_app/pages/revision_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        //Aquí le pasamos las rutas de los ficheros HomePage, ExamenPage, RevisionPage
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/examen-page': (context) => const ExamenPage(),
          '/revision-page': (context) => const RevisionPage(),
        });
  }
}
