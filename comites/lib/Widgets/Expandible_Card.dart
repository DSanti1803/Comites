// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget expandedContent; // Contenido que se despliega
  final Duration animationDuration;

  const ExpandableCard.ExpandibleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.expandedContent,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.black ,fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.subtitle),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: _toggleExpand,
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(), // Cuadro colapsado
            secondChild: widget.expandedContent, // Cuadro expandido
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: widget.animationDuration,
          ),
        ],
      );
  }
}
