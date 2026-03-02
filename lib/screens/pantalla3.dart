import 'package:flutter/material.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        backgroundColor: Color(0xFF6B6FD4),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 80, height: 80),
            const SizedBox(height: 20),
            const Text(
              'Lift & Move',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 20, 20),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Move your body, change your life',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 20, 20),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF6B6FD4)),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Color(0xFF6B6FD4)),
            label: 'Calendario',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Color(0xFF6B6FD4)),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF6B6FD4)),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
