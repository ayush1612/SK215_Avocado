import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/Screens/pdfviewer.dart';
import 'package:police_app/constants.dart';

class FIR {
  final _firestore = Firestore.instance;

  // to return a file instead of an image
//  Future<File> getImageFileFromAssets(String path) async {
//    final byteData = await rootBundle.load('assets/$path');
//
//    final file = File('${(await getTemporaryDirectory()).path}/$path');
//    await file.writeAsBytes(byteData.buffer
//        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//
//    return file;
//  }

  StreamBuilder<QuerySnapshot> showFIR() {
    print('1');

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('FIR')
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        Future<void> _showMyDialog() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: kActiveCardColor,
                title: Text(
                  'FIR  ACKNOWLEDGEMENT',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
//                    wordSpacing: 1.5,
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('You acknowledged the FIR',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.7,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text('The victim is sent the related details.',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
//                            wordSpacing: 1.5,
                            fontStyle: FontStyle.italic,
                          )),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    color: Colors.blue,
                    child: Text('Confirm'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }

        if (!snapshot.hasData) {
          print('Progress');
          return CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          );
        }
        final items = snapshot.data.documents;
        List<ReusableCard> firWidgets = [
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                  'Here you can view the recent virtual F.I.Rs or complaints.',
                  style: TextStyle(
                    wordSpacing: 2.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.lightBlueAccent,
                    letterSpacing: 2.0,
                  )),
            ),
          )
        ];

        for (var item in items) {
          print(item);
          final unitFir = DataTable(
            columns: [
              DataColumn(
                label: Text(
                  'Attributes',
                  style: kOrderText,
                ),
              ),
              DataColumn(
                label: Text(
                  'Details',
                  style: kOrderText,
                ),
              )
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Crime')),
                DataCell(Text(item['event'] != null ? item['event'] : ' '))
              ]),
              DataRow(cells: [
                DataCell(Text('Place')),
                DataCell(
                  Text(
                    item['place'] != null ? item['place'].toString() : ' ',
                  ),
                ),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Victim',
                )),
                DataCell(
                  Text(item['name'] != null ? item['name'] : ' '),
                )
              ]),
              DataRow(cells: [
                DataCell(Text('Phone')),
                DataCell(Text(item['phone'] != null ? item['phone'] : ' '))
              ]),
              DataRow(cells: [
                DataCell(
                  Text('Email'),
                ),
                DataCell(Text(item['email'] != null ? item['email'] : ' '))
              ]),
              DataRow(cells: [
                DataCell(Text('Identification')),
                DataCell(Text(item['identification'] != null
                    ? item['identification'].toString()
                    : ' '))
              ]),
              DataRow(cells: [
                DataCell(
                  Text('Witness'),
                ),
                DataCell(Text(
                    item['witness'] != null ? item['witness'].toString() : ' '))
              ]),
              DataRow(cells: [
                DataCell(Text('Digital Signature')),
                DataCell(
                    Text(item['signature'] != null ? item['signature'] : ' '))
              ]),
              DataRow(cells: [
                DataCell(Text('Status')),
                DataCell(Text(item['status'] != null ? item['status'] : ' '))
              ])
            ],
          );
          final singleFIR = ReusableCard(
            onPress: () => _generatePdfAndView(context, item),
            colour: kActiveCardColor,
            cardChild: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 20),
                  child: Text(
                    "ID : " + item.documentID.toString(),
//                    style: kItemsStyle,
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.lightBlueAccent,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 8, 0, 0),
                  child: Text(
                    item['date'] != null
                        ? 'Date : ' +
                            (DateTime.fromMillisecondsSinceEpoch(item['date']))
                                .toString()
                        : ' ',
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.cyanAccent,
                    ),
                  ),
                ),
                unitFir,
                (item['status'] == 'pending')
                    ? RaisedButton(
                        child: Text(
                          'Acknowledge',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          if (item['status'] == 'pending') {
                            item.reference.updateData(
                                <String, String>{'status': 'approved'});
                          }
                          _showMyDialog();
                        },
                      )
                    : SizedBox(width: 20),
              ],
            ),
          );
          firWidgets.add(singleFIR);
        }
        return Expanded(
          child: ListView(
            children: firWidgets,
          ),
        );
      },
    );
  }

  _generatePdfAndView(context, item) async {
    final pdf = pdfLib.Document();

    print('starting download');
//    var imageRaw;
//
//    getImageFileFromAssets('images/nia.png')
//        .then((onValue) => {imageRaw = onValue});

//    final image = PdfImage.file(
//      pdf.document,
//      bytes: imageRaw.readAsBytesSync(),
//    );
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
                        bottom: true, width: 0.5, color: PdfColors.grey)),
                child: pdfLib.Text('First Information Report(F.I.R)',
                    style: pdfLib.Theme.of(context).defaultTextStyle.copyWith(
//                        color: PdfColors.blue,
                        fontWeight: pdfLib.FontWeight.bold)));
          },
          footer: (pdfLib.Context context) {
            return pdfLib.Container(
                alignment: pdfLib.Alignment.centerRight,
                margin:
                    const pdfLib.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
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
                    mainAxisAlignment: pdfLib.MainAxisAlignment.spaceBetween,
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
//                pdfLib.Image(image),

                pdfLib.Text('National Investigation Agency',
                    textAlign: pdfLib.TextAlign.left,
                    textScaleFactor: 2.5,
                    style: pdfLib.TextStyle(
                      fontWeight: pdfLib.FontWeight.bold,
                    )),
//                pdfLib.Image(image),

                pdfLib.SizedBox(
                  height: 20,
                ),
                pdfLib.Paragraph(
                  text:
                      'It is a complaint generally filed by the victim or someone else on his/her behalf. When the FIR is registered by the Police, a signed copy is also given to the victim or the same person who filed the FIR. Police cannot refuse to register a FIR as it is against the law.',
                ),

//
//                        'The Portable Document Format (PDF) is a file format developed by Adobe in the 1990s to present documents, including text formatting and images, in a manner independent of application software, hardware, and operating systems. Based on the PostScript language, each PDF file encapsulates a complete description of a fixed-layout flat document, including the text, fonts, vector graphics, raster images and other information needed to display it. PDF was standardized as an open format, ISO 32000, in 2008, and no longer requires any royalties for its implementation.'),
                pdfLib.SizedBox(
                  height: 40,
                ),
                pdfLib.Table.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      <String>['Attribute', 'Details'],
                      <String>['Crime', item['event']],
                      <String>['Victim Name', item['name']],
                      <String>['Place', item['place'].toString()],
                      <String>['Witness', item['witness'].toString()],
                      <String>[
                        'Identification of Criminal',
                        item['identification'].toString()
                      ],
                      <String>['Phone', item['phone']],
                      <String>['Email', item['email']],
                      <String>['Digital Sign.', item['signature']],
                      <String>['Status', item['status']],
                    ]),
                pdfLib.SizedBox(
                  height: 40,
                ),
                pdfLib.Column(
                    crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
                    children: <pdfLib.Widget>[
                      pdfLib.Paragraph(text: item['desc']),
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
                pdfLib.Bullet(text: 'Multimedia objects in the document'),
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
                    level: 1, text: 'File formats and Adobe Acrobat versions'),
                pdfLib.Paragraph(
                    text:
                        'The PDF file format has changed several times, and continues to evolve, along with the release of new versions of Adobe Acrobat. There have been nine versions of PDF and the corresponding version of the software:'),
//                pdfLib.Center(child: pdfLib.Image(image)),
              ]),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);
    final String path = '$dir/fir.pdf';
    print(path);
    final File file = File(path);
    print(file.toString());
    await file.writeAsBytes(pdf.save());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewerPage(path: path),
      ),
    );
  }
}
