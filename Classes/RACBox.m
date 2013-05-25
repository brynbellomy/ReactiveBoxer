//
//  RACBox.m
//  Beat Bauce
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BrynKit/BrynKit.h>
#import <BrynKit/MGBoxHelpers.h>
#import "RACBox.h"
#import "SECommon.h"
#import "SEAppDelegate.h"

@interface RACBox ()
    @property (nonatomic, strong, readwrite) RACSubject *internalSubject_didUpdateContents;
@end

@implementation RACBox

+ (instancetype) boxWithBoxesSignal:(RACSignal *)signal_boxes
                               size:(CGSize)size
{
    RACBox *box = [[self alloc] initWithBoxesSignal:signal_boxes size:size];
    yssert_notNilAndIsClass(box, RACBox);
    return box;
}



- (instancetype) initWithBoxesSignal: (RACSignal *)signal_boxes
                                size: (CGSize)size
{
    self = [super initWithFrame: CGRectMake(0, 0, size.width, size.height) ];
    if (self)
    {
        [self rac_liftSelector: @selector(bryn_setBoxes:andLayoutWithSpeed:)
                   withObjects: [signal_boxes onMainThreadScheduler], @0.3f];
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
