import 'dart:io';

import 'package:flutter/material.dart';

import 'package:document_scanner/document_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File scannedDocument;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: scannedDocument != null
                      ? Image(
                          image: FileImage(scannedDocument),
                        )
                      : DocumentScanner(
                          onDocumentScanned: (ScannedImage scannedImage) {
                            print("document : " + scannedImage.croppedImage);

                            setState(() {
                              scannedDocument =
                                  scannedImage.getScannedDocumentAsFile();
                              // imageLocation = image;
                            });
                          },
                        ),
                ),
              ],
            ),
            scannedDocument != null
                ? Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: RaisedButton(
                        child: Text("retry"),
                        onPressed: () {
                          setState(() {
                            scannedDocument = null;
                          });
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
