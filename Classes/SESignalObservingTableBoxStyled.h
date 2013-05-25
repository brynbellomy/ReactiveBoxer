//
//  YDataObservingTableBoxStyled.h
//  Stan
//
//  Created by bryn austin bellomy on 1.15.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <MGBox2/MGTableBoxStyled.h>
#import <ReactiveCocoa/RACSubscriber.h>

#import "YCommon.h"

@interface YDataObservingTableBoxStyled : MGTableBoxStyled <RACSubscriber>

@property (nonatomic, strong, readonly)  RACSubject *signal_didUpdateContents;

- (instancetype) initWithObservedSignal:(RACSignal *)observedSignal;
- (instancetype) initWithStaticHeader:(NSObject *)topLines observedSignal:(RACSignal *)observedSignal;

@end






