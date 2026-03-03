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
          Center(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo_purple.png', width: 280, height: 280),
                const SizedBox(height: 50),
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
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('Registrar Rutina'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6B6FD4),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
            icon: Icon(Icons.calendar_today, color:  AppColors.pinkie),
            label: 'Calendario',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color:  AppColors.pinkie),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color:  AppColors.pinkie),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}