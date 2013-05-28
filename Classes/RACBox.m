//
//  RACBox.m
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
#import "RACBox.h"

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
        RACSignal *signal_layout =
            [self rac_liftSelector: @selector(bryn_setBoxes:andLayoutWithSpeed:)
                       withObjects: [signal_boxes onMainThreadScheduler], @0.3f];

        @weakify(self);

        signal_layout = [signal_layout deliverOn: [RACScheduler scheduler]];

        [signal_layout subscribeNext:^(RACFuture *future_layoutFinished) {
            @strongify(self);

            [future_layoutFinished subscribeCompleted:^{
                @strongify(self);

                [[RACScheduler scheduler] schedule:^{
                    @strongify(self);
                    [self.internalSubject_didUpdateContents sendNext:self];
                }];
            }];
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
