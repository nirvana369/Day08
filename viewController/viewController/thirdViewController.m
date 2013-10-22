//
//  thirdViewController.m
//  viewController
//
//  Created by iOS18 on 10/22/13.
//  Copyright (c) 2013 iOS18. All rights reserved.
//

#import "thirdViewController.h"

@interface thirdViewController ()

@end

@implementation thirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setFrame:CGRectMake(0, 0, 300, 200)];
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.height, self.view.frame.size.width/2)];
    myLabel.text = @"Congratulation !!";
    myLabel.textColor = [UIColor orangeColor];
    myLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:myLabel];
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [myButton setFrame:CGRectMake(self.view.frame.size.height/2-40, self.view.frame.size.width/2+10, 100, 40)];
    myButton.backgroundColor = [UIColor orangeColor];
    [myButton setTitle:@"Back home" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(comeBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
}

-(void)comeBack{
    UIViewAnimationTransition animation = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:animation forView:self.view cache:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
