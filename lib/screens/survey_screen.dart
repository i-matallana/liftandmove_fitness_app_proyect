import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_app_liftmove/screens/login_screen.dart';
import 'surveyfolder/inicial_page.dart';
import 'surveyfolder/question_one.dart';
import 'surveyfolder/question_two.dart';
import 'surveyfolder/question_three.dart';
import 'surveyfolder/question_four.dart';
import 'surveyfolder/question_five.dart';
import 'surveyfolder/question_six.dart';
import 'surveyfolder/question_seven.dart';
import 'surveyfolder/question_eight.dart';
import 'surveyfolder/question_nine.dart';
import 'surveyfolder/final_page.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State <SurveyScreen> createState() =>  _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {

  final PageController _controller = PageController();
  int _currentpage = 0; //contador paginas

  //funciones

  void _nextPage(){
    _controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _previousPage(){
    _controller.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override

  void dispose() {
    _controller.dispose(); // Importante liberar el controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LinearProgressIndicator(value: (_currentpage + 1 )/11
        ),
      ),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int page) => setState(() => _currentpage = page), 
          children: [
            InicialPage(onNext: _nextPage),
            QuestionOne(onNext: _nextPage, onBack: _previousPage),
            QuestionTwo(onNext: _nextPage, onBack: _previousPage),
            QuestionThree(onNext: _nextPage, onBack: _previousPage),
            QuestionFour(onNext: _nextPage, onBack: _previousPage),
            QuestionFive(onNext: _nextPage, onBack: _previousPage),
            QuestionSix(onNext: _nextPage, onBack: _previousPage),
            QuestionSeven(onNext: _nextPage, onBack: _previousPage),
            QuestionEight(onNext: _nextPage, onBack: _previousPage),
            QuestionNine(onNext: _nextPage, onBack: _previousPage),
            FinalPage(onBack: _previousPage),
          ],
        ),
    );
  }
}


//Sexo svg mujer y hombre y una opcion de prefiero no contestar, !es importante responder blablabla
//edad slider con imagenes
//