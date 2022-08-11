import 'package:appfox_test/bloc/bloc.dart';
import 'package:appfox_test/bloc/quiz_bloc.dart';
import 'package:appfox_test/models/question.dart';
import 'package:appfox_test/models/result.dart';
import 'package:appfox_test/screens/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

const List<String> VARIANTS = ['answer_a','answer_b','answer_c','answer_d','answer_e','answer_f'];

class QuizScreenArguments {
  final String category;
  final String difficulty;

  QuizScreenArguments(this.difficulty, this.category);
}

class QuizScreen extends StatefulWidget{
  final QuizScreenArguments argument;

  QuizScreen({Key key, this.argument}) : super(key: key);

  @override
  QuizState createState() => QuizState();
}

class QuizState extends State<QuizScreen>{
  QuizBloc _bloc;

  @override
  void initState() {
    _bloc = QuizBloc();
    _bloc.init(widget.argument.category, widget.argument.difficulty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuizUiState>(
      stream: _bloc.stream,
      initialData: QuizUiState.loading(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        final QuizUiState state = snapshot.data;
        if (state.uiState == UiState.loading)
          return Container(
            color: Colors.white,
            child: Center(
                child: CircularProgressIndicator()
            ),
          );

        Question currentQuestion = state.uiData.questions[state.uiData.currentQuestionNumber-1];

        return Scaffold(
          appBar: AppBar(
            title: Container(
              alignment: Alignment.center,
              child: Text('Question ${_bloc?.uiData?.currentQuestionNumber ?? ''}'),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    child: Text(currentQuestion.questionText, textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                  ),

                  Builder(
                      builder: (BuildContext context){
                        List<Widget> variants = [];

                        for (String element in VARIANTS) {
                          if (currentQuestion.answersJson[element] != null)
                            variants.add(
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      if (state.uiData.currentQuestionNumber == 10){
                                        Result result = state.uiData.result;
                                        result.endDate = DateTime.now();
                                        Navigator.of(context).pushReplacementNamed(Routes.result, arguments: ResultScreenArgument(state.uiData.result));
                                      }
                                      _bloc.handleAnswer(currentQuestion, element);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(currentQuestion.answersJson[element], style: TextStyle(color: Colors.black),),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(color: Colors.amber
                                      ),
                                    ),
                                  ),
                                )
                            );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: variants,
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
