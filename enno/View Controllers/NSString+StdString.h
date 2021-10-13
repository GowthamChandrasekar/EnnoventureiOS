

#import <Foundation/Foundation.h>

@interface NSString (StdString)

+ (NSString*) stringWithStdString: (const std::string&) str;


@end
