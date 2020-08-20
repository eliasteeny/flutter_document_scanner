#import "IPDFCameraViewController.h"
#import <Flutter/Flutter.h>


//@interface DocumentScannerView : IPDFCameraViewController <IPDFCameraViewControllerDelegate>
//
////@property (nonatomic, copy) RCTDirectEventBlock onPictureTaken;
////@property (nonatomic, copy) RCTDirectEventBlock onRectangleDetect;
//@property (nonatomic, assign) NSInteger detectionCountBeforeCapture;
//@property (assign, nonatomic) NSInteger stableCounter;
//@property (nonatomic, assign) float quality;
//@property (nonatomic, assign) BOOL useBase64;
//@property (nonatomic, assign) BOOL captureMultiple;
//@property (nonatomic, assign) BOOL saveInAppDocument;
//-(void)onPictureTaken;
//-(void) onRectangleDetect;
//-(void) capture;
//@end
//
//
//
//#import "IPDFCameraViewController.h"


@interface DocumentScannerView : IPDFCameraViewController <IPDFCameraViewControllerDelegate>

//@property (nonatomic, copy) RCTBubblingEventBlock onPictureTaken;
//@property (nonatomic, copy) RCTBubblingEventBlock onRectangleDetect;
@property (nonatomic, assign) NSInteger detectionCountBeforeCapture;
@property (nonatomic, assign) NSInteger stableCounter;
@property (nonatomic, assign) double durationBetweenCaptures;
@property (nonatomic, assign) double lastCaptureTime;
@property (nonatomic, assign) float quality;
@property (nonatomic, assign) BOOL useBase64;
@property (nonatomic, assign) BOOL captureMultiple;
@property (nonatomic, assign) BOOL saveInAppDocument;
@property (nonatomic, assign) FlutterMethodChannel* flutterChannel;

-(instancetype) init : (float)channelBrightness contrast: (float)channelContrast;

- (instancetype)initWithChannel : (FlutterMethodChannel*) channel;

//- (instancetype)initWithChannelAndArgs : (FlutterMethodChannel*) channel  brightness:(float)channelBrightness contrast: (float)channelContrast;

- (void) capture ;
- (void) onPictureTaken: (NSDictionary*) result;
- (void) onRectangleDetect;
//- (void) setChannelBrightness:(float)brightness;
//- (void) setChannelContrast:(float)contrast;

@end
