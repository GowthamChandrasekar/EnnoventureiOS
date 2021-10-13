
#import <Foundation/Foundation.h>
#import "SampleBase.h"
#import "BaseSampleViewController.h"

@interface VideoViewController : BaseSampleViewController

@property (weak, nonatomic) IBOutlet UIImageView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *captureButton;

- (IBAction)captureButtonClick:(id)sender;

@end

