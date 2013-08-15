//
//  ViewController.m
//  Test
//
//  Created by 汤 海波 on 8/13/13.
//  Copyright (c) 2013 汤 海波. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    MyView *view = [[MyView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    [view startAnimate:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
