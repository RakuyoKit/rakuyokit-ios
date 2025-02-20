//
//  UIWindow+FixCrashOnInputKeyboard.h
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#ifdef RAK_NOT_SUPPORT
#else

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (FixCrashOnInputKeyboard)

/// Used to solve the problem of three-party keyboard crash on iOS 16+
///
/// [iOS 16 UIResponderForwarderWantsForwardingFromResponder Crash problem solution](https://juejin.cn/post/7239742600550613050)
+ (BOOL)isSendEventToDealloctingObject:(UIEvent *)event;

@end

NS_ASSUME_NONNULL_END

#endif
