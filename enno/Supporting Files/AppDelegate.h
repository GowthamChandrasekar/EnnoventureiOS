//
//  AppDelegate.h
//  enno
//
//  Created by Vee on 27/09/21.
//

#import <UIKit/UIKit.h>
#import "SampleBase.h"
#import "SampleFacade.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
@public
  std::vector<SampleFacade*> allSamples;
}
@property (strong, nonatomic) UIWindow *window;

@end

