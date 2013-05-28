//
//  MGBox+RACSupport.h
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <MGBox2/MGBox.h>

@class RACSignal, RACFuture;

@interface MGBox (RACSupport)

- (RACSignal *) rac_onTap;
- (RACFuture *) bryn_setBoxes:(NSMutableOrderedSet *)boxes andLayoutWithSpeed:(NSTimeInterval)speed;

@end
