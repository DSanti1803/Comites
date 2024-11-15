// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:comites/Models/ActaModel.dart';

class ActaForm extends StatefulWidget {
  final int citacionId;

  const ActaForm({super.key, required this.citacionId});

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
      // Aquí se envían los datos al backend
      Navigator.pop(context); // Cierra el modal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Crear Acta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildFormField(
                          controller: _quoromController, label: 'Verificación Quórum'),
                      _buildFormField(
                          controller: _asistenciaController,
                          label: 'Verificación Asistencia Aprendiz'),
                      _buildFormField(
                          controller: _beneficioController,
                          label: 'Verificación Beneficio'),
                      _buildFormField(controller: _reporteController, label: 'Reporte'),
                      _buildFormField(controller: _descargosController, label: 'Descargos'),
                      _buildFormField(controller: _pruebasController, label: 'Pruebas'),
                      _buildFormField(controller: _deliberacionController, label: 'Deliberación'),
                      _buildFormField(controller: _votosController, label: 'Votos'),
                      _buildFormField(
                          controller: _conclusionesController, label: 'Conclusiones'),
                      const SizedBox(height: 8),
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
                        decoration: const InputDecoration(
                          labelText: 'Clasificación Información',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Guardar Acta'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(
      {required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }
}
