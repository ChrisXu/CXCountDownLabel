//
//  CXCountDownLabel.h
//  Demo
//
//  Created by ChrisXu on 13/9/29.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class CXCountDownLabel;

typedef void (^CXCountDownHandler)(CXCountDownLabel *label, NSInteger currentNumber, BOOL stopped);

@interface CXCountDownLabel : UILabel

@property (nonatomic, assign) NSInteger startNumber;
@property (nonatomic, assign) NSInteger endNumber;
@property (nonatomic, strong, readonly) CADisplayLink *countDownTimer;
@property (nonatomic, assign) NSUInteger countInterval; // default is 0. when it is 0, use sqrtf(endNumber - startNumber) which is faster.
- (void)setStartNumber:(NSInteger)startNumber endNumber:(NSInteger)endNumber countDownHandeler:(CXCountDownHandler)countDownHandeler;

- (void)start;
- (void)pause;
- (void)resume;

@end
