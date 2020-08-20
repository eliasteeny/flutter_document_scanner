#import <Flutter/Flutter.h>
#import "DocumentScannerView.h"

@interface DocumentScannerFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
@end


@interface ScannerController :  NSObject < FlutterPlatformView>
@property (strong, nonatomic) DocumentScannerView *scannerView;
-(instancetype)initWithFrame:(CGRect)frame
              viewIdentifier:(int64_t)viewId
                   arguments:(id _Nullable)args
                   registrar:(NSObject<FlutterPluginRegistrar>*)registrar ;
@end
