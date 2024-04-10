#import <Foundation/Foundation.h>

@interface ObjcDelegateProxy: NSObject

@property (nonnull, strong, atomic, readonly) NSSet <NSValue *> *selectors;

- (void)interceptedSelector:(SEL _Nonnull)selector arguments:(NSArray * _Nonnull)arguments;
- (BOOL)respondsToSelector:(SEL _Nonnull)aSelector;
- (BOOL)canRespondToSelector:(SEL _Nonnull)selector;

@end
