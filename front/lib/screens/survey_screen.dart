import 'package:flutter/material.dart';
import 'package:flutter_app_liftmove/core/theme/app_theme.dart';
import 'package:flutter_app_liftmove/core/theme/widgets/customs_bg.dart';
import 'package:flutter_app_liftmove/core/theme/widgets/nav_buttons.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/inicial_page.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_one.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_two.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_three.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_four.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_five.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/final_page.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => SurveyScreenState();
}

class SurveyScreenState extends State<SurveyScreen> {
  final PageController _controller = PageController();

  int _currentpage = 0;
  bool? _esHombre;
  int _edad = 0;
  double _altura = 150.0;
  double _peso = 60.0;
  Set<String> _metas = {};

  void _nextPage() => _controller.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );

  void _previousPage() => _controller.previousPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );

  String? _validarPagina() {
    switch (_currentpage) {
      case 1:
        if (_esHombre == null) return 'Por favor selecciona tu género';
        break;
      case 2:
        if (_edad == 0) return 'Por favor ingresa tu fecha de nacimiento';
        break;
      case 5:
        if (_metas.isEmpty) return 'Por favor selecciona al menos un objetivo';
        break;
    }
    return null;
  }

  void _intentarAvanzar() {
    final error = _validarPagina();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          content: Text(
            error,
            textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.berry,
                fontWeight: FontWeight.w600,
                fontSize: 10,
            ),
          ),
          backgroundColor: AppColors.whiteHlight,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          margin: const EdgeInsets.fromLTRB(40, 0, 40, 100),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    _nextPage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int totalPages = 7;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 0,
            end: _currentpage / (totalPages - 1),
          ),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
          builder: (context, value, _) => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkPurple),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          const CustomBg(showLogo: false),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) => setState(() => _currentpage = page),
              children: [
                const InicialPage(),
                QuestionOne(
                  onGenderSelected: (valor) {
                    setState(() => _esHombre = valor);
                    _nextPage();
                  },
                ),
                QuestionTwo(
                  isMale: _esHombre ?? true, // ← fix
                  onAgeSelected: (valor) {
                    setState(() => _edad = valor);
                  },
                ),
                QuestionThree(
                  isMale: _esHombre ?? true, // ← fix
                  onHeightSelected: (valor) {
                    setState(() => _altura = valor);
                  },
                ),
                QuestionFour(
                  isMale: _esHombre ?? true, // ← fix
                  altura: _altura,
                  edad: _edad,
                  onWeightSelected: (valor) {
                    setState(() => _peso = valor);
                  },
                ),
                QuestionFive(
                  onGoalSelected: (valor) {
                    setState(() => _metas = valor);
                  },
                ),
                const FinalPage(),
              ],
            ),
          ),
          Positioned(
            bottom: 30 - MediaQuery.of(context).viewInsets.bottom,
            left: 25,
            right: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentpage > 0)
                  NavButton(
                    onPressed: _previousPage,
                    label: "ANTERIOR",
                    isNext: false,
                  )
                else
                  const SizedBox.shrink(),

                if (_currentpage < totalPages - 1)
                  NavButton(
                    onPressed: _intentarAvanzar, // ← fix
                    label: "SIGUIENTE",
                    isNext: true,
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}