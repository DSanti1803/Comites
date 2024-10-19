import 'package:comites/constantsDesign.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:universal_platform/universal_platform.dart';

/// Clase que define los componentes utilizados en la pantalla de bienvenida.
class Components {
  /// Título del componente.
  String titulo;

  /// Descripción del componente.
  String descripcion;

  /// Fondo del componente (puede ser un widget como Lottie).
  Widget? backgroundColor;

  /// Segunda imagen relacionada al componente.
  String imagen2;

  /// Color de fondo del componente.
  Color background;

  /// Constructor que inicializa los atributos de la clase.
  Components(
      {required this.titulo,
      required this.descripcion,
      required this.backgroundColor,
      required this.imagen2,
      required this.background});
}

/// Lista que contiene instancias de la clase [Components], representando cada componente de la pantalla.
List<Components> listaComponents = [
  Components(
      titulo: "Formación Profesional Integral",
      descripcion:
          "El Servicio Nacional de Aprendizaje (SENA) ofrece una formación que abarca conocimientos teóricos y prácticos en diversos campos, permitiendo a los estudiantes desarrollar habilidades sólidas para desempeñarse en el mercado laboral.",
      backgroundColor: UniversalPlatform.isAndroid || UniversalPlatform.isIOS
          ? LottieBuilder.asset(
              "assets/animation/animation3.json",
              fit: BoxFit.cover,
            )
          : null,
      imagen2: 'assets/img/splash1.jpg',
      background: primaryColor),
  Components(
      titulo: "Acceso a Tecnología y Equipamiento de Vanguardia",
      descripcion:
          "Gracias a la infraestructura y recursos del SENA, los estudiantes tienen acceso a tecnología de última generación y equipamiento especializado en sus áreas de estudio, lo que les permite aprender utilizando herramientas y métodos actualizados.",
      backgroundColor: Padding(
        padding: const EdgeInsets.only(top: 180),
        child: UniversalPlatform.isAndroid || UniversalPlatform.isIOS
            ? LottieBuilder.asset(
                "assets/animation/animation3.json",
                fit: BoxFit.cover,
              )
            : null,
      ),
      imagen2: 'assets/img/splash2.jpg',
      background: Colors.white),
  Components(
      titulo: "Conexiones con el Mundo Laboral",
      descripcion:
          "El SENA establece vínculos estrechos con empresas e industrias, lo que facilita oportunidades de prácticas profesionales y pasantías para los estudiantes. Esto les brinda una experiencia real en el campo laboral y les ayuda a establecer contactos que pueden ser útiles para su futuro empleo.",
      backgroundColor: UniversalPlatform.isAndroid || UniversalPlatform.isIOS
          ? LottieBuilder.asset("assets/animation/animation3.json",
              fit: BoxFit.cover)
          : null,
      imagen2: 'assets/img/splash3.jpg',
      background: primaryColor),
  Components(
      titulo:
          "Programas Flexibles y Adaptados a las Necesidades del Estudiante",
      descripcion:
          "El SENA ofrece una amplia gama de programas de formación que se adaptan a diferentes niveles de educación y horarios. Esto permite a las personas estudiar mientras trabajan o realizan otras actividades, lo que facilita su acceso a la educación.",
      backgroundColor: Padding(
        padding: const EdgeInsets.only(top: 180),
        child: UniversalPlatform.isAndroid || UniversalPlatform.isIOS
            ? LottieBuilder.asset(
                "assets/animation/animation3.json",
                fit: BoxFit.cover,
              )
            : null,
      ),
      imagen2: 'assets/img/splash4.jpg',
      background: Colors.white),
  Components(
      titulo: "Certificación Reconocida y Valorada",
      descripcion:
          "Los títulos y certificados otorgados por el SENA son reconocidos a nivel nacional e incluso internacional, lo que aumenta las oportunidades de empleo para los graduados y les permite competir en el mercado laboral con mayor éxito.",
      backgroundColor: UniversalPlatform.isAndroid || UniversalPlatform.isIOS
          ? LottieBuilder.asset("assets/animation/animation3.json",
              fit: BoxFit.cover)
          : null,
      imagen2: 'assets/img/splash5.jpg',
      background: primaryColor),
];
