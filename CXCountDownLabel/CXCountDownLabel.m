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
        // Initialization code
    }
    return self;
}

- (id)initWithStartNumber:(NSInteger)startNumber endNumber:(NSInteger)endNumber countDownHandeler:(CXCountDownHandler)countDownHandeler
{
    self = [self init];
    if (self) {
        NSParameterAssert(startNumber != endNumber);
        
        self.startNumber = startNumber;
        self.endNumber = endNumber;
        
        self.countDownHandeler = countDownHandeler;
        
        self.font = [UIFont systemFontOfSize:20.];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return  self;
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
    
    NSInteger interval = abs(_currentNumber - _endNumber);
    NSInteger c = (int)sqrtf(interval);

    self.currentNumber = _ascending ? _currentNumber + c : _currentNumber - c;
    self.text = [NSString stringWithFormat:@"%i",_currentNumber];
    
    if (self.countDownHandeler) {
        self.countDownHandeler(self,_currentNumber,(_currentNumber == _endNumber));
    }
    
    if (_currentNumber == _endNumber) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
}

@end
