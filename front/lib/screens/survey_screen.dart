import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'package:flutter_app_liftmove/core/api_config.dart';
import 'dart:convert';                   
import 'package:flutter_app_liftmove/core/theme/app_theme.dart';
import 'package:flutter_app_liftmove/core/theme/widgets/question_scaffold.dart';

// Pantallas de preguntas
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/inicial_page.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_one.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_two.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_three.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_four.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_five.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/final_page.dart';

class SurveyScreen extends StatefulWidget {
  final String nombreUsu;
  final String contrasenha; 

  const SurveyScreen({
    super.key,
    required this.nombreUsu,
    required this.contrasenha,
  });

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
 
  final PageController _pageController = PageController();
  int _currentPage = 0;

 
  bool _isMale = true;      
  int _edad = 18;            
  double _altura = 160.0;    
  double _peso = 60.0;      
  Set<String> _metas = {};   

  
  bool _q1Done = false;
  bool _q2Done = false;
  bool _q3Done = true;  // altura tiene slider con valor inicial, siempre válido
  bool _q4Done = true;  // peso tiene slider con valor inicial, siempre válido
  bool _q5Done = false;

  bool _isLoading = false; 

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _registrarUsuario() async {
    setState(() => _isLoading = true);

    final url = Uri.parse('${ApiConfig.baseUrl}/register');

    final String sexo     = _isMale ? 'M' : 'F';
    final String objetivo = _metas.join(', ');
    final String idUsu    = widget.nombreUsu; 

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'}, 
        body: json.encode({                             
          'idUsu'           : idUsu,
          'nombreUsu'       : widget.nombreUsu,
          'correoUsu'       : '$idUsu@liftmove.app', 
          'contrasenha'     : widget.contrasenha,    
          'sexo'            : sexo,
          'altura_cm'       : _altura.toInt(),
          'peso'            : _peso.toInt(),
          'objetivo_entreno': objetivo,
        }),
      );

      final data = json.decode(response.body); 

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) _irAPagina(6);
      } else {
        _mostrarError(data['detail'] ?? 'Error al registrar');
      }
    } catch (e) {
      _mostrarError('No se pudo conectar. ¿Está encendido el servidor?');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _mostrarError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, textAlign: TextAlign.center),
        backgroundColor: AppColors.berry,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.fromLTRB(40, 0, 40, 80),
      ),
    );
  }

  void _irAPagina(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _siguiente() {
    if (_currentPage < 6) _irAPagina(_currentPage + 1);
  }

  void _anterior() {
    if (_currentPage > 0) _irAPagina(_currentPage - 1);
  }

  bool get _puedeAvanzar {
    switch (_currentPage) {
      case 0: return true;
      case 1: return _q1Done;
      case 2: return _q2Done;
      case 3: return _q3Done;
      case 4: return _q4Done;
      case 5: return _q5Done;
      default: return false;
    }
  }

  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //  PageView con las pantallas de preguntas
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (i) => setState(() => _currentPage = i),
            children: [
  
              const InicialPage(),

              QuestionScaffold(
                child: QuestionOne(
                  onGenderSelected: (isMale) {
                    setState(() {
                      _isMale = isMale;
                      _q1Done = true;
                    });
                   
                  },
                ),
              ),

             
              QuestionScaffold(
                child: QuestionTwo(
                  isMale: _isMale,
                  onAgeSelected: (edad) => setState(() {
                    _edad = edad;
                    _q2Done = true;
                  }),
                ),
              ),

             
              QuestionScaffold(
                child: QuestionThree(
                  isMale: _isMale,
                  onHeightSelected: (h) => setState(() {
                    _altura = h;
                    _q3Done = true;
                  }),
                ),
              ),

             
              QuestionScaffold(
                child: QuestionFour(
                  isMale: _isMale,
                  altura: _altura,
                  edad: _edad,
                  onWeightSelected: (p) => setState(() {
                    _peso = p;
                    _q4Done = true;
                  }),
                ),
              ),

              
              QuestionScaffold(
                child: QuestionFive(
                  onGoalSelected: (metas) => setState(() {
                    _metas = metas;
                    _q5Done = metas.isNotEmpty;
                  }),
                ),
              ),

              
              const FinalPage(),
            ],
          ),

         
          if (_currentPage > 0 && _currentPage < 6)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: _anterior,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.darkPurple,
                      side: const BorderSide(
                          color: AppColors.darkPurple, width: 0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    child: const Text('Atrás'),
                  ),

               
                  _isLoading
                      ? const CircularProgressIndicator() 
                      : ElevatedButton(
                          onPressed: _puedeAvanzar
                              ? () {
                                  if (_currentPage == 5) {
                                    _registrarUsuario(); 
                                  } else {
                                    _siguiente();
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.oceanBlue,
                            disabledBackgroundColor:
                                AppColors.oceanBlue.withOpacity(0.3),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                          ),
                          child: Text(
                            _currentPage == 5 ? '¡Listo!' : 'Siguiente',
                          ),
                        ),
                ],
              ),
            ),

    
          if (_currentPage == 0)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: _siguiente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.oceanBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Comenzar',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}