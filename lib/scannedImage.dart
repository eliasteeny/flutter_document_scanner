import 'dart:io';

/// rectangleCoordinates : contains the coordinates of the scanned rectangle from the whole image
/// croppedImage : the image file location of the scanned rectangle
/// initialImage : the image file location of the whole image
/// getScannedDocumentAsFile() : returns the image of the scanned rectangle as a file

class ScannedImage {
  RectangleCoordinates rectangleCoordinates;
  String croppedImage;

  String initialImage;

  ScannedImage._constructor({
    this.rectangleCoordinates,
    this.croppedImage,
    this.initialImage,
  });

  factory ScannedImage.fromMap(Map<String, dynamic> json) =>
      ScannedImage._constructor(
        rectangleCoordinates: json["rectangleCoordinates"] == null
            ? null
            : RectangleCoordinates.fromMap(json["rectangleCoordinates"]),
        croppedImage:
            json["croppedImage"] == null ? null : json["croppedImage"],
        initialImage:
            json["initialImage"] == null ? null : json["initialImage"],
      );

  File getScannedDocumentAsFile() => File.fromUri(
        Uri.parse(croppedImage),
      );
}

class RectangleCoordinates {
  RectanglePoint bottomLeft;
  RectanglePoint bottomRight;
  RectanglePoint topLeft;
  RectanglePoint topRight;

  RectangleCoordinates({
    this.bottomLeft,
    this.bottomRight,
    this.topLeft,
    this.topRight,
  });

  factory RectangleCoordinates.fromMap(Map<String, dynamic> json) =>
      RectangleCoordinates(
        bottomLeft: json["bottomLeft"] == null
            ? null
            : RectanglePoint.fromMap(json["bottomLeft"]),
        bottomRight: json["bottomRight"] == null
            ? null
            : RectanglePoint.fromMap(json["bottomRight"]),
        topLeft: json["topLeft"] == null
            ? null
            : RectanglePoint.fromMap(json["topLeft"]),
        topRight: json["topRight"] == null
            ? null
            : RectanglePoint.fromMap(json["topRight"]),
      );
}

class RectanglePoint {
  int x;
  int y;

  RectanglePoint({
    this.x,
    this.y,
  });

  factory RectanglePoint.fromMap(Map<String, dynamic> json) => RectanglePoint(
        x: json["x"] == null ? null : json["x"],
        y: json["y"] == null ? null : json["y"],
      );
}
