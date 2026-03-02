import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_app_liftmove/core/theme/app_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_app_liftmove/screens/survey_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //privados _privado
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      backgroundColor: AppColors.whiteHlight,
      body: Stack(
        children: [
          SafeArea(
            child: Stack(
              children: [
                IgnorePointer(
                  child: const CustomBg(),
                ),
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 30), //espacio horizontal de las cajas
                        child: Column(
                          children: [
                            LoginHeader(),
                            const SizedBox(height: 25),
                            LoginBox(
                              isPasswordVisible: _isPasswordVisible,
                              onTogglePassword: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            LoginButton(),
                            const SizedBox(height: 5),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IgnorePointer( 
              child: Lottie.asset(
                'assets/walking_login.json',
                width: double.infinity,
                height: 260,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Cabecera del Login

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        Text(
          'Bienvenido', 
          style: TextStyle(
          fontFamily: 'HeuvelGrotesk',
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: AppColors.oceanBlue,
          ),
        ),
        Text(
          'Da el primer paso a tu nuevo estilo de vida', 
            style: TextStyle(
            color: AppColors.periwinkle,
            fontSize: 10,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}


// Cajas Login
class LoginBox extends StatelessWidget {
  final bool isPasswordVisible;
  final VoidCallback onTogglePassword;

  const LoginBox({super.key, required this.isPasswordVisible, required this.onTogglePassword});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('USUARIO'), 
        _inputField(Icons.person_2, 'Ingrese su nombre de Usuario',),
        const SizedBox(height: 24,),
        // _label('Correo Electronico'), 
        // _inputField(Icons.email_outlined, 'Ingrese su Correo Electronico', ),
        // const SizedBox(height: 24,),
        _label('CONTRASEÑA'), //funcion ojito
        _inputField(
          Icons.lock_outline, 
          'Ingrese su Contraseña', isPassword: true, 
          suffix: IconButton(
            onPressed: onTogglePassword, 
            icon: Icon(
              isPasswordVisible 
                ? Icons.visibility_rounded 
                : Icons.visibility_off_rounded, 
              size: 20, 
              color: AppColors.periwinkle
            ),
          ),
        ),
        const SizedBox(height: 24,),
      ],
    );
  }
  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 3), 
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.lightPink,
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    ),
  );

  Widget _inputField (
    IconData icon, 
    String hint, 
    {bool isPassword = false, Widget? suffix,}){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteHlight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow (color:AppColors.babyGrey, blurRadius: 10 ),
        ],
      ),
      child: TextField(
        obscureText: isPassword && !isPasswordVisible,
        style: TextStyle(
          color: AppColors.darkPurple, 
          fontWeight: FontWeight.w700, 
          fontSize: 13
        ),
        decoration: InputDecoration(
          hintText: hint, 
          hintStyle: TextStyle(
            color: AppColors.greyPurple , 
            fontSize: 10,
            fontWeight: FontWeight.w300, 
            ),
          prefixIcon: Icon(
            icon, 
            color: AppColors.periwinkle, 
            size: 22,
          ),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical:15) //width de la cajita
        ),
      ),
    );
  }
}

//boton crear cuenta
class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.mainBlue,AppColors.oceanBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color:AppColors.babyGrey, 
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: 
      ElevatedButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SurveyScreen()),
          );
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), 
          ),
          elevation: 0,
        ),
        child: 
        const Text(
          'CREAR CUENTA', 
          style: TextStyle(
          fontSize: 10,
          color: AppColors.whiteHlight,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          ),
        )
      ), //sin funcion
    );
  }
}

class LogoIcon extends StatelessWidget {
  final double size;

  const LogoIcon({super.key, required this.size}); 
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo_purple.svg',
      width: size
    );
  }
}


//difuminado para el fondo
class BlurredBlob extends StatelessWidget {
  final double size;
  final Color color;

  const BlurredBlob({
    super.key, 
    this.size = 200, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // La magia está aquí:
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 80,               // Mucho difuminado
            spreadRadius: 40,             
          ),
        ],
      ),
    );
  }
}

// formato de bg
class CustomBg extends StatelessWidget {
  const CustomBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: 
      [
        const Positioned(
            top: -80,
            left: -80,
            child: BlurredBlob(
              size: 250,
              color: AppColors.purpleLilac,
            ),
        ),
        const Positioned(
            bottom: 255,
            right: -80,
            child: BlurredBlob(
              size: 250,
              color: AppColors.skyBlue,
          ),
        ),
        const Positioned(
            bottom: -100,
            left: -2,
            child: BlurredBlob(
              size: 250,
              color: AppColors.lightPink,
          ),
        ),
        const Positioned(
          top: 25,
          left: 0,
          right: 0,
          child: Center(
            child: LogoIcon(size: 65),
          ),
        ),
      ],
    );
  }
}