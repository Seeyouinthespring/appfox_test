import 'package:appfox_test/components/dropdown_selector.dart';
import 'package:appfox_test/screens/quiz.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

const categories = ['Linux', 'Docker', 'Sql', 'Code', 'DevOps'];
const difficulties = ['Easy', 'Medium', 'Hard'];

class StartScreen extends StatefulWidget {
  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  String category;
  String difficulty;

  @override
  void initState() {
    category = categories[0];
    difficulty = difficulties[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
          titleSpacing: 0.0,
          title: Container(
            alignment: Alignment.center,
            child: Text('Quiz options'),
          ),
          iconTheme: IconThemeData(color: Colors.white)
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Choose category and difficulty', style: TextStyle(color: Colors.black, fontSize: 24)),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownSelector(
                    onChange: (_) {
                      setState(() {category = _;});
                    },
                    value: category,
                    items: categories,
                    title: "Category"
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: DropdownSelector(
                    onChange: (_) {
                      setState(() {difficulty = _;});
                    },
                    value: difficulty,
                    items: difficulties,
                    title: "Difficulty"
                ),
              ),

              OutlinedButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed(Routes.quiz, arguments: QuizScreenArguments(difficulty, category)),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Start', style: TextStyle(color: Colors.black, fontSize: 24), textAlign: TextAlign.center,),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ],
          )
      ),
    );
  }
}