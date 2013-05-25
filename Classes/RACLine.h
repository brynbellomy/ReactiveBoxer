//
//  RACLine.h
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MGBox2/MGLine.h>
#import <BrynKit/MGBoxHelpers.h>

@interface RACLine : MGLine

+ (instancetype) lineWithLeftSignal:(RACSignal *)signal_left rightSignal:(RACSignal *)signal_right size:(CGSize)size;
- (instancetype) initWithLeftSignal:(RACSignal *)signal_left rightSignal:(RACSignal *)signal_right size:(CGSize)size;

@property (nonatomic, strong, readonly) RACSignal *signal_didUpdateContents;

@end
