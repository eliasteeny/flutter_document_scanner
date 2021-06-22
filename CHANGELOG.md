## 0.2.1
* Android : added noGrayScale option.
* Android : added opencv jnilibs through jitpack for reduced package size

## 0.2.0
* Migrated to null safety.
* Added a bit of documentation.
* Upgraded dependencies to the latest version.

## 0.1.2

* Android : fixed a bug that was sometimes crashing the app after scanning the document.

## 0.1.1

* Android : fixed a bug that caused **onDocumentScanned** getting called with a null document.
* Android : fixed a bug that was sometimes crashing the app.
* Android : changed scanned document image save location from external storage to internal cache directory.

## 0.1.0

* Document Scanner property : **onPictureTaken** name changed to **onDocumentScanned**
* Document Scannner **onDocumentScanned** argument changed from **String** (scanned document location) to **ScannedImage** object that holds more information about the scanned document
* Added **getScannedDocumentAsFile()** method on class  **ScannedImage**  

## 0.0.4

* made the initial setup for android much easier

## 0.0.3

* added android instructions

## 0.0.2

* added IOS support

## 0.0.1

* inital alpha release
* needs testing for android
