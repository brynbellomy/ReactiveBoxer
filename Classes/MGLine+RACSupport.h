//
//  MGLine+RACSupport.h
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 4.2.2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <MGBox2/MGLine.h>

@class RACFuture;

@interface MGLine (BrynKit)

- (RACFuture *) bryn_setLeftItems:   (NSArray *)leftItems   andLayoutWithSpeed:(NSTimeInterval)speed;
- (RACFuture *) bryn_setMiddleItems: (NSArray *)middleItems andLayoutWithSpeed:(NSTimeInterval)speed;
- (RACFuture *) bryn_setRightItems:  (NSArray *)rightItems  andLayoutWithSpeed:(NSTimeInterval)speed;
- (RACFuture *) bryn_setMultilineLeft:(NSString *)multilineLeft andLayoutWithSpeed:(NSTimeInterval)speed;

@end
