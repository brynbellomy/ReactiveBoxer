//
//  SESignalObservingTableBoxStyled.m
//  Stan
//
//  Created by bryn austin bellomy on 1.15.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BrynKit/BrynKit.h>
#import <BrynKit/MGBoxHelpers.h>
#import <BrynKit/RACHelpers.h>
#import <MGBox2/MGLine.h>

#import "SESignalObservingTableBoxStyled.h"


@interface SESignalObservingTableBoxStyled ()
    @property (nonatomic, strong, readwrite) RACSubject *signal_didUpdateContents;
@end


@implementation SESignalObservingTableBoxStyled

#pragma mark- Lifecycle
#pragma mark-

+ (instancetype) box
{
    @throw [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"You must call -[SESignalObservingTableBox initWithFrame:observedSignal:], the designated initializer." userInfo:nil];
}

- (instancetype) init
{
    @throw [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"You must call -[SESignalObservingTableBox initWithFrame:observedSignal:], the designated initializer." userInfo:nil];
    return nil;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    @throw [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"You must call -[SESignalObservingTableBox initWithFrame:observedSignal:], the designated initializer." userInfo:nil];
    return nil;
}



- (instancetype) initWithStaticHeader:(id)topLines
                       observedSignal:(RACSignal *)observedSignal
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self commonInitWithStaticHeader:topLines observedSignal:observedSignal];
    }
    return self;
}



- (instancetype) initWithObservedSignal:(RACSignal *)observedSignal
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self commonInitWithStaticHeader:nil observedSignal:observedSignal];
    }
    return self;
}



- (void) commonInitWithStaticHeader:(NSObject *)header
                     observedSignal:(RACSignal *)observedSignal
{
    yssert_notNilAndIsClass(observedSignal, RACSignal);

    SEMGBoxFlattenAppearance(self);

    _signal_didUpdateContents = [RACSubject subject];

    if ( [header instanceOf(NSArray)] )
    {
        header = [NSMutableOrderedSet orderedSetWithArray:(NSArray *)header];
    }

    else if ( [header instanceOf(NSMutableOrderedSet)] )
    {
        // no-op ...
    }

    else
    {
        if (header == nil) {
            header = [NSMutableOrderedSet orderedSet];
        }
        else {
            header = [NSMutableOrderedSet orderedSetWithObject: header];
        }
    }

    //
    // show progress spinner while we're waiting for the first real batch of MGLines to come through the obsesrved signal
    //
    {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame = CGRectMake(0, 0, 30.0f, 30.0f);

        MGBox *box_spinner = [MGBox boxWithSize: spinner.frame.size];
        [box_spinner addSubview:spinner];

        MGLine *line_spinner = [MGLine lineWithSize:CGSizeMake(320.0f, 44.0f)];
        line_spinner.middleItems = @[ box_spinner, @"Loading..." ].mutableCopy;

        [[RACScheduler mainThreadScheduler] schedule:^{
            [box_spinner layout];
            [line_spinner layout];
            [spinner startAnimating];
        }];

        [(NSMutableOrderedSet *)header addObject:line_spinner];
    }

    RACSignal *signal_observedSignal = [[[observedSignal
                                              startWith:           header]
                                              assertIsKindOfClass: [NSOrderedSet class]]
                                              onMainThreadScheduler];

    [self rac_liftSelector: @selector(updateContainedBoxes:)
               withObjects: signal_observedSignal];

}



#pragma mark- Other stuff
#pragma mark-

- (void) updateContainedBoxes:(NSOrderedSet *)boxes
{
    yssert_onMainThread();
    yssert_notNilAndIsClass(boxes, NSOrderedSet);

    @synchronized (self)
    {
        [self.topLines removeAllObjects];
        [self.boxes    removeAllObjects];

        [self layout];

        [self.topLines addObjectsFromArray: boxes.array];
    }

    [self layoutWithSpeed:0.3f completion:nil];

    [self.signal_didUpdateContents sendNext:self];
}



@end








