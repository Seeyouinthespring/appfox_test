import 'package:appfox_test/models/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../routes.dart';


class ResultScreenArgument {
  final Result result;

  ResultScreenArgument(this.result);
}

class ResultScreen extends StatefulWidget {
  final ResultScreenArgument argument;

  const ResultScreen({Key key, this.argument}) : super(key: key);

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  String category;
  String difficulty;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text('Result'),
          ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,

        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: Text('Your result is ${widget.argument.result.correctAnswersQuantity} out of ${widget.argument.result.allAnswersQuantity}',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),

          Container(
            child: Text('${ (widget.argument.result.correctAnswersQuantity / widget.argument.result.allAnswersQuantity) * 100 } %',
              style: TextStyle(fontSize: 36),
            )
          ),


          Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: 48,
            child: OutlinedButton(
              onPressed: () async {
                  var instance = FirebaseFirestore.instance;
                  await instance.collection('Results').add(widget.argument.result.toMap());
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.start, (route) => false);
              },
              child: Text('Save results', style: TextStyle(color: Colors.white),),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.green,
                side: BorderSide(color: Colors.green),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 48,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(Routes.start, (route) => false),
              child: Text('Exit without saving', style: TextStyle(color: Colors.white, ),),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

