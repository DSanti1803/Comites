// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:comites/constantsDesign.dart';

// Widget que muestra la lista de mensajes en una interfaz de usuario de chat
class MessagesScreen extends StatefulWidget {
  final List messages; // Lista de mensajes
  const MessagesScreen({super.key, required this.messages});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    // Utiliza un ListView.separated para mostrar los mensajes con separadores
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              // Alinea los mensajes del usuario a la derecha y los mensajes del bot a la izquierda
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(
                            20,
                          ),
                          topRight: const Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? primaryColor
                            : primaryColor.withOpacity(0.8)),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child: Text(
                      // Muestra el texto del mensaje en el contenedor
                      widget.messages[index]['message'].text.text[0],
                      style: const TextStyle(color: Colors.white),
                    )),
              ],
            ),
          );
        },
        // Separador entre los elementos de la lista
        separatorBuilder: (_, i) =>
            const Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length); // Número total de mensajes
  }
}
