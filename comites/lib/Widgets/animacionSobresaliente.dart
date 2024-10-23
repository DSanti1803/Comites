// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:flutter/material.dart';

class AnimacionSobresaliente extends StatefulWidget {
  final Widget child;
  final double scaleFactor; // Factor de escala cuando se pasa el mouse
  final Duration duration; // Duración de la animación

  const AnimacionSobresaliente({
    super.key,
    required this.child,
    this.scaleFactor = 1.2,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  _AnimacionSobresalienteState createState() => _AnimacionSobresalienteState();
}

class _AnimacionSobresalienteState extends State<AnimacionSobresaliente>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleFactor).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(_) {
    _controller.forward(); // Inicia la animación al pasar el ratón
  }

  void _onExit(_) {
    _controller.reverse(); // Reversa la animación al salir del área
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
