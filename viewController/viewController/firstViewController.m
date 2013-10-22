//
//  firstViewController.m
//  viewController
//
//  Created by iOS18 on 10/22/13.
//  Copyright (c) 2013 iOS18. All rights reserved.
//

#import "firstViewController.h"
#import "secondViewController.h"

@interface firstViewController ()

@end

@implementation firstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setBgImg{
    UIImage *img = [UIImage imageNamed:@"abtract.jpg"];
    UIImage *bgImg = [img scaleToSize:CGSizeMake(self.view.frame.size.height, self.view.frame.size.width)];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImg];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setBgImg];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goSecond:(id)sender {
    secondViewController *second = [[secondViewController alloc] initWithNibName:@"secondViewController" bundle:nil];
    
    UIViewAnimationTransition animation = 	UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationTransition:animation forView:self.view cache: YES];
    [self presentViewController:second animated:NO completion:nil];
    [UIView commitAnimations];
}

@end
