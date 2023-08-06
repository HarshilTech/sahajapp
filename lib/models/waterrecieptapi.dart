import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart%20';

class WaterreceiptApi {
  static Future<File> generateCentredText(
      String fullname,
      String date,
      String fromdate,
      String todate,
      String rupee,
      String signature,
      String housenumber) async {
    final pdf = pw.Document();

    final customFont =
        Font.ttf(await rootBundle.load("assets/NotoSansGujarati.ttf"));

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (context) => pw.Container(
        width: double.infinity,
        height: double.infinity,
        // margin: pw.EdgeInsets.all(10.0),
        padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.blue, width: 5)),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [
            // pw.SizedBox(height: 10),
            pw.Text(
              "|| ગણેશાય નમઃ ||",
              style: pw.TextStyle(
                  fontSize: 20, font: customFont, color: PdfColors.blue),
            ),
            pw.Container(
                padding: pw.EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                decoration: pw.BoxDecoration(
                    // borderRadius: pw.BorderRadius.circular(10.0),
                    border: pw.Border.all(color: PdfColors.blue, width: 5)),
                child: pw.Text(
                  "સહજ હોમ્સ ૩",
                  style: pw.TextStyle(
                      fontSize: 40,
                      font: customFont,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.blue),
                )),

            pw.Text(
              "રાધનપુર રોડ, મહેસાણા-૨",
              style: pw.TextStyle(
                  fontSize: 30, font: customFont, color: PdfColors.blue),
            ),

            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "નામ : ${fullname} ",
                      style: pw.TextStyle(
                          fontSize: 30,
                          font: customFont,
                          color: PdfColors.blue),
                    ),
                    pw.Text(
                      "ઘર નંબર : ${housenumber} ",
                      style: pw.TextStyle(
                          fontSize: 30,
                          font: customFont,
                          color: PdfColors.blue),
                    ),
                  ]),
            ),

            pw.Text(
              "આપે તારીખ:- ${date} ના રોજ પાણી નો બગાડ કરેલ છે.\nતો એના દંડ રૂપે આપને રૂપિયા:- ${rupee} નો દંડ આપવામાં આવે છે.",
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                  fontSize: 30, font: customFont, color: PdfColors.blue),
            ),

            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("તારીખ:- ${date}",
                      style: pw.TextStyle(
                          color: PdfColors.blue,
                          font: customFont,
                          fontSize: 30)),
                  pw.Align(
                      alignment: pw.Alignment.bottomRight,
                      child: pw.Text(
                        "જમા કરનારની સહી:-\n${signature}",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 30,
                            font: customFont,
                            color: PdfColors.blue),
                      ))
                ]),
          ],
        ),
      ),
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
