
#import "VideoViewController.h"
#import "UIImage2OpenCV.h"
#import <opencv2/videoio/cap_ios.h>
#define kTransitionDuration    0.75
#import "ContourDetectionSample.h"
#import "SampleFacade.h"
@interface VideoViewController ()<CvVideoCameraDelegate>
{
    cv::Mat outputFrame;
    BOOL isCapturing;

}
@property (nonatomic, strong) CvVideoCamera* videoSource;

@end

@implementation VideoViewController

@synthesize videoSource;
//@synthesize actionSheetButton;
//@synthesize captureReferenceFrameButton;
//@synthesize clearReferenceFrameButton;
//@synthesize options;
//@synthesize toggleCameraButton;
@synthesize containerView;
//@synthesize optionsPopover;
//@synthesize optionsView;
//@synthesize optionsViewController;
//@synthesize actionSheet;
@synthesize statusLabel;
@synthesize captureButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSample:[[SampleFacade alloc] initWithSample:  new ContourDetectionSample()]];
    self.videoSource = [[CvVideoCamera alloc] initWithParentView:self.containerView];
    self.videoSource.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoSource.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1280x720;
    self.videoSource.defaultFPS = 30;
    self.videoSource.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    //self.videoSource.imageWidth = 1280;
    //self.videoSource.imageHeight = 720;
    self.videoSource.delegate = self;
    self.videoSource.recordVideo = NO;
    self.videoSource.grayscaleMode = NO;
    self.videoSource.rotateVideo = YES;
    
    isCapturing = YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"capture session loaded: %d", [self.videoSource captureSessionLoaded]);
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.videoSource start];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.videoSource stop];
}

- (void) configureView
{
    [super configureView];

    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UIViewController * viewController = [[UIViewController alloc] init];
//        viewController.view = self.optionsView;
        viewController.title = @"Algorithm options";
        
//        self.optionsViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        
//        self.optionsPopover = [[UIPopoverController alloc] initWithContentViewController:self.optionsViewController];
    }
}


- (IBAction)captureButtonClick:(id)sender {
    
}

//- (IBAction)showActionSheet:(id)sender
//{
//    isCapturing=YES;
////  [self presentViewController:self.actionSheet animated:YES completion:nil];
//}

- (void)viewDidUnload
{
//    [self setToggleCameraButton:nil];
    [self setContainerView:nil];
//    [self setOptions:nil];
//    [self setActionSheetButton:nil];
//    [self setCaptureReferenceFrameButton:nil];
//    [self setClearReferenceFrameButton:nil];
    
    [super viewDidUnload];
}

//- (IBAction)showOptions:(id)sender
//{
//    isCapturing=YES;
//
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//    {
//        if ([self.optionsView superview])
//        {
//            [UIView transitionFromView:self.optionsView
//                                toView:self.containerView
//                              duration:kTransitionDuration
//                               options:UIViewAnimationOptionTransitionFlipFromLeft
//                            completion:^(BOOL)
//             {
//             }];
//        }
//        else
//        {
//            [self.optionsView setFrame:self.containerView.frame];
//            [self.optionsView setNeedsLayout];
//
//            [UIView transitionFromView:self.containerView
//                                toView:self.optionsView
//                              duration:kTransitionDuration
//                               options:UIViewAnimationOptionTransitionFlipFromLeft
//                            completion:^(BOOL)
//             {
//                 [self.optionsView reloadData];
//             }];
//        }
//    }
//    else
//    {
//        if ([self.optionsPopover isPopoverVisible])
//            [self.optionsPopover dismissPopoverAnimated:YES];
//        else
//            [self.optionsPopover presentPopoverFromBarButtonItem:options permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }
//}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus
- (void) processImage:(cv::Mat&)image
{
    // Do some OpenCV stuff with the image
    NSString *blur = [self.currentSample processFrameStr:image into:outputFrame];
    NSLog(@"%@", blur);
    dispatch_async(dispatch_get_main_queue(), ^{
        self->statusLabel.text = blur;
        NSString *strLabelText = self->statusLabel.text;
             });
//    [self.currentSample processFrame:image into:outputFrame];
    
    
    //outputFrame.copyTo(image);
}
#endif

//- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    [super didRotateFromInterfaceOrientation: fromInterfaceOrientation];
//    [self.videoSource adjustLayoutToInterfaceOrientation:self.interfaceOrientation];
//}

#pragma mark - Capture reference frame

- (IBAction) captureReferenceFrame:(id) sender
{
    dispatch_async( dispatch_get_main_queue(),
                   ^{
                       [self.currentSample setReferenceFrame:outputFrame];
                   });
}

#pragma mark - Clear reference frame

- (IBAction) clearReferenceFrame:(id) sender
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self.currentSample resetReferenceFrame];
                   });
}

@end
