//
//  CXCountDownLabel.m
//  Demo
//
//  Created by ChrisXu on 13/9/29.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import "CXCountDownLabel.h"

@interface CXCountDownLabel ()
{
    BOOL _ascending;
}

@property (nonatomic, assign) NSInteger currentNumber;
@property (nonatomic, copy) CXCountDownHandler countDownHandeler;

- (void)countDown;

@end

@implementation CXCountDownLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberFormatter = [NSNumberFormatter new];
        _numberFormatter.numberStyle = NSNumberFormatterNoStyle;
        _countInterval = 0;
        self.font = [UIFont systemFontOfSize:20.];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _numberFormatter = [NSNumberFormatter new];
        _numberFormatter.numberStyle = NSNumberFormatterNoStyle;
        _countInterval = 0;
        self.font = [UIFont systemFontOfSize:20.];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setStartNumber:(NSInteger)startNumber endNumber:(NSInteger)endNumber countDownHandeler:(CXCountDownHandler)countDownHandeler
{
    NSParameterAssert(startNumber != endNumber);
    self.startNumber = startNumber;
    self.endNumber = endNumber;
    self.currentNumber = startNumber;
    self.countDownHandeler = countDownHandeler;
    
    self.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:_currentNumber]];
}

#pragma mark - setter / getter
- (void)setStartNumber:(NSInteger)startNumber
{
    self.currentNumber = startNumber;
    if (_startNumber == startNumber) {
        return;
    }
    _startNumber = startNumber;
}

- (void)setEndNumber:(NSInteger)endNumber
{
    if (_endNumber == endNumber) {
        return;
    }
    _endNumber = endNumber;
}

- (void)setCurrentNumber:(NSInteger)currentNumber
{
    if (_currentNumber == currentNumber) {
        return;
    }
    _currentNumber = currentNumber;
}

- (void)setCountInterval:(NSUInteger)countInterval
{
    if (_countInterval == countInterval) {
        return;
    }
    
    _countInterval = countInterval;
}

#pragma mark - PB
- (void)start
{
    if (_currentNumber == _endNumber) {
        if (self.countDownHandeler) {
            self.countDownHandeler(self,_currentNumber,YES);
        }
        return;
    }
    
    if (!_countDownTimer) {
        _countDownTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown)];
        _countDownTimer.frameInterval = 1.;
    }
    
    [_countDownTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)pause
{
    _countDownTimer.paused = YES;
    if (self.countDownHandeler) {
        self.countDownHandeler(self,_currentNumber,YES);
    }
}

- (void)resume
{
    _countDownTimer.paused = NO;
}
#pragma mark - PV
- (void)countDown
{
    _ascending = (_endNumber > _currentNumber);
    NSInteger interval = labs(_currentNumber - _endNumber);
    NSInteger c = 0;
    if (_countInterval > interval) {
        c = interval;
    }
    else {
        c = _countInterval > 0 ? _countInterval : (int)sqrtf(interval);
    }

    self.currentNumber = _ascending ? _currentNumber + c : _currentNumber - c;
    
    self.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:_currentNumber]];
    
    if (self.countDownHandeler) {
        self.countDownHandeler(self,_currentNumber,(_currentNumber == _endNumber));
    }
    
    if (_currentNumber == _endNumber) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
}

@end
