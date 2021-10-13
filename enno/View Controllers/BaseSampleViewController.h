
#import <UIKit/UIKit.h>

#import "SampleBase.h"
#import "SampleFacade.h"

typedef void (^SaveImageCompletionHandler)();

#define kSaveImageActionTitle  @"Save image"

@interface BaseSampleViewController : UIViewController

@property (readonly) SampleFacade * currentSample;

- (void) configureView;
- (void) setSample:(SampleFacade*) sample;
- (void) saveImage:(UIImage*) image  withCompletionHandler: (SaveImageCompletionHandler) handler;

@end
