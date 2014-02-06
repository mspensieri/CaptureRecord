//
//  CRViewController.m
//  CRExample
//
//  Created by Michael Spensieri on 2/6/14.
//  Copyright (c) 2014 Michael Spensieri. All rights reserved.
//

#import "CRViewController.h"
#import "time.h"

static const CGFloat kTimerInterval = 2.0;
@interface CRViewController()

@property UILabel* textLabel;

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 100)];
    self.textLabel.text = @"It Works!";
    [self.textLabel sizeToFit];
    self.textLabel.center = self.view.center;
    
    [self.view addSubview:self.textLabel];
    
   [NSTimer scheduledTimerWithTimeInterval:kTimerInterval target:self selector:@selector(changeColor) userInfo:nil repeats:YES];
    
    srand(time(NULL));
}


-(void)changeColor
{
    self.textLabel.textColor = [UIColor colorWithRed:[self randomFloat] green:[self randomFloat] blue:[self randomFloat] alpha:1.0];
}

-(float)randomFloat
{
    return (float)rand() / (float)RAND_MAX;
}

@end
