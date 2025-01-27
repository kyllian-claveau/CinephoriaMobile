import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A1A), // Fond sombre pour renforcer l'aspect cinéma
      elevation: 6, // Ombre subtile pour l'effet de profondeur
      title: Image.asset(
        'lib/assets/images/logo.png',
        height: 50, // Taille du logo ajustée pour plus de présence
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            // Ajoute une fonction pour gérer les notifications si nécessaire
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
