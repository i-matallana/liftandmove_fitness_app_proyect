import 'package:flutter/material.dart';
import 'package:flutter_app_liftmove/core/theme/app_theme.dart';
//widgets
import 'package:flutter_app_liftmove/core/theme/widgets/customs_bg.dart';
import 'package:flutter_app_liftmove/core/theme/widgets/nav_buttons.dart';

//survey pages
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/inicial_page.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/question_one.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/final_page.dart';


class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State <SurveyScreen> createState() =>  SurveyScreenState();
}

class  SurveyScreenState extends State <SurveyScreen> {
  final PageController _controller = PageController();

  int _currentpage = 0; //contador paginas

  void _nextPage() => _controller.nextPage(
      duration: Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );

  void _previousPage() => _controller.previousPage(
      duration: Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    const int totalPages = 3;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: ClipRRect( // Para redondear las puntas de la barra
        borderRadius: BorderRadius.circular(10),
        child: 
          LinearProgressIndicator(
            value: (_currentpage + 1) / totalPages, // Ahora sí sobre el total real
            minHeight: 6,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.berry),
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
            padding: 
            const EdgeInsets.only(top: 100),
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page)=> setState(()=> _currentpage = page),
              children: [
                const InicialPage(),
                const QuestionOne(),
                const FinalPage(),
              ],
            ),
          ),
          Positioned(
            bottom: 40, 
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
                  const SizedBox.shrink(), // Espaciador para mantener el botón "SIGUIENTE" a la derecha

                // BOTÓN SIGUIENTE: Desaparece en la última página (FinalPage)
                if (_currentpage < totalPages - 1)
                  NavButton(
                    onPressed: _nextPage,
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

