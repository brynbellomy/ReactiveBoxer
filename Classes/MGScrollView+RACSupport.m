//
//  MGScrollView+RACSupport.m
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 4.2.2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BrynKit/BrynKit.h>
#import <BrynKit/RACHelpers.h>
#import <BrynKit/RACFuture.h>
#import <MGBox2/MGScrollView.h>


@implementation MGScrollView (RACSupport)

- (RACFuture *) bryn_layoutWithSpeed:(NSTimeInterval)speed
{
    yssert_onMainThread();

    RACFuture *future = [RACFuture future];

    [self layoutWithSpeed:speed
               completion:^{
                   [future resolve];
               }];

    return future;
}

@end
