//
//  YDataObservingGridBox.h
//  Stan
//
//  Created by bryn austin bellomy on 1.16.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <MGBox2/MGTableBoxStyled.h>
#import <ReactiveCocoa/RACSubscriber.h>

#import "YCommon.h"

@interface YDataObservingGridBox : MGBox

- (instancetype) initWithObservedSignal:(RACSignal *)observedSignal;
- (instancetype) initWithFrame:(CGRect)frame observedSignal:(RACSignal *)observedSignal;

@end




