import 'package:appfox_test/api/questions_client.dart';
import 'package:appfox_test/models/question.dart';
import 'package:appfox_test/models/result.dart';
import 'dart:async';
import 'bloc.dart';

const int LIMIT = 10;

class UiData {
  Result result;
  List<Question> questions = [];
  int currentQuestionNumber;

  UiData({this.result, this.questions, this.currentQuestionNumber});
}

class QuizUiState {
  UiState uiState;
  UiData uiData;

  QuizUiState(this.uiState, {this.uiData});

  factory QuizUiState.normal(UiData uiData) => QuizUiState(UiState.normal, uiData: uiData);

  factory QuizUiState.loading() => QuizUiState(UiState.loading);

  factory QuizUiState.error() => QuizUiState(UiState.error);
}

class QuizBloc implements Bloc {
  final _controller = StreamController<QuizUiState>();
  UiData uiData;
  Stream<QuizUiState> get stream => _controller.stream;
  Result _result;
  List<Question> _questions = [];

  QuestionsClient _client = QuestionsClient();

  @override
  void dispose() {}


  void init(String category, String difficulty) async {
    _controller.sink.add(QuizUiState.loading());

    _questions = await _client.fetchQuestions(category, difficulty, LIMIT);
    _result = Result(
      category: category,
      difficulty: difficulty,
      startDate: DateTime.now(),
      allAnswersQuantity: LIMIT,
      correctAnswersQuantity: 0,
      replies: []
    );

    uiData = UiData(
      result: _result,
      questions: _questions,
      currentQuestionNumber: 1,
    );

    _controller.sink.add(QuizUiState.normal(uiData));
  }

  void handleAnswer(Question question, String answer){
    Timer(Duration(milliseconds: 300), () {
      Reply reply = Reply(
          id: question.id,
          question: question.questionText,
          isCorrect: question.correctAnswersJson['${answer}_correct'] == 'true'
      );
      uiData.result.replies.add(reply);
      uiData.result.correctAnswersQuantity += reply.isCorrect ? 1 : 0;

      if (uiData.currentQuestionNumber == 10)
        return;

      uiData.currentQuestionNumber += 1;
      _controller.sink.add(QuizUiState.normal(uiData));
    });
  }
}