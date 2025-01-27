import 'package:flutter/material.dart';
import 'package:cinephoria_mobile/src/view/home_screen.dart';
import 'package:cinephoria_mobile/src/view/sign_in.dart';

class AppFooter extends StatelessWidget {
  final bool isHomeScreen;

  const AppFooter({Key? key, required this.isHomeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A), // Fond sombre pour rester cohérent avec l'application
      padding: const EdgeInsets.symmetric(vertical: 15), // Un peu plus d'espace pour la touche élégante
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Naviguer vers l'écran de déconnexion
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
          ),
          const SizedBox(width: 30), // Espacement entre les boutons
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Naviguer vers l'écran d'accueil
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          const SizedBox(width: 30), // Espacement entre les boutons
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: isHomeScreen
                ? null // Désactive le bouton si on est déjà sur l'écran d'accueil
                : () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
