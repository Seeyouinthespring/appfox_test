import 'package:appfox_test/models/question.dart';
import 'package:appfox_test/network/endpoints.dart';
import 'package:appfox_test/network/rest_client.dart';

class QuestionsClient {
  RestClient _client;

  QuestionsClient() {
    _client = RestClient();
  }

  Future<List<Question>> fetchQuestions(category, difficulty, limit) async {
    Map<String, dynamic> data = {
      'category': category,
      'difficulty': difficulty,
      'limit': limit
    };

    List<dynamic> json = await _client.get(Endpoints.questions, match: data);
    List<Question> questions = [];

    json.asMap().forEach((index, e) {
      var item = Question.fromJson(e);
      item.number = index + 1;
      questions.add(item);
    });

    return questions;
  }
}
