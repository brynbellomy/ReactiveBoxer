//
//  MGTableBox+RACSupport.h
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BrynKit/BrynKit.h>
#import <BrynKit/RACHelpers.h>
#import <BrynKit/RACFuture.h>
#import <MGBox2/MGBox.h>
#import <MGBox2/MGTableBox.h>
#import <MGBox2/MGLine.h>


@implementation MGTableBox (RACSupport)

- (RACFuture *) bryn_setTopLines: (NSArray *)topLines
              andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.topLines removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self.topLines addObjectsFromArray:topLines];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setMiddleLines: (NSArray *)middleLines
                 andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.middleLines removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self.middleLines addObjectsFromArray:middleLines];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setBottomLines: (NSArray *)bottomLines
                 andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.bottomLines removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self.bottomLines addObjectsFromArray:bottomLines];
    [self layoutWithSpeed:speed completion:nil];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}

@end
