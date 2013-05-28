//
//  MGBox+RACSupport.m
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


@implementation MGBox (RACSupport)

- (RACSignal *) rac_onTap
{
    // @@TODO: enable 'tappable' whenever this is subscribed to
//    self.tappable = YES;

   return [[RACSignal combineLatest:@[ [self.tapper                     rac_signalForGestures],
                                       [RACAbleWithStart(self.tappable)  distinctUntilChanged], ]

                             reduce:^id (UIGestureRecognizer *recognizer, NSNumber *tappable) {
                                 return (tappable.boolValue == NO ? nil : self);
                             }]
                             notNil];
}



- (RACFuture *) bryn_setBoxes:(NSMutableOrderedSet *)boxes
           andLayoutWithSpeed:(NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.boxes removeAllObjects];
    [self layout];

    [self.boxes addObjectsFromArray: [boxes array]];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}

@end



