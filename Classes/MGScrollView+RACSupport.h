//
//  MGScrollView+RACSupport.h
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <MGBox2/MGScrollView.h>

@class RACSignal, RACFuture;

@interface MGScrollView (RACSupport)

- (RACFuture *) bryn_layoutWithSpeed:(NSTimeInterval)speed;

@end
