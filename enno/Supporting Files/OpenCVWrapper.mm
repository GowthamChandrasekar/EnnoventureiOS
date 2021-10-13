//
//  OpenCVWrapper.m
//  enno
//
//  Created by Vee on 27/09/21.
//

#import "OpenCVWrapper.h"

@implementation OpenCVWrapper
+ (NSString *)openCVVersionString {
return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}
@end
