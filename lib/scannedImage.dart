// To parse this JSON data, do
//
//     final scannedImage = scannedImageFromJson(jsonString);

import 'dart:convert';

ScannedImage scannedImageFromJson(String str) =>
    ScannedImage.fromMap(json.decode(str));

String scannedImageToJson(ScannedImage data) => json.encode(data.toMap());

class ScannedImage {
  RectangleCoordinates rectangleCoordinates;
  String croppedImage;
  int width;
  String initialImage;
  int height;

  ScannedImage({
    this.rectangleCoordinates,
    this.croppedImage,
    this.width,
    this.initialImage,
    this.height,
  });

  factory ScannedImage.fromMap(Map<String, dynamic> json) => ScannedImage(
        rectangleCoordinates: json["rectangleCoordinates"] == null
            ? null
            : RectangleCoordinates.fromMap(json["rectangleCoordinates"]),
        croppedImage:
            json["croppedImage"] == null ? null : json["croppedImage"],
        width: json["width"] == null ? null : json["width"],
        initialImage:
            json["initialImage"] == null ? null : json["initialImage"],
        height: json["height"] == null ? null : json["height"],
      );

  Map<String, dynamic> toMap() => {
        "rectangleCoordinates":
            rectangleCoordinates == null ? null : rectangleCoordinates.toMap(),
        "croppedImage": croppedImage == null ? null : croppedImage,
        "width": width == null ? null : width,
        "initialImage": initialImage == null ? null : initialImage,
        "height": height == null ? null : height,
      };
}

class RectangleCoordinates {
  BottomLeft bottomLeft;
  BottomLeft bottomRight;
  BottomLeft topLeft;
  BottomLeft topRight;

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
            : BottomLeft.fromMap(json["bottomLeft"]),
        bottomRight: json["bottomRight"] == null
            ? null
            : BottomLeft.fromMap(json["bottomRight"]),
        topLeft: json["topLeft"] == null
            ? null
            : BottomLeft.fromMap(json["topLeft"]),
        topRight: json["topRight"] == null
            ? null
            : BottomLeft.fromMap(json["topRight"]),
      );

  Map<String, dynamic> toMap() => {
        "bottomLeft": bottomLeft == null ? null : bottomLeft.toMap(),
        "bottomRight": bottomRight == null ? null : bottomRight.toMap(),
        "topLeft": topLeft == null ? null : topLeft.toMap(),
        "topRight": topRight == null ? null : topRight.toMap(),
      };
}

class BottomLeft {
  int x;
  int y;

  BottomLeft({
    this.x,
    this.y,
  });

  factory BottomLeft.fromMap(Map<String, dynamic> json) => BottomLeft(
        x: json["x"] == null ? null : json["x"],
        y: json["y"] == null ? null : json["y"],
      );

  Map<String, dynamic> toMap() => {
        "x": x == null ? null : x,
        "y": y == null ? null : y,
      };
}
