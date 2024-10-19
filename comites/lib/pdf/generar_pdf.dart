import 'package:comites/Models/AprendizModel.dart';
import 'package:comites/Models/ReglamentoModel.dart';
import 'package:comites/Models/SolicitudModel.dart';
import 'package:comites/Models/instructormodel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';

class PdfGenerator extends StatelessWidget {
  final SolicitudModel solicitud;
  final List<UsuarioAprendizModel> aprendices;
  final List<InstructorModel> responsables;
  final List<ReglamentoModel> reglamentos;

  const PdfGenerator(
      {super.key,
      required this.solicitud,
      required this.aprendices,
      required this.reglamentos,
      required this.responsables});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar Documento PDF'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            generatePdf();
          },
          child: const Text('Generar PDF'),
        ),
      ),
    );
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    // Cargar la imagen del logo
    final imageLogo = pw.MemoryImage(
      (await rootBundle.load('assets/img/logo2.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 2),
            ),
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Encabezado como tabla
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Table(
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: const pw.FractionColumnWidth(0.15), // Imagen
                      1: const pw.FractionColumnWidth(0.65), // Texto central
                      2: const pw.FractionColumnWidth(0.20), // Info derecha
                    },
                    children: [
                      pw.TableRow(
                        children: [
                          // Imagen a la izquierda
                          pw.Container(
                            child: pw.Image(imageLogo, width: 60),
                            alignment: pw.Alignment.center,
                          ),
                          // Texto en el centro
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Text(
                                'SERVICIO NACIONAL DE APRENDIZAJE SENA',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 14),
                                textAlign: pw.TextAlign.center,
                              ),
                              pw.Text(
                                'SISTEMA INTEGRADO DE GESTIÓN\nProcedimiento Gestión de Formación Profesional Integral\nLLAMADO DE ATENCIÓN AL APRENDIZ',
                                style: const pw.TextStyle(fontSize: 12),
                                textAlign: pw.TextAlign.center,
                              ),
                            ],
                          ),
                          // Información a la derecha
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text('Versión: 02',
                                  style: const pw.TextStyle(fontSize: 12)),
                              pw.SizedBox(height: 5),
                              pw.Text('',
                                  style: const pw.TextStyle(fontSize: 12)),
                              pw.Text('Fecha: ${solicitud.fechasolicitud}',
                                  style: const pw.TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),

                // Ciudad, fecha, lugar, y hora como tabla
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Table(
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: const pw.FractionColumnWidth(0.33), // 1/3
                      1: const pw.FractionColumnWidth(0.33), // 1/3
                      2: const pw.FractionColumnWidth(0.33), // 1/3
                    },
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('CIUDAD Y FECHA:',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    'MOSQUERA , ${solicitud.fechasolicitud}'),
                              ],
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text('LUGAR:',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text('CBA'),
                              ],
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text('HORA:',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text('1PM - 5PM'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),

                // Objetivo
                pw.Text('OBJETIVO:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(
                  'Realizar llamado de atención al(la) aprendiz: ${aprendices.map((a) => '${a.nombres} ${a.apellidos}').join(', ')} '
                  'identificado(a) con ${aprendices.map((a) => a.tipoDocumento).join(', ')} No. ${aprendices.map((a) => a.numeroDocumento).join(', ')} del programa ${aprendices.map((a) => a.programa).join(', ')}',
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),

                // Desarrollo
                pw.Text('DESARROLLO:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(solicitud.descripcion),
                pw.SizedBox(height: 10),
                pw.Divider(),

                // Observaciones
                pw.Text('OBSERVACIONES:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(solicitud.observaciones),
                pw.SizedBox(height: 10),
                pw.Divider(),

                // Reglamento
                pw.Text('REGLAMENTO:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(reglamentos
                    .map((reglamento) =>
                        '${reglamento.capitulo}: ${reglamento.descripcion}')
                    .join(', ')),
                pw.SizedBox(height: 10),
                pw.Divider(),

                // Participantes
                pw.Text('PARTICIPANTES:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Table(
                  border: pw.TableBorder.all(width: 1),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('NOMBRE',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('CARGO',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('FIRMA',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                      ],
                    ),
                    // Añadir responsables y aprendices
                    for (var responsable in responsables)
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                                '${responsable.nombres} ${responsable.apellidos}'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('INSTRUCTOR'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(''),
                          ),
                        ],
                      ),
                    for (var aprendiz in aprendices)
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                                '${aprendiz.nombres} ${aprendiz.apellidos}'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('APRENDIZ'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(''),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
