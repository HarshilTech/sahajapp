import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart%20';

class PdfApi {
  static Future<File> generateCentredText(String fullname, String date, String fromdate, String todate, String rupee, String signature, String housenumber) async {
    final pdf = pw.Document();

    final customFont =
        Font.ttf(await rootBundle.load("assets/NotoSansGujarati.ttf"));

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (context) => pw.Container( width: double.infinity,
        height: double.infinity,
        padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.red, width: 5)),
        child: pw.Column(
          children: [
            pw.SizedBox(height: 10),
            pw.Text(
              "|| ગણેશાય નમઃ ||",
              style: pw.TextStyle(
                  fontSize: 20, font: customFont, color: PdfColors.red),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Container(
                padding: pw.EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.red, width: 5)),
                child: pw.Text(
                  "સહજ હોમ્સ ૩",
                  style: pw.TextStyle(
                      fontSize: 40,
                      font: customFont,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.red),
                )),
            pw.SizedBox(height: 10),
            pw.Text(
              "રાધનપુર રોડ, મહેસાણા-૨",
              style: pw.TextStyle(
                  fontSize: 30, font: customFont, color: PdfColors.red),
            ),
            pw.SizedBox(height: 20),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "નામ : ${fullname} ",
                      style: pw.TextStyle(
                          fontSize: 30, font: customFont, color: PdfColors.red),
                    ),
                    pw.Text(
                      "ઘર નંબર : ${housenumber} ",
                      style: pw.TextStyle(
                          fontSize: 30, font: customFont, color: PdfColors.red),
                    ),
                  ]),
            ),
            pw.SizedBox(height: 10.0),
            pw.Text(
              "આપના તરફથી રૂપિયા:- ${rupee} મળ્યા છે. જે આપના ખાતા માં જમા કરેલ છે. જે તારીખ:- ${fromdate} થી લઈ તારીખ:- ${todate} સુધી માન્ય ગણાશે.",
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: 30, font: customFont, color: PdfColors.red),
            ),
            pw.SizedBox(height: 10.0),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "તારીખ:- ${date}",
                    style: pw.TextStyle(color: PdfColors.red, font: customFont, fontSize: 30)
                  ),
                  pw.Align(
                      alignment: pw.Alignment.bottomRight,
                      child: pw.Text(
                        "જમા કરનારની સહી:-\n${signature}",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 30,
                            font: customFont,
                            color: PdfColors.red),
                      ))
                ]),
          ],
        ),),
    ));

    return saveDocument(name: "${fullname}.pdf", pdf: pdf);

  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final uri = file.path;

    await OpenFile.open(uri);
  }
}
