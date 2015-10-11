@import UIKit;

#if DEBUG

@interface UIDynamicAnimator (DebuggingOnly)
@property (nonatomic, getter=isDebugEnabled) BOOL debugEnabled;
@end

#endif