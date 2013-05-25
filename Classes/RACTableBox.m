//
//  RACTableBox.m
//  Beat Bauce
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BrynKit/BrynKit.h>
#import <BrynKit/RACHelpers.h>
#import "RACTableBox.h"
#import "SECommon.h"
#import "SEAppDelegate.h"


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
        [self rac_liftSelector:@selector(bryn_setTopLines:andLayoutWithSpeed:)    withObjects: [signal_top    onMainThreadScheduler], @0.3f];
        [self rac_liftSelector:@selector(bryn_setMiddleLines:andLayoutWithSpeed:) withObjects: [signal_middle onMainThreadScheduler], @0.3f];
        [self rac_liftSelector:@selector(bryn_setBottomLines:andLayoutWithSpeed:) withObjects: [signal_bottom onMainThreadScheduler], @0.3f];
    }
    return self;
}



- (void) setup
{
    lllog(Error, @"calling -setup [self = %@]", self);
    [super setup];

    self.internalSubject_didUpdateContents = [RACSubject subject];
}



- (void) layout
{
    lllog(Error, @"calling -layout [self = %@]", self);

    [super layout];

    @weakify(self);
    [[RACScheduler scheduler] schedule:^{
        @strongify(self);

        [self.internalSubject_didUpdateContents sendNext:self];
        lllog(Error, @"finishing call to -layout (signals updated) [self = %@]", self);
    }];
}



- (RACSignal *) signal_didUpdateContents
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [self.internalSubject_didUpdateContents subscribe:subscriber];
    }];
}


@end







