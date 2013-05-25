//
//  RACTableBox.h
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MGBox2/MGTableBox.h>
#import <BrynKit/MGBoxHelpers.h>

@interface RACTableBox : MGTableBox

+ (instancetype)  boxWithTopLinesSignal:(RACSignal *)signal_top middleLinesSignal:(RACSignal *)signal_middle bottomLinesSignal:(RACSignal *)signal_bottom size:(CGSize)size;
- (instancetype) initWithTopLinesSignal:(RACSignal *)signal_top middleLinesSignal:(RACSignal *)signal_middle bottomLinesSignal:(RACSignal *)signal_bottom size:(CGSize)size;

@property (nonatomic, strong, readonly) RACSignal *signal_didUpdateContents;

@end
