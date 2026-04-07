import 'package:flutter/material.dart';
import 'package:flutter_app_liftmove/core/theme/app_theme.dart';
import 'package:flutter_app_liftmove/core/theme/widgets/customs_bg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('HOME',
            style: TextStyle(
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              color: AppColors.darkPurple,
              fontSize: 15,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const CustomBg(showLogo: false),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset('assets/images/logo_purple.png', width: 280, height: 150),
                const Text(
                  'Move your body, change your life',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.greyPurple,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.mainBlue, AppColors.oceanBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.babyGrey,
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Registrar Rutina'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // ✅ transparente
                      foregroundColor: Colors.white,
                      shadowColor: Colors.transparent, // ✅ sin sombra propia
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: AppColors.pinkie),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: AppColors.pinkie),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: AppColors.pinkie),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: AppColors.pinkie),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}