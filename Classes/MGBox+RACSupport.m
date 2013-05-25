//
//  MGBox+RACSupport.m
//  ReactiveBoxer
//
//  Created by bryn austin bellomy on 5.24.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//
//
//#import "MGBox+RACSupport.h"
//
//#import <MGBox2/MGBox.h>
//#import <MGBox2/MGLine.h>
//#import <FontasticIcons/FontasticIcons.h>
//#import <BrynKit/BrynKit.h>
//#import <BrynKit/MGBoxHelpers.h>
//#import <BrynKit/RACHelpers.h>
//#import <BrynKit/RACFuture.h>
//#import <BlocksKit/NSObject+AssociatedObjects.h>
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import <ReactiveCocoa/NSObject+RACPropertySubscribing.h>
//
//static char SEKey_ExternalLayoutSignal;
//
//
//@interface MGLine (RACSupport)
//    @property (nonatomic, strong, readwrite) RACSignal *signal_didUpdateContents;
//@end
//
//#pragma mark- MGBox (RACSupport)
//#pragma mark-
//
//@implementation MGBox (RACSupport)
//
//+ (instancetype) rac_box
//{
//    MGBox *box = [self box];
//    RACSignal *signal_layoutSelectorWasCalledWithSpeed = [[[box rac_signalForSelector:@selector(rac_layoutWithSpeed:)]
//                                                                setNameWithFormat:@"signal_layoutSelectorWasCalledWithSpeed"]
//                                                                lllogAll];
//
//    [box rac_liftSelector: @selector(rac_layoutWithSpeed:sender:)
//              withObjects: [signal_layoutSelectorWasCalledWithSpeed onMainThreadScheduler], nil];
//
//    return box;
//}





//- (void) rac_layoutWithSpeed:(NSTimeInterval)speed
//                      sender:(id)sender
//{
//    NSLog(@"calling rac_layoutWithSpeed:sender:");
//    yssert_onMainThread();
//
//    [self layoutWithSpeed:speed completion:nil];
//}



//- (RACSignal *) signal_didUpdateContents
//{
//    return [self associatedValueForKey:&SEKey_ExternalLayoutSignal];
//}
//
//
//
//- (void) setSignal_didUpdateContents:(RACSignal *)signal_didUpdateContents
//{
//    [self associateValue:signal_didUpdateContents
//                 withKey:&SEKey_ExternalLayoutSignal];
//}
//
//@end
//
//
//#pragma mark- MGLine (RACSupport)
//#pragma mark-
//
//@implementation MGLine (RACSupport)
//
//+ (instancetype) rac_lineWithLeftSignal:(RACSignal *)signal_left
//                            rightSignal:(RACSignal *)signal_right
//                               size:(CGSize)size
//{
//    MGLine *line = [self lineWithLeft:nil right:nil size:size];
//    yssert_notNilAndIsClass(line, MGLine);
//
//    line.widenAsNeeded = YES;
//    line.font          = [UIFont boldSystemFontOfSize: 14.0f];
//    line.textColor     = [UIColor darkTextColor];
//
//    RACSignal *signal_layoutSelector_left  = [line rac_liftSelector:@selector(bryn_setLeftItems:andLayoutWithSpeed:)  withObjects: signal_left.onMainThreadScheduler, @0.3f];
//    RACSignal *signal_layoutSelector_right = [line rac_liftSelector:@selector(bryn_setRightItems:andLayoutWithSpeed:) withObjects: signal_right.onMainThreadScheduler, @0.3f];
//
//    RACSignal *signal_layoutSelector      = [[RACSignal combineLatest: @[ signal_layoutSelector_left, signal_layoutSelector_right, ]]
//                                                        mapReplace: line];
//
//    line.signal_didUpdateContents = signal_layoutSelector;
//
//    return line;
//}
//
//
//
//+ (instancetype) rac_settingsDescriptionBoxWithTextSignal:(RACSignal *)signal_text
//{
//    MGLineStyled *box_description = [MGLineStyled lineWithMultilineLeft: nil
//                                                                  right: nil
//                                                                  width: kMGBoxRowSize.width
//                                                              minHeight: kMGBoxRowSize.height];
//
//    box_description.borderStyle = MGBorderNone;
//    box_description.padding     = UIEdgeInsetsMake(kIAPDescriptionBoxPadding, kIAPDescriptionBoxPadding, kIAPDescriptionBoxPadding, kIAPDescriptionBoxPadding);
//    box_description.font        = kIAPDescriptionFont;
//
//    RACSignal *signal_layoutSelector =
//    [box_description rac_liftSelector: @selector(bryn_setMultilineLeft:andLayoutWithSpeed:)
//                          withObjects: [signal_text deliverOn: [RACScheduler mainThreadScheduler]], @0.3f];
//
//    box_description.signal_didUpdateContents = [signal_layoutSelector
//                                                mapReplace:box_description];
//
//    return box_description;
//}



//+ (instancetype) rac_settingsPurchaseButtonBoxWithProduct: (YInAppProduct *)product
//                                             enabledSignal: (RACSignal *)signal_enabled
//{
//    MGLineStyled *box_buyButton = [MGLineStyled lineWithLeft:nil right:nil size:kMGBoxRowSize];
//    box_buyButton.borderStyle = MGBorderNone;
//    box_buyButton.font        = [UIFont fontWithName:kFontName_NudistaBoldItalic size:15.0f];
//    box_buyButton.textColor   = [UIColor rac_redLikeBlood];
//
//    RACSignal *signal_productPrice = [product rac_signalWithStartingValueForKeyPath: @keypath(product, price)
//                                                                           observer: box_buyButton];
//
//    RACSignal *signal_buttonText =
//    [[RACSignal combineLatest: @[ signal_enabled, signal_productPrice, ]
//                       reduce:^NSString *(NSNumber *numEnabled, NSString *price) {
//
//                           BOOL buttonEnabled = numEnabled.boolValue;
//                           return (buttonEnabled == YES
//                                   ? $str(@"$$ BUY (%@)", product.price)
//                                   : @"PURCHASED");
//                       }]
//     deliverOn: [RACScheduler mainThreadScheduler]];
//
//    RACSignal *signal_layoutSelector =
//    [box_buyButton rac_liftSelector: @selector(bryn_setRightItems:andLayoutWithSpeed:)
//                        withObjects: signal_buttonText, @0.3f];
//
//    [box_buyButton rac_liftSelector: @selector(setTappable:)
//                        withObjects: [signal_enabled deliverOn: [RACScheduler mainThreadScheduler]], @0.3f];
//
//    box_buyButton.signal_didUpdateContents = [signal_layoutSelector mapReplace:box_buyButton];
//
//    return box_buyButton;
//}
//
//
//@end









