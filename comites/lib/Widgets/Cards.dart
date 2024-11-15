// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names

import 'package:comites/Widgets/animacionSobresaliente.dart';
import 'package:flutter/material.dart';

class CardStyle {
  static Widget buildCard({
    required Widget child,
    required VoidCallback onTap,
    bool isHovered = false,
  }) {
    return AnimacionSobresaliente(
      scaleFactor: 1.05,
      child: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              decoration: BoxDecoration(
                color: isHovered ? const Color.fromARGB(255, 96, 245, 70)  : const Color(0xFFFf0fee6),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: isHovered ? const Color.fromARGB(255, 96, 245, 70)  : const Color(0xff6de458),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: isHovered
                        ? const Color.fromARGB(255, 96, 245, 70).withOpacity(0.1)
                        : const Color(0xff6de458).withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 0,
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardStyle2 {
  static Widget buildCard({
    required Widget child,
    required VoidCallback onTap,
    bool isHovered = false,
  }) {
    return AnimacionSobresaliente(
      scaleFactor: 1.05,
      child: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              decoration: BoxDecoration(
                color: isHovered ? const Color(0xffe1f5fe) : const Color(0xFFFf0fee6),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: isHovered ? const Color(0xffe1f5fe) : const Color.fromARGB(255, 255, 195, 29),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: isHovered
                        ? const Color(0xffe1f5fe).withOpacity(0.1)
                        : const Color.fromARGB(255, 255, 202, 57).withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 0,
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardLeve {
  static Widget buildCard({
    required Widget child,
    required VoidCallback onTap,
    bool isHovered = false,
  }) {
    return AnimacionSobresaliente(
      scaleFactor: 1.05,
      child: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              decoration: BoxDecoration(
                color: isHovered ? const Color.fromARGB(255, 96, 245, 70) : const Color(0xff6de458),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: isHovered ? const Color.fromARGB(255, 96, 245, 70)  : const Color(0xff6de458),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: isHovered
                        ? const Color.fromARGB(255, 96, 245, 70).withOpacity(0.1)
                        : const Color(0xff6de458).withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 0,
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardGrave {
  static Widget buildCard({
    required Widget child,
    required VoidCallback onTap,
    bool isHovered = false,
  }) {
    return AnimacionSobresaliente(
      scaleFactor: 1.05,
      child: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              decoration: BoxDecoration(
                color: isHovered ? const Color(0xFFFFD966) : const Color(0xFFFFB347), // Amarillo anaranjado
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: isHovered ? const Color(0xFFFFA500) : const Color(0xFFFFB347), // Sombra naranja
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: isHovered
                        ? const Color(0xFFFFD966).withOpacity(0.1)
                        : const Color(0xFFFFA500).withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 0,
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardMuyGrave {
  static Widget buildCard({
    required Widget child,
    required VoidCallback onTap,
    bool isHovered = false,
  }) {
    return AnimacionSobresaliente(
      scaleFactor: 1.05,
      child: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              decoration: BoxDecoration(
                color: isHovered ? const Color(0xFFFF4C4C) : const Color(0xFFFF6666), // Rojo para falta muy grave
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: isHovered ? const Color(0xFFFF0000) : const Color(0xFFCC0000), // Sombra roja oscura
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: isHovered
                        ? const Color(0xFFFF4C4C).withOpacity(0.1)
                        : const Color(0xFFFF0000).withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 0,
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

