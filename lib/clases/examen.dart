import 'package:preguntas_respuestas_app/clases/preguntas.dart';

class Quiz {
  String name;
  List<Question> questions;
  int right =
      0; //Esto es para saber cuantas estan correctas, y le vamos a dar un inicio de cero

  Quiz({required this.name, required this.questions});

  //Aquí vamos a agregar un metodo que me regresa el porcentaje de preguntas correctas
  double get porcentaje => (right / questions.length) * 100;
}
