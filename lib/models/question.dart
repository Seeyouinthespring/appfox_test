class Question {
  int id;
  String questionText;
  Answers answers;
  CorrectAnswers correctAnswers;
  String category;
  String difficulty;
  int number;

  dynamic answersJson;
  dynamic correctAnswersJson;

  Question.fromJson(json) {
    id = json['id'];
    questionText = json['question'];
    category = json['category'];
    difficulty = json['difficulty'];
    answers = Answers.fromJson(json['answers']);
    correctAnswers = CorrectAnswers.fromJson(json['correct_answers']);
    answersJson = json['answers'];
    correctAnswersJson = json['correct_answers'];
  }
}

class Answers {
  String answerA;
  String answerB;
  String answerC;
  String answerD;
  String answerE;
  String answerF;

  Answers.fromJson(json) {
    answerA = json['answer_a'];
    answerB = json['answer_b'];
    answerC = json['answer_c'];
    answerD = json['answer_d'];
    answerE = json['answer_e'];
    answerF = json['answer_f'];
  }
}

class CorrectAnswers {
  bool answerA;
  bool answerB;
  bool answerC;
  bool answerD;
  bool answerE;
  bool answerF;

  CorrectAnswers.fromJson(json) {
    answerA = json['answer_a_correct'] == 'true';
    answerB = json['answer_b_correct'] == 'true';
    answerC = json['answer_c_correct'] == 'true';
    answerD = json['answer_d_correct'] == 'true';
    answerE = json['answer_e_correct'] == 'true';
    answerF = json['answer_f_correct'] == 'true';
  }
}