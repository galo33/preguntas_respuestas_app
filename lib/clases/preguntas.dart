class Question {
  late String country;
  String question = "Capital de: ";

  //Ahora haremos una lista de respuesta
  late String answer;
  List<String> options = []; //Ahora haremos una lista de opciones
  String selected = 'Skipped';
  bool correct = false;

  Question.fromJson(Map<String, dynamic> json)
      : country = json['country'],
        answer = json['capital'];

  void addOptions(List<String> newOptions) {
    question += country; //Aquí hemos concatenado Capital de: + algún pais
    //Aquí agregamos la respuesta con algunas otras opciones
    options.add(answer);
    options.addAll(newOptions);
    options
        .shuffle(); //Esto es para que las opciones de las respuestas se mezclen y no salga la respuesta siempre en el mismo lugar
  }
}
