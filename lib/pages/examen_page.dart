import 'dart:convert'; //Esto es para decodificar el json
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preguntas_respuestas_app/clases/examen.dart';
import 'package:preguntas_respuestas_app/clases/preguntas.dart';
import 'package:preguntas_respuestas_app/pages/resultados_page.dart';

class ExamenPage extends StatefulWidget {
  const ExamenPage({Key? key}) : super(key: key);

  @override
  State<ExamenPage> createState() => _ExamenPageState();
}

class _ExamenPageState extends State<ExamenPage> {
  //Con esta variable le vamos a hacer que solo nos salga un valor de 5 preguntas en nuestra app
  int totalQuestions = 5;
  // Con esta variable le vamos a hacer que solo nos salga un valor de 4 opciones de respuestas en nuestra app
  int totalOptions = 4;
  //Aquí vamos a craer una variable int que nos diga en qué pregunta estamos que va a iniciar desde cero
  int questionIndex = 0;
  // variable para que la barra de progreso inicie en cero
  int progressIndex = 0;
  //
  Quiz quiz = Quiz(name: 'Quiz de Capitales', questions: []);

  Future<void> readJson() async {
    //Funcion cargarJson

    final String response = await rootBundle.loadString(
        'assets/paises.json'); //Aquí llamamamos a nuestro archivo json
    final List<dynamic> data =
        await json.decode(response); //Aquí decodificamos nuestro archivo json
    List<int> optionList = List<int>.generate(
        data.length,
        (i) =>
            i); //Aquí estamos creando una lista de enteros que son las listas de los elementos que tenemos en nuestro json (los paises), que le hemos llamado data
    List<int> questionsAdded =
        []; //Aquí en este List nos vamos a asegurar que las preguntas no se repitan

    while (true) {
      optionList
          .shuffle(); // shuffle lo ponemos para que cada pregunta salga de manera aleatoria
      int answer = optionList[0];
      if (questionsAdded.contains(answer)) continue;
      questionsAdded.add(answer);

      List<String> otherOptions = [];
      for (var option in optionList.sublist(1, totalOptions)) {
        //Por cada opcion dentro de la lista de opciones, en la subLista del indice 1 hasta el total de opciones (dijimos que era 4) se van a ir agregando las opciones
        otherOptions.add(data[option]['capital']);
      }

      Question question = Question.fromJson(data[
          answer]); //Aquí estamos creando un objeto pregunta utilizando la lista de paises en el indice answer
      question.addOptions(otherOptions);
      quiz.questions.add(question); //Aquí vamos agregando las preguntas

      if (quiz.questions.length >= totalQuestions) {
        break; //Con esta condicion hacemos que se salga del bucle While cuando haya superado el numero de preguntas (5)
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    //Esta funcion me va a cargar el archivo json
    super.initState();
    readJson(); //Aquí llamamos a la función cargarJson
  }

  void _optionSelected(String selected) {
    //Aquí en esta funcion cada vez que le de a una opcion de respuesta me guarda la seleccionada (correcta o no), y también me aumenta el indice
    quiz.questions[questionIndex].selected = selected;
    if (selected == quiz.questions[questionIndex].answer) {
      quiz.questions[questionIndex].correct = true;
      quiz.right += 1;
    }

    progressIndex += 1;

    if (questionIndex < totalQuestions - 1) {
      questionIndex += 1;
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => _buildResultDialog(context));
    }

    setState(() {});
  }

  Widget _buildResultDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Resultados', style: Theme.of(context).textTheme.headline1),
      backgroundColor: Theme.of(context).primaryColorDark,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preguntas totales: $totalQuestions',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text('Correctas: ${quiz.right}',
              style: Theme.of(context).textTheme.bodyText1),
          Text('Incorrectas: ${(totalQuestions - quiz.right)}',
              style: Theme.of(context).textTheme.bodyText1),
          Text('Porcentaje: ${quiz.porcentaje}%',
              style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => ResultsPage(
                        quiz: quiz,
                      ))),
            );
          },
          child: Text(
            'Ver Respuestas',
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        //Con esto le ponemos un titulo en la parte superior de la pantalla llamado Preguntas
        title: Text(quiz
            .name), //aquí estoy llamando al nombre que le pusimos arriba en el name
        backgroundColor: Colors.indigo,
        elevation:
            0, //Con eleveation hacemos "desaparecer" la linea del appBar, para que quede toda el fondo de pantalla del mismo color
      ),

      //Aquí colocaremos una barra de progreso para las preguntas
      //A continuación estarán las preguntas con sus diferentes respuestas
      //Además habrá un botón para saltar la pregunta a otra.
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal:
                    30), //Aquí le damos el margen necesario de izquierda y derecha al LinearProgressIndicator
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(5), //Le damos un borde un poco circular
              child: LinearProgressIndicator(
                // Aquí mostramos el progreso a lo largo de una línea.
                color: Colors.amber.shade900,
                value: progressIndex / totalQuestions, //Aqui lo dividimos
                minHeight:
                    20, //Aquí le damos la altura al LinearProgressIndicator
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: quiz.questions.isNotEmpty
                  ? Card(
                      //Aquí le estamos diciendo que mientras esté vacía la lista de preguntas haga otra cosa, que lo pondremos donde termina nuestro Card
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Aquí determinamos el tamaño de la Columna
                        children: [
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: Text(
                              quiz.questions[questionIndex].question,
                              style: Theme.of(context).textTheme.headline1,
                            ), //En este style le pasamos el theme desde el main.dart que modificamos
                          ),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap:
                                  true, //Aquí con shrinWrap podemos cambiar el comportamiento para que ListView solo ocupe el espacio que necesita.
                              itemCount:
                                  totalOptions, //Aquí creamos una lista de 4, ya que eso declaramos en nuestra variable de arriba
                              itemBuilder: (_, index) {
                                return Container(
                                  margin: const EdgeInsets.all(
                                      3), //  Aquí para que haya espacio entre cada parte de la lista
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.indigo.shade100,
                                        width:
                                            2), //Aquí le damos un borde a cada apartado de la lista
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),

                                    //Aquí le decimos que empiece desde uno y no desde cero
                                    leading: Text('${index + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1 // Aquí le damos color a las letras
                                        ),
                                    title: Text(
                                        quiz.questions[questionIndex]
                                            .options[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1 // Aquí le damos color a las letras
                                        ),

                                    onTap: () {
                                      _optionSelected(quiz
                                          .questions[questionIndex]
                                          .options[index]);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator(
                      backgroundColor: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              _optionSelected('Skipped');
            },
            child: Text('* Saltar a otra capital *',
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
