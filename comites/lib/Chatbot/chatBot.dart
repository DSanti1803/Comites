// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';

import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:comites/Chatbot/Messages.dart';
import 'package:comites/constantsDesign.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  FocusNode focusNode = FocusNode();
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  // Lista de mensajes en la conversación
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    // Inicialización de DialogFlowtter desde un archivo JSON de autenticación
    DialogFlowtter.fromFile(path: "assets/chatbot/dialog_flow_auth.json")
        .then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Verifica si el tema es oscuro
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? secondaryColor : Colors.white,
        centerTitle: true,
        foregroundColor: Colors.grey,
        // Botón de retroceso en la barra de navegación
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            )),
        // Título de la aplicación en la barra de navegación
        title: Text(
          "Asistente virtual CBA",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          // Pantalla de mensajes
          Expanded(child: MessagesScreen(messages: messages)),
          // Entrada de texto y botón de enviar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Card(
                      margin: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        cursorColor: primaryColor,
                        controller: _controller,
                        focusNode: focusNode,
                        style: const TextStyle(color: primaryColor),
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          border: InputBorder.none,
                          hintText:
                              "Escribe 'Hola' para comenzar la conversación",
                          contentPadding: EdgeInsets.all(5),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                // Botón de enviar mensaje
                IconButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: primaryColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Función para enviar un mensaje
  sendMessage(String text) async {
    if (text.isEmpty) {
      // Mensaje vacío, no se hace nada
      print('Message is empty');
    } else {
      // Agrega el mensaje del usuario a la lista de mensajes
      setState(() {
        addMessage(
            Message(
              text: DialogText(text: [text]),
            ),
            true);
      });

      // Envía la consulta a DialogFlow y obtiene la respuesta
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      // Agrega la respuesta de DialogFlow a la lista de mensajes
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  // Función para agregar un mensaje a la lista de mensajes
  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }
}
