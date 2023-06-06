//pagina nueva

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .primaryColorDark, //Aquí le damos color a la pagina, cogiendo el color primario del archivo main.dart
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 50),
              child: Icon(
                Icons
                    .wb_incandescent_rounded, //Aquí hemos agregado un icono para nuestra pantalla
                size: 130,
                color: Color.fromARGB(255, 243, 243, 3),
              ),
            ),

            //Ahora vamos a incluir un menú con dos botones.
            // Uno para iniciar nuestra app de preguntas y otro para repasar las respuestas

            Card(
              margin: const EdgeInsets.all(20), //Aquí hemos ajustado el margen
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      12) //Aquí hemos redondeado los margenes
                  ),
              color: Colors.yellow.shade100,
              child: ListView(
                shrinkWrap:
                    true, //Esto es para que el ListView tomo el espacio necesario
                padding: const EdgeInsets.all(10),
                children: [
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 10, bottom: 25),
                    child: const Center(
                      child: Text(
                        'Preguntas y Respuestas',
                        //Vamos a darle tamaño y forma al texto
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color.fromARGB(255, 179, 61, 25)
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        gradient: LinearGradient(
                            //Aquí agregamos un LinearGradient para que empiece de un color y termine de otro color
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blueGrey.shade200, //Añadimos el color
                              Colors.lightBlue.shade50, //Añadimos el color
                            ]),
                        borderRadius: BorderRadius.circular(
                            5) //Aquí hemos redondeado un poco el borde
                        ),
                  ),

                  //Agregamos los botones y le damos forma
                  OutlinedButton(
                    onPressed: () {
                      //Aqui agregamos la funcionalidad para que presionando el boton cambie de pagina(examen-page)
                      Navigator.pushNamed(context, '/examen-page');
                    },
                    child: const Text('Iniciar'),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black, //Agregamos el color del texto
                      backgroundColor:
                          Colors.indigo.shade100, //Agregamos el color de fondo
                      elevation: 4, // Es la sombra que se ve al fondo del boton
                      side: const BorderSide(
                          width: 1), //Agregamos el grueso del borde
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      //Aqui agregamos la funcionalidad para que presionando el boton cambie de pagina(revision-page)
                      Navigator.pushNamed(context, '/revision-page');
                    },
                    child: const Text('Estudiar'),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.indigo.shade100,
                      elevation: 4,
                      side: const BorderSide(width: 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ), //Pagina principal, con su texto centrado.
      ),
    );
  }
}
