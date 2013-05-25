//
//  RACLine.m
//  Beat Bauce
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BrynKit/BrynKit.h>
#import <BrynKit/RACHelpers.h>
#import "RACLine.h"
#import "SECommon.h"
#import "SEAppDelegate.h"


@interface RACLine ()
    @property (nonatomic, strong, readwrite) RACSubject *internalSubject_didUpdateContents;
@end



@implementation RACLine {}

+ (instancetype) lineWithLeftSignal:(RACSignal *)signal_left
                        rightSignal:(RACSignal *)signal_right
                               size:(CGSize)size
{
    RACLine *line = [[self alloc] initWithLeftSignal:signal_left rightSignal:signal_right size:size];
    yssert_notNilAndIsClass(line, RACLine);
    return line;
}



- (instancetype) initWithLeftSignal:(RACSignal *)signal_left
                        rightSignal:(RACSignal *)signal_right
                               size:(CGSize)size
{
    self = [self initWithFrame: CGRectMake(0, 0, size.width, size.height)];
    if (self)
    {
        self.widenAsNeeded = YES;
        self.font          = [UIFont boldSystemFontOfSize: 14.0f];
        self.textColor     = [UIColor darkTextColor];

        [self rac_liftSelector:@selector(bryn_setLeftItems:andLayoutWithSpeed:)  withObjects: [signal_left  onMainThreadScheduler], @0.3f];
        [self rac_liftSelector:@selector(bryn_setRightItems:andLayoutWithSpeed:) withObjects: [signal_right onMainThreadScheduler], @0.3f];
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







