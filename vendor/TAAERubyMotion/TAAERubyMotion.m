#import "TAAERubyMotion.h"
 
@implementation AEBlockChannel (RubyMotionBlockTypeWrapper)
 
// Here we define the implementation that does nothing else than forward
// the method call to the normal library’s API. You could say we are
// ‘aliasing’ the method (although we do change the interface).
+ (AEBlockChannel*)channelWithBlock:(AEBlockChannelBlock)block;
{
  // NSLog(@"This code is being called");
  return [self channelWithBlock:block];
}

@end
