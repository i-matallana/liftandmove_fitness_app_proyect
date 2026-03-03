import 'package:flutter/material.dart';
import 'package:flutter_app_liftmove/core/theme/app_theme.dart';
import 'package:flutter_app_liftmove/core/theme/widgets/question_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionOne extends StatelessWidget {
  const QuestionOne({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionScaffold(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Me identifico como...',
            style: TextStyle(
              color: AppColors.darkPurple,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              
                  // Opción Masculina
                  Expanded(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/hombre_survey.svg', 
                          height: 300,
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            // Acción para hombre
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.oceanBlue,
                            foregroundColor: const Color.fromARGB(171, 52, 52, 169),
                            shadowColor: const Color.fromARGB(123, 102, 102, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: AppColors.oceanBlue, width: 0.5),
                            ),
                          ),
                          child: const Text('HOMBRE',
                            style: TextStyle(
                            color: AppColors.whiteHlight,
                            letterSpacing: 1.6,
                            fontSize: 13,
                            fontWeight: FontWeight.w900 ,
              
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Opción Femenina
                  Expanded(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/mujer_survey.svg', // Asegúrate de tener la ruta correcta
                          height: 270,
                        ),
                        const SizedBox(height: 45),
                        ElevatedButton(
                          onPressed: () {
                            // Acción para mujer
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.berry,
                            foregroundColor: Color.fromARGB(83, 255, 53, 127),
                            shadowColor: const Color.fromARGB(100, 255, 53, 127),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: AppColors.berry, width: 0.5),
                            ),
                          ),
                          child: const Text('MUJER',
                            style: TextStyle(
                            color: AppColors.whiteHlight,
                            letterSpacing: 1.6,
                            fontSize: 13,
                            fontWeight: FontWeight.w900 ,
              
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}