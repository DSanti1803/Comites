import 'package:comites/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AppState>().usuarioAutenticado.nombres;

    return AppBar(
      automaticallyImplyLeading: false, // Evita la flecha de regreso
      backgroundColor: Colors.grey[200],
      title: Text(
        title,
        style: const TextStyle(color: Colors.green),
      ),
      leading: _buildLeadingIcon(context), // Ícono según el dispositivo
      actions: [
        Row(
          children: [
            const Icon(Icons.person, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              usuario ?? 'Usuario',
              style: const TextStyle(color: Colors.green),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    );
  }

  // Widget que muestra el ícono de menú en pantallas pequeñas
  Widget _buildLeadingIcon(BuildContext context) {
    if (MediaQuery.of(context).size.width < 768) {
      // Muestra el icono de menú en dispositivos móviles y tablets
      return IconButton(
        icon: const Icon(Icons.menu, color: Colors.green),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer(); // Abre el SideMenu
        },
      );
    }
    return const SizedBox(); // No muestra nada en pantallas grandes
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
