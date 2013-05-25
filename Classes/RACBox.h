//
//  RACBox.h
//  Beat Bauce
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MGBox2/MGBox.h>
#import <BrynKit/MGBoxHelpers.h>

@interface RACBox : MGBox

+ (instancetype)  boxWithBoxesSignal:(RACSignal *)signal_boxes size:(CGSize)size;
- (instancetype) initWithBoxesSignal:(RACSignal *)signal_boxes size:(CGSize)size;

@property (nonatomic, strong, readonly) RACSignal *signal_didUpdateContents;

@end





