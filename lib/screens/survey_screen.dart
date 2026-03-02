import 'package:flutter/material.dart';
import 'package:flutter_app_liftmove/core/theme/widgets/customs_bg.dart';
import 'package:flutter_app_liftmove/screens/surveyfolder/pages/inicial_page.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State <SurveyScreen> createState() =>  SurveyScreenState();
}

class  SurveyScreenState extends State <SurveyScreen> {
  final PageController _controller = PageController();
  int _currentpage = 0; //contador paginas

  void _nextPage() => _controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

  void _previousPage() => _controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LinearProgressIndicator(value: (_currentpage + 1 )/11),
      ),
      body: Stack(
        children: [
          const CustomBg(showLogo: false),
          PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page)=> setState(()=> _currentpage = page),
            children: [
              InicialPage(onNext: _nextPage)
            ],
          ),
        ],
      ),
    );
  }
}

