import 'dart:convert';
import 'package:comites/Models/ActaModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActaForm extends StatefulWidget {
  final int citacionId;

  const ActaForm({Key? key, required this.citacionId}) : super(key: key);

  @override
  _ActaFormState createState() => _ActaFormState();
}

class _ActaFormState extends State<ActaForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quoromController = TextEditingController();
  final TextEditingController _asistenciaController = TextEditingController();
  final TextEditingController _beneficioController = TextEditingController();
  final TextEditingController _reporteController = TextEditingController();
  final TextEditingController _descargosController = TextEditingController();
  final TextEditingController _pruebasController = TextEditingController();
  final TextEditingController _deliberacionController = TextEditingController();
  final TextEditingController _votosController = TextEditingController();
  final TextEditingController _conclusionesController = TextEditingController();
  Clasificacion _selectedClasificacion = Clasificacion.PUBLICA;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newActa = ActaModel(
        id: 0, // Asigna un ID según lo maneje tu backend.
        citacion: widget.citacionId,
        verificacionquorom: _quoromController.text,
        verificacionasistenciaaprendiz: _asistenciaController.text,
        verificacionbeneficio: _beneficioController.text,
        reporte: _reporteController.text,
        descargos: _descargosController.text,
        pruebas: _pruebasController.text,
        deliberacion: _deliberacionController.text,
        votos: _votosController.text,
        conclusiones: _conclusionesController.text,
        clasificacioninformacion: _selectedClasificacion,
      );

      // Llama a la función postActa para enviar los datos
      await postActa(newActa);

      Navigator.pop(context); // Cierra el formulario después de guardar.
    }
  }

  Future<void> postActa(ActaModel acta) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/Acta/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(acta.toJson()); // Convertir ActaModel a JSON

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        // Acta guardada exitosamente
        print('Acta creada con éxito');
      } else {
        // Error al guardar el acta
        print('Error al crear acta: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
      }
    } catch (e) {
      // Si ocurre un error en la solicitud, captúralo aquí
      print('Error en la solicitud: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Acta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _quoromController,
                decoration: InputDecoration(labelText: 'Verificación Quórum'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _asistenciaController,
                decoration: InputDecoration(
                    labelText: 'Verificación Asistencia Aprendiz'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _beneficioController,
                decoration:
                    InputDecoration(labelText: 'Verificación Beneficio'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _reporteController,
                decoration: InputDecoration(labelText: 'Reporte'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _descargosController,
                decoration: InputDecoration(labelText: 'Descargos'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _pruebasController,
                decoration: InputDecoration(labelText: 'Pruebas'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _deliberacionController,
                decoration: InputDecoration(labelText: 'Deliberación'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _votosController,
                decoration: InputDecoration(labelText: 'Votos'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _conclusionesController,
                decoration: InputDecoration(labelText: 'Conclusiones'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              DropdownButtonFormField<Clasificacion>(
                value: _selectedClasificacion,
                onChanged: (newValue) {
                  setState(() {
                    _selectedClasificacion = newValue!;
                  });
                },
                items: Clasificacion.values.map((clasificacion) {
                  return DropdownMenuItem(
                    value: clasificacion,
                    child: Text(clasificacion.toString().split('.').last),
                  );
                }).toList(),
                decoration:
                    InputDecoration(labelText: 'Clasificación Información'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Guardar Acta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
