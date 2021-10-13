
#import "NSString+StdString.h"

@implementation NSString (StdString)

+ (NSString*) stringWithStdString: (const std::string&) str
{
  return [[NSString alloc] initWithCString:str.c_str() encoding:NSASCIIStringEncoding];
}

@end
