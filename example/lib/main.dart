import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:document_scanner/document_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String imageLocation;
  bool enableTorch;
  @override
  void initState() {
    enableTorch = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(!enableTorch ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              setState(() {
                enableTorch = !enableTorch;
              });
            }),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: imageLocation != null
                      ? Image(
                          image:
                              FileImage(File.fromUri(Uri.file(imageLocation))))
                      : DocumentScanner(
                          onPictureTaken: (String image) {
                            print("document : " + image);

                            setState(() {
                              imageLocation = image.replaceRange(0, 7, "");
                              // imageLocation = image;
                            });

                            print("document : " + imageLocation);
                          },
                          brightness: 5,
                          contrast: 1.3,
                          enableTorch: enableTorch,
                        ),
                ),
              ],
            ),
            imageLocation != null
                ? Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: RaisedButton(
                        child: Text("retry"),
                        onPressed: () {
                          setState(() {
                            imageLocation = null;
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
