//
//  SESignalObservingGridBox.h
//  Stan
//
//  Created by bryn austin bellomy on 1.16.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <MGBox2/MGTableBoxStyled.h>

@class RACSignal;

@interface SESignalObservingGridBox : MGBox

- (instancetype) initWithObservedSignal:(RACSignal *)observedSignal;
- (instancetype) initWithFrame:(CGRect)frame observedSignal:(RACSignal *)observedSignal;

@end




