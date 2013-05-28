//
//  MGLine+RACSupport.m
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 4.2.2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BrynKit/BrynKit.h>
#import <BrynKit/RACHelpers.h>
#import <BrynKit/RACFuture.h>
#import <MGBox2/MGBox.h>
#import <MGBox2/MGTableBox.h>
#import <MGBox2/MGLine.h>

@implementation MGLine (RACSupport)

- (RACFuture *) bryn_setLeftItems: (NSArray *)leftItems
               andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.leftItems removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self setLeftItems:(NSMutableArray *)leftItems];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setMiddleItems: (NSArray *)middleItems
                 andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.middleItems removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self setMiddleItems:(NSMutableArray *)middleItems];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setRightItems: (NSArray *)rightItems
                andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.rightItems removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self setRightItems:(NSMutableArray *)rightItems];
    [self layoutWithSpeed:speed completion:nil];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setMultilineLeft: (NSString *)multilineLeft
                   andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

//    [self.multilineLeft removeAllObjects];
//    [self.boxes removeAllObjects];
//    [self layout];

    self.multilineLeft = multilineLeft;

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}

@end





