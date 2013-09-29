//
//  ViewController.m
//  Demo
//
//  Created by ChrisXu on 13/9/29.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import "ViewController.h"
#import "CXCountDownLabel.h"

@interface ViewController ()

@property (nonatomic, strong) CXCountDownLabel *cdLabel;

- (IBAction)startAction:(id)sender;
- (IBAction)pausedAction:(id)sender;
- (IBAction)resumeAction:(id)sender;
- (IBAction)endValueChangeAction:(UISlider *)slider;

@property (nonatomic, weak) IBOutlet UILabel *endValueLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.cdLabel = [[CXCountDownLabel alloc] initWithStartNumber:0 endNumber:1000 countDownHandeler:^(CXCountDownLabel *label, NSInteger currentNumber, BOOL stopped) {
        if (stopped) {
            NSLog(@"Stopped");
        }
    }];
    
    self.cdLabel.frame = CGRectMake( 0, 0, 320, 50);
    
    [self.view addSubview:self.cdLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAction:(id)sender
{
    [self.cdLabel start];
    self.cdLabel.countDownTimer.frameInterval = 1;
}

- (IBAction)pausedAction:(id)sender
{
    [self.cdLabel pause];
}

- (IBAction)resumeAction:(id)sender
{
    [self.cdLabel resume];
}

- (IBAction)endValueChangeAction:(UISlider *)slider
{
    NSInteger value = (int)slider.value;
    _endValueLabel.text = [NSString stringWithFormat:@"End value:%i",value];
    self.cdLabel.endNumber = value;
}
@end
