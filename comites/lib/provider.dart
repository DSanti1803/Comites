import 'package:comites/Models/AbogadoModel.dart';
import 'package:comites/Models/AprendizModel.dart';
import 'package:comites/Models/BienestarModel.dart';
import 'package:comites/Models/CoordinadorModel.dart';
import 'package:comites/Models/instructormodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  dynamic _usuarioAutenticado;

  AppState() {
    _loadUsuarioFromPrefs();
  }

  dynamic get usuarioAutenticado => _usuarioAutenticado;

  int? get userId => _usuarioAutenticado?.id;

  void setUsuarioAutenticado(dynamic usuario, String tipoUsuario) async {
    _usuarioAutenticado = usuario;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (usuario != null) {
      await prefs.setInt('usuarioId', usuario.id);
      await prefs.setString(
          'tipoUsuario', tipoUsuario); // Guardar el tipo de usuario
    } else {
      await prefs.remove('usuarioId');
      await prefs.remove('tipoUsuario');
    }
    notifyListeners();
  }

  void logout() async {
    _usuarioAutenticado = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuarioId');
    await prefs.remove('tipoUsuario');
    notifyListeners();
  }

  void _loadUsuarioFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? usuarioId = prefs.getInt('usuarioId');
    String? tipoUsuario = prefs.getString('tipoUsuario');
    if (usuarioId != null && tipoUsuario != null) {
      switch (tipoUsuario) {
        case 'aprendiz':
          List<UsuarioAprendizModel> aprendices = await getAprendiz();
          _usuarioAutenticado = aprendices.firstWhere((a) => a.id == usuarioId);
          break;
        case 'instructor':
          List<InstructorModel> instructores = await getIntructor();
          _usuarioAutenticado =
              instructores.firstWhere((i) => i.id == usuarioId);
          break;
        case 'abogado':
          List<AbogadoModel> abogados = await getAbogado();
          _usuarioAutenticado = abogados.firstWhere((i) => i.id == usuarioId);
          break;
        case 'coordinador':
          List<CoordinadorModel> coordinadores = await getCoordinador();
          _usuarioAutenticado =
              coordinadores.firstWhere((i) => i.id == usuarioId);
          break;
        case 'bienestar':
          List<BienestarModel> bienestar = await getBienestar();
          _usuarioAutenticado = bienestar.firstWhere((i) => i.id == usuarioId);
          break;
      }
      notifyListeners();
    }
  }
}
