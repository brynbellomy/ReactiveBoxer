//
//  RACTableBox.m
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <BrynKit/BrynKit.h>
#import <BrynKit/RACHelpers.h>
#import <BrynKit/RACFuture.h>
#import <BrynKit/MGBoxHelpers.h>

#import "RACTableBox.h"


@interface RACTableBox ()
    @property (nonatomic, strong, readwrite) RACSubject *internalSubject_didUpdateContents;
@end



@implementation RACTableBox {}

+ (instancetype) boxWithTopLinesSignal: (RACSignal *)signal_top
                     middleLinesSignal: (RACSignal *)signal_middle
                     bottomLinesSignal: (RACSignal *)signal_bottom
                                  size: (CGSize)size
{
    RACTableBox *table = [[self alloc] initWithTopLinesSignal:signal_top middleLinesSignal:signal_middle bottomLinesSignal:signal_bottom size:size];
    yssert_notNilAndIsClass(table, RACTableBox);
    return table;
}



- (instancetype) initWithTopLinesSignal: (RACSignal *)signal_top
                      middleLinesSignal: (RACSignal *)signal_middle
                      bottomLinesSignal: (RACSignal *)signal_bottom
                                   size: (CGSize)size
{
    self = [self initWithFrame: CGRectMake(0, 0, size.width, size.height)];
    if (self)
    {
        RACSignal *signal_topLinesLayout    = [self rac_liftSelector:@selector(bryn_setTopLines:andLayoutWithSpeed:)    withObjects: [signal_top    onMainThreadScheduler], @0.3f];
        RACSignal *signal_middleLinesLayout = [self rac_liftSelector:@selector(bryn_setMiddleLines:andLayoutWithSpeed:) withObjects: [signal_middle onMainThreadScheduler], @0.3f];
        RACSignal *signal_bottomLinesLayout = [self rac_liftSelector:@selector(bryn_setBottomLines:andLayoutWithSpeed:) withObjects: [signal_bottom onMainThreadScheduler], @0.3f];

        RACSignal *signal_layout = [[RACSignal merge:@[ signal_topLinesLayout, signal_middleLinesLayout, signal_bottomLinesLayout ]]
                                               deliverOn: [RACScheduler scheduler]];

        @weakify(self);

        [signal_layout subscribeNext:^(RACFuture *future_layoutFinished) {
            @strongify(self);

            //
            // must check here to make sure `future_layoutFinished` is a `RACFuture` because if
            // any of the three signals passed to this initializer are nil (which is valid),
            // `rac_liftSelector` will return a default signal that yields `RACUnit`s.
            //

            if ([future_layoutFinished isKindOfClass:[RACFuture class]])
            {
                [future_layoutFinished subscribeCompleted:^{
                    @strongify(self);

                    [[RACScheduler scheduler] schedule:^{
                        @strongify(self);
                        [self.internalSubject_didUpdateContents sendNext:self];
                    }];
                }];
            }
        }];
    }
    return self;
}



- (void) setup
{
    [super setup];

    self.internalSubject_didUpdateContents = [RACSubject subject];
}



//- (void) layout
//{
//    [super layout];
//
//    @weakify(self);
//    [[RACScheduler scheduler] schedule:^{
//        @strongify(self);
//
//        [self.internalSubject_didUpdateContents sendNext:self];
//    }];
//}



- (RACSignal *) signal_didUpdateContents
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [self.internalSubject_didUpdateContents subscribe:subscriber];
    }];
}


@end







