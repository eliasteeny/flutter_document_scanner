#import "DocumentScannerView.h"
#import "IPDFCameraViewController.h"

@implementation DocumentScannerView



//- (instancetype)init{
//    self = [super init];
//
//    NSLog(@"setting args ...");
//         self.detectionRefreshRateInMS = 55;
//        self.overlayColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 1.00];
//        self.enableTorch = true;
//        self.useFrontCam = false;
//        self.useBase64 = false;
//        self.saveInAppDocument = true;
//        self.captureMultiple = false;
//        self.detectionCountBeforeCapture = 5;
//        self.detectionRefreshRateInMS = 50;
//        self.saturation = 1;
//        self.quality = 1;
////        self.brightness = channelBrightness;
////        self.contrast = channelContrast;
//    self.brightness = 0;
//    self.contrast = 1;
//    self.durationBetweenCaptures = 0;
//
//
//    if (self) {
//
//        [self setEnableBorderDetection:YES];
//        [self setDelegate: self];
//    }
//
//    return self;
//}
- (instancetype)init{
    self = [super init];

     //RCT_EXPORT_VIEW_PROPERTY(onPictureTaken, RCTBubblingEventBlock)
        //RCT_EXPORT_VIEW_PROPERTY(onRectangleDetect, RCTBubblingEventBlock)






        //RCT_EXPORT_VIEW_PROPERTY(durationBetweenCaptures, double)


        //
        //RCT_EXPORT_METHOD(capture:(nonnull NSNumber *)reactTag)

//    NSLog(@"brightness : %f",channelBrightness);
//    NSLog(@"contrast : %f",channelContrast);
         self.detectionRefreshRateInMS = 50;
        self.overlayColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50];
        self.enableTorch = false;
        self.useFrontCam = false;
        self.useBase64 = false;
        self.saveInAppDocument = true;
        self.captureMultiple = false;
        self.detectionCountBeforeCapture = 8;
        self.detectionRefreshRateInMS = 50;
        self.saturation = 1;
        self.quality = 1;
//        self.brightness = channelBrightness;
//        self.contrast = channelContrast;
    self.brightness = 0.2;
    self.contrast = 1.4;
    self.durationBetweenCaptures = 0;


    if (self) {

        [self setEnableBorderDetection:YES];
        [self setDelegate: self];
    }

    return self;
}

-(instancetype) initWithChannel:(FlutterMethodChannel *)channel {
      DocumentScannerView* instance = [DocumentScannerView new];
      instance.flutterChannel = channel;

    
      return instance;
}
//-(instancetype)initWithChannelAndArgs:(FlutterMethodChannel *)channel brightness:(float)channelBrightness contrast:(float)channelContrast {
//    DocumentScannerView* instance = [[DocumentScannerView alloc] init:channelBrightness contrast:channelContrast];
//    instance.flutterChannel = channel;
//
//
//    return instance;
//}

-(void) onPictureTaken {
    printf("on picture taken");
}

-(void) onRectangleDetect {
    printf("on rect detect");
}

//- (void)setChannelBrightness:(float)brightness {
//    self.brightness = brightness;
//}
//
//- (void)setChannelContrast:(float)contrast {
//    self.contrast = contrast;
//}


- (void) didDetectRectangle:(CIRectangleFeature *)rectangle withType:(IPDFRectangeType)type {
    switch (type) {
        case IPDFRectangeTypeGood:
            self.stableCounter ++;
            break;
        default:
            self.stableCounter = 0;
            break;
    }
//    if (self.onRectangleDetect) {
//        self.onRectangleDetect(@{@"stableCounter": @(self.stableCounter), @"lastDetectionType": @(type)});
//    }
//
    if (self.stableCounter > self.detectionCountBeforeCapture &&
        [NSDate timeIntervalSinceReferenceDate] > self.lastCaptureTime + self.durationBetweenCaptures) {
        self.lastCaptureTime = [NSDate timeIntervalSinceReferenceDate];
        self.stableCounter = 0;
        [self capture];
    }
}
- (void) onPictureTaken: (NSDictionary*) result {
    printf("on picture taken");
}

- (void) capture {
    
    [self captureImageWithCompletionHander:^(UIImage *croppedImage, UIImage *initialImage, CIRectangleFeature *rectangleFeature) {
//      if (self.onPictureTaken) {
            NSData *croppedImageData = UIImageJPEGRepresentation(croppedImage, self.quality);

            if (initialImage.imageOrientation != UIImageOrientationUp) {
                UIGraphicsBeginImageContextWithOptions(initialImage.size, false, initialImage.scale);
                [initialImage drawInRect:CGRectMake(0, 0, initialImage.size.width
                                                    , initialImage.size.height)];
                initialImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            NSData *initialImageData = UIImageJPEGRepresentation(initialImage, self.quality);

            /*
             RectangleCoordinates expects a rectanle viewed from portrait,
             while rectangleFeature returns a rectangle viewed from landscape, which explains the nonsense of the mapping below.
             Sorry about that.
             */
            id rectangleCoordinates = rectangleFeature ? @{
                                     @"topLeft": @{ @"y": @(rectangleFeature.bottomLeft.x + 30), @"x": @(rectangleFeature.bottomLeft.y)},
                                     @"topRight": @{ @"y": @(rectangleFeature.topLeft.x + 30), @"x": @(rectangleFeature.topLeft.y)},
                                     @"bottomLeft": @{ @"y": @(rectangleFeature.bottomRight.x), @"x": @(rectangleFeature.bottomRight.y)},
                                     @"bottomRight": @{ @"y": @(rectangleFeature.topRight.x), @"x": @(rectangleFeature.topRight.y)},
                                     } : [NSNull null];
            if (self.useBase64) {
                
               dispatch_async(dispatch_get_main_queue(), ^{
                       printf("calling flutter onPictureTaken base64");
                           [self->_flutterChannel invokeMethod:@"onPictureTaken" arguments:@{
                           @"croppedImage": [croppedImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength],
                           @"initialImage": [initialImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength],
                           @"rectangleCoordinates": rectangleCoordinates }];
               });
          
//              onPictureTaken(@{
//                                    @"croppedImage": [croppedImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength],
//                                    @"initialImage": [initialImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength],
//                                    @"rectangleCoordinates": rectangleCoordinates });
            }
            else {
                NSString *dir = NSTemporaryDirectory();
                if (self.saveInAppDocument) {
                    dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                }
               NSString *croppedFilePath = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"cropped_img_%i.jpeg",(int)[NSDate date].timeIntervalSince1970]];
               NSString *initialFilePath = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"initial_img_%i.jpeg",(int)[NSDate date].timeIntervalSince1970]];

              [croppedImageData writeToFile:croppedFilePath atomically:YES];
              [initialImageData writeToFile:initialFilePath atomically:YES];
                
           
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                        printf("calling flutter onPictureTaken file");
//                    NSLog(croppedFilePath);
//                    NSLog(initialFilePath);
//                    NSLog(rectangleCoordinates);
                   
                    [self->_flutterChannel invokeMethod:@"onPictureTaken" arguments:@{
                        @"croppedImage": croppedFilePath,
                        @"initialImage": initialFilePath,
                        @"rectangleCoordinates": rectangleCoordinates
                        
                        }];
                    
                });


//                self.onPictureTaken(@{
//                                     @"croppedImage": croppedFilePath,
//                                     @"initialImage": initialFilePath,
//                                     @"rectangleCoordinates": rectangleCoordinates });
            }
//        }

        if (!self.captureMultiple) {
          [self stop];
        }
    }];

}


@end
