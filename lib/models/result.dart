class Result {
  DateTime startDate;
  DateTime endDate;
  String category;
  String difficulty;
  List<Reply> replies;
  int correctAnswersQuantity;
  int allAnswersQuantity;

  Result({this.difficulty,this.category, this.startDate, this.endDate, this.replies, this.allAnswersQuantity, this.correctAnswersQuantity});


  Map<String, dynamic> toMap(){
    Map<String, dynamic> data = {
      "startDate": startDate.toString(),
      "endDate": endDate.toString(),
      "category": category,
      "difficulty": difficulty,
      "answers": replies.map((e) => e.toMap()).toList(),
      "correctAnswersQuantity": correctAnswersQuantity,
      "allAnswersQuantity": allAnswersQuantity
    };
    return data;
  }
}

class Reply {
  int id;
  // String answer;
  // String correctAnswer;
  String question;
  bool isCorrect;

  Reply({this.question, this.id, this.isCorrect});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> data = {
      "id": id,
      // "answer": answer,
      // "correctAnswer": correctAnswer,
      "question": question,
      "isCorrect": isCorrect,
    };
    return data;
  }
}