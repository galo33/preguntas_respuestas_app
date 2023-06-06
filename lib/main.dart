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
          // Aquí seguiremos modificando nuestro theme

          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  //Aquí añadimos una sombra con una opacidad
                  color: Colors.purple.shade900.withOpacity(.3),
                  offset: const Offset(3,
                      3), // Aquí le decimos que la sombra este 3px abajo y 3px a la derecha
                  blurRadius: 5, // Esto es lo borroso que se ve la sombra
                ),
              ],
            ),
            headline2: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 20,
            ),
            bodyText1: TextStyle(
              color: Color.fromARGB(255, 245, 245, 23),
              fontSize: 20,
            ),
          ),

          cardTheme: CardTheme(
            elevation: 6, //Aquí para ver la sombra un poco marcada
            color: Color.fromARGB(255, 123, 127, 158),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
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
