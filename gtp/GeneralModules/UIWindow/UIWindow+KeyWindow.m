
#import "UIWindow+KeyWindow.h"

@implementation UIWindow (KeyWindow)
+(UIWindow *)keyWindow{
    static UIWindow *keyWindow = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyWindow = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return keyWindow;
}
@end
