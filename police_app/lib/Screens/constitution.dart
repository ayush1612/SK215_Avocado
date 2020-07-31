import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class Constitution extends StatefulWidget {
  static String id = '/constitution';
  @override
  _ConstitutionState createState() => _ConstitutionState();
}

class _ConstitutionState extends State<Constitution> {
  String pathPDF = "assets/PDFs/constitution.pdf";

  @override
  void initState() {
    super.initState();
    copyAsset().then((f) {
      setState(() {
//        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<String> copyAsset() async {
    final ByteData bytes = await DefaultAssetBundle.of(context).load(pathPDF);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$pathPDF';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(path: pathPDF);
  }
}
