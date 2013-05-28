//
//  MGTableBox+RACSupport.m
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <MGBox2/MGTableBox.h>

@interface MGTableBox (BrynKit)

- (RACFuture *) bryn_setTopLines:(NSArray *)topLines       andLayoutWithSpeed:(NSTimeInterval)speed;
- (RACFuture *) bryn_setMiddleLines:(NSArray *)middleLines andLayoutWithSpeed:(NSTimeInterval)speed;
- (RACFuture *) bryn_setBottomLines:(NSArray *)bottomLines andLayoutWithSpeed:(NSTimeInterval)speed;

@end
