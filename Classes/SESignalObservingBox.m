//
//  SESignalObservingGridBox.m
//  Stan
//
//  Created by bryn austin bellomy on 1.16.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BrynKit/BrynKit.h>
#import <BrynKit/RACHelpers.h>
#import "SESignalObservingBox.h"

@interface SESignalObservingGridBox ()
    @property (nonatomic, strong, readwrite) RACSignal *observedSignal;
@end


@implementation SESignalObservingGridBox

#pragma mark- Lifecycle
#pragma mark-

+ (instancetype) box
{
    @throw [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"You must call -[SESignalObservingGridBox initWithFrame:observedSignal:], the designated initializer." userInfo:nil];
}

- (instancetype) init
{
    @throw [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"You must call -[SESignalObservingGridBox initWithFrame:observedSignal:], the designated initializer." userInfo:nil];
    return nil;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    @throw [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"You must call -[SESignalObservingGridBox initWithFrame:observedSignal:], the designated initializer." userInfo:nil];
    return nil;
}

- (instancetype) initWithObservedSignal:(RACSignal *)observedSignal
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        _observedSignal = observedSignal;
        [self commonInit];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
                observedSignal:(RACSignal *)observedSignal
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _observedSignal = observedSignal;
        [self commonInit];
    }
    return self;
}

- (void) commonInit
{
    self.contentLayoutMode = MGLayoutGridStyle;

    @weakify(self);

    //
    // regenerate the box's contents any time generateContentsBlock changes
    //

    yssert_notNilAndIsClass(self.observedSignal, RACSignal);

    RACSignal *signal_observedSignalInternalSubscription = [[self.observedSignal
                                                                 assertIsKindOfClass:[NSOrderedSet class]]
                                                                 onMainThreadScheduler];

    [self rac_liftSelector: @selector(updateContainedBoxes:)
               withObjects: signal_observedSignalInternalSubscription];
}



#pragma mark- Other stuff
#pragma mark-

- (void) updateContainedBoxes:(NSOrderedSet *)boxes
{
    yssert_onMainThread();

    [self.boxes removeAllObjects];
    [self layout];

    [self.boxes addObjectsFromArray: boxes.array];

    [self layout];
}


@end




