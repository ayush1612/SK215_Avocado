import 'package:citizen_app/Screens/pdfViewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import 'dart:io';

class FIR extends StatelessWidget {
  const FIR({
    Key key,
    @required this.id,
    @required this.data,
  }) : super(key: key);

  final String id;
  final DocumentSnapshot data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: () async {
                final pdf = pdfLib.Document();

                final font =
                    await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
                final ttf = pdfLib.Font.ttf(font);

                pdf.addPage(
                  pdfLib.MultiPage(
                      pageFormat: PdfPageFormat.letter
                          .copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
                      crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
                      header: (pdfLib.Context context) {
                        if (context.pageNumber == 1) {
                          return null;
                        }
                        return pdfLib.Container(
                            alignment: pdfLib.Alignment.centerRight,
                            margin: const pdfLib.EdgeInsets.only(
                                bottom: 3.0 * PdfPageFormat.mm),
                            padding: const pdfLib.EdgeInsets.only(
                                bottom: 3.0 * PdfPageFormat.mm),
                            decoration: const pdfLib.BoxDecoration(
                                border: pdfLib.BoxBorder(
                                    bottom: true,
                                    width: 0.5,
                                    color: PdfColors.grey)),
                            child: pdfLib.Text(
                                'First Information Report(F.I.R)',
                                style: pdfLib.Theme.of(context)
                                    .defaultTextStyle
                                    .copyWith(
                                        fontWeight: pdfLib.FontWeight.bold)));
                      },
                      footer: (pdfLib.Context context) {
                        return pdfLib.Container(
                            alignment: pdfLib.Alignment.centerRight,
                            margin: const pdfLib.EdgeInsets.only(
                                top: 1.0 * PdfPageFormat.cm),
                            child: pdfLib.Text(
                                'Page ${context.pageNumber} of ${context.pagesCount}',
                                style: pdfLib.Theme.of(context)
                                    .defaultTextStyle
                                    .copyWith(color: PdfColors.grey)));
                      },
                      build: (context) => [
                            pdfLib.Header(
                              level: 0,
                              child: pdfLib.Row(
                                mainAxisAlignment:
                                    pdfLib.MainAxisAlignment.spaceBetween,
                                children: <pdfLib.Widget>[
                                  pdfLib.Text('First Information Report(F.I.R)',
                                      textScaleFactor: 1.5),
                                  pdfLib.PdfLogo()
                                ],
                              ),
                            ),
                            pdfLib.SizedBox(
                              height: 20,
                            ),
                            pdfLib.Text('National Investigation Agency',
                                textAlign: pdfLib.TextAlign.left,
                                textScaleFactor: 2.5,
                                style: pdfLib.TextStyle(
                                  fontWeight: pdfLib.FontWeight.bold,
                                )),
                            pdfLib.SizedBox(
                              height: 20,
                            ),
                            pdfLib.Paragraph(
                              text:
                                  'It is a complaint generally filed by the victim or someone else on his/her behalf. When the FIR is registered by the Police, a signed copy is also given to the victim or the same person who filed the FIR. Police cannot refuse to register a FIR as it is against the law.',
                            ),
                            pdfLib.SizedBox(
                              height: 40,
                            ),
                            pdfLib.Table.fromTextArray(
                                context: context,
                                data: <List<String>>[
                                  <String>['Attribute', 'Details'],
                                  <String>['Crime', data['event']],
                                  <String>['Victim Name', data['name']],
                                  <String>['Place', data['place'].toString()],
                                  <String>[
                                    'Witness',
                                    data['witness'].toString()
                                  ],
                                  <String>[
                                    'Identification of Criminal',
                                    data['identification'].toString()
                                  ],
                                  <String>['Phone', data['phone']],
                                  <String>['Email', data['email']],
                                  <String>['Digital Sign.', data['signature']],
                                ]),
                            pdfLib.SizedBox(
                              height: 40,
                            ),
                            pdfLib.Column(
                                crossAxisAlignment:
                                    pdfLib.CrossAxisAlignment.start,
                                children: <pdfLib.Widget>[
                                  pdfLib.Paragraph(text: data['desc']),
                                  pdfLib.Bullet(
                                      text:
                                          'PDF contains tokenized and interpreted results of the PostScript source code, for direct correspondence between changes to items in the PDF page description and changes to the resulting page appearance.'),
                                  pdfLib.Bullet(
                                      text:
                                          'PDF (from version 1.4) supports graphic transparency; PostScript does not.'),
                                  pdfLib.Bullet(
                                      text:
                                          'PostScript is an interpreted programming language with an implicit global state, so instructions accompanying the description of one page can affect the appearance of any following page. Therefore, all preceding pages in a PostScript document must be processed to determine the correct appearance of a given page, whereas each page in a PDF document is unaffected by the others. As a result, PDF viewers allow the user to quickly jump to the final pages of a long document, whereas a PostScript viewer needs to process all pages sequentially before being able to display the destination page (unless the optional PostScript Document Structuring Conventions have been carefully complied with).'),
                                ]),
                            pdfLib.Header(level: 1, text: 'Content'),
                            pdfLib.Paragraph(
                                text:
                                    'A PDF file is often a combination of vector graphics, text, and bitmap graphics. The basic types of content in a PDF are:'),
                            pdfLib.Bullet(
                                text:
                                    'Text stored as content streams (i.e., not encoded in plain text)'),
                            pdfLib.Bullet(
                                text:
                                    'Vector graphics for illustrations and designs that consist of shapes and lines'),
                            pdfLib.Bullet(
                                text:
                                    'Raster graphics for photographs and other types of image'),
                            pdfLib.Bullet(
                                text: 'Multimedia objects in the document'),
                            pdfLib.Paragraph(
                                text:
                                    'In later PDF revisions, a PDF document can also support links (inside document or web page), forms, JavaScript (initially available as plugin for Acrobat 3.0), or any other types of embedded contents that can be handled using plug-ins.'),
                            pdfLib.Paragraph(
                                text:
                                    'PDF 1.6 supports interactive 3D documents embedded in the PDF - 3D drawings can be embedded using U3D or PRC and various other data formats.'),
                            pdfLib.Paragraph(
                                text:
                                    'Two PDF files that look similar on a computer screen may be of very different sizes. For example, a high resolution raster image takes more space than a low resolution one. Typically higher resolution is needed for printing documents than for displaying them on screen. Other things that may increase the size of a file is embedding full fonts, especially for Asiatic scripts, and storing text as graphics. '),
                            pdfLib.Header(
                                level: 1,
                                text:
                                    'File formats and Adobe Acrobat versions'),
                            pdfLib.Paragraph(
                                text:
                                    'The PDF file format has changed several times, and continues to evolve, along with the release of new versions of Adobe Acrobat. There have been nine versions of PDF and the corresponding version of the software:'),
                          ]),
                );

                final dir = (await getExternalStorageDirectory()).path;
                print(dir);
                final file = File('$dir/fir.pdf');
                print(file);
                print(await file.writeAsBytes(pdf.save()));
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PdfViewerPage(path: '$dir/fir.pdf'),
                  ),
                );
              }),
        ],
        title: Text(
          'ID: $id',
        ),
        flexibleSpace: Container(
          decoration: kAppBarBoxDecoration,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'FIR',
              textAlign: TextAlign.center,
              style: kWidgetNormalText,
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/img/FIR4.png',
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  color: kActiveCardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Attributes',
                                style: TextStyle(color: Color(0xFFbbe1fa)),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Details',
                                style: TextStyle(color: Color(0xFFbbe1fa)),
                              ),
                            )
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('Filed on')),
                              DataCell(Text(data['date'] != null
                                  ? DateTime.fromMicrosecondsSinceEpoch(
                                          data['date'])
                                      .toString()
                                      .substring(0, 10)
                                  : ' '))
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Crime')),
                              DataCell(Text(
                                  data['event'] != null ? data['event'] : ' '))
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Place')),
                              DataCell(
                                Text(
                                  data['place'] != null
                                      ? data['place'].toString()
                                      : ' ',
                                ),
                              ),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                'Victim',
                              )),
                              DataCell(
                                Text(data['name'] != null ? data['name'] : ' '),
                              )
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Phone')),
                              DataCell(Text(
                                  data['phone'] != null ? data['phone'] : ' '))
                            ]),
                            DataRow(cells: [
                              DataCell(
                                Text('Email'),
                              ),
                              DataCell(Text(
                                  data['email'] != null ? data['email'] : ' '))
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Identification')),
                              DataCell(Text(data['identification'] != null
                                  ? data['identification'].toString()
                                  : ' '))
                            ]),
                            DataRow(cells: [
                              DataCell(
                                Text('Witness'),
                              ),
                              DataCell(Text(data['witness'] != null
                                  ? data['witness'].toString()
                                  : ' '))
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Digital Signature')),
                              DataCell(Text(data['signature'] != null
                                  ? data['signature']
                                  : ' '))
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
