//
//  secondViewController.m
//  viewController
//
//  Created by iOS18 on 10/22/13.
//  Copyright (c) 2013 iOS18. All rights reserved.
//

#import "secondViewController.h"
#import "sudoku.h"
#import "thirdViewController.h"
#import "UIImage+scale.h"

@interface secondViewController ()
{
    @public
    int _id; // instant variable add button.tag to use
}
@property (nonatomic, strong) sudoku *tmp;
@end

@implementation secondViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setBgImg];
    [self creatView];
}

-(void)creatView{
    
    // add button by coding
    
    // get data
    
    self.tmp = [[sudoku alloc] init];
    NSArray * array = [[NSArray alloc] initWithArray:[self.tmp getData]];
    
    int x = 170,y = 340,space = 5, height = 30,width = 30, buttonPerRow = 9, index = 0;
    
    for (int i=0; i<9; i++) {
        for (int j=0; j<9; j++) {
            
            // creat a button
            UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            // init button
            [myButton setTitle:[NSString stringWithFormat:@"%@",[array objectAtIndex:index]] forState:UIControlStateNormal];
            myButton.backgroundColor = [UIColor blackColor];
            [myButton setFrame:CGRectMake(y, x, width , height)];
            
            [myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [myButton setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
            // add tag for button
            myButton.tag = i * buttonPerRow + j + 1;
            // if it has value - > disable
            
            if ([[array objectAtIndex:index] integerValue] != 0)
                myButton.enabled = NO;
            
            // new y
            y += height;
            y += space;
            // add button to view
            [self.view addSubview:myButton];
            // event for button
            [myButton addTarget:self action:@selector(myButtonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
            index++;
        }
        // new x
        x += height;
        x += space;
        // init y
        y = 340;
    }
    
    x += 20;
    // add 9 button picker value
    for (int i=1; i<10; i++) {
        UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [myButton setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        
        [myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [myButton setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        
        myButton.backgroundColor = [UIColor blackColor];
        [myButton setFrame:CGRectMake(y, x, width, height)];
        myButton.enabled = NO;
        myButton.tag = 100 + i;
        y += height;
        y += space;
        [self.view addSubview:myButton];
        [myButton addTarget:self action:@selector(pickNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    _id = 0;
    x += 50;
    y = self.view.frame.size.width / 2 + 50;
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [myButton setTitle:@"Solve" forState:UIControlStateNormal];
    myButton.backgroundColor = [UIColor blackColor];
    [myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myButton setFrame:CGRectMake(y, x, 100, 40)];
    [self.view addSubview:myButton];
    [myButton addTarget:self action:@selector(solve) forControlEvents:UIControlEventTouchUpInside];
    
    // back to 1st view
    x += 60;
    
    myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [myButton setTitle:@"Back" forState:UIControlStateNormal];
    myButton.backgroundColor = [UIColor blackColor];
    [myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myButton setFrame:CGRectMake(y, x, 100, 40)];
    [self.view addSubview:myButton];
    [myButton addTarget:self action:@selector(comeBack) forControlEvents:UIControlEventTouchUpInside];
}

-(void)comeBack{
    UIViewAnimationTransition animation = UIViewAnimationTransitionCurlDown;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:animation forView:self.view cache:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    [UIView commitAnimations];
}

-(void)pickNumber:(UIButton *)button{
    
    // find button clicked & change value
    for (UIButton * mybutton in self.view.subviews) {
        if ([mybutton isKindOfClass:[UIButton class]] && mybutton.tag == _id) {
            [mybutton setTitle:[NSString stringWithString:button.titleLabel.text] forState:UIControlStateNormal];
            break;
        }
    }
    _id = 0;
    
    for (UIButton * mybutton in self.view.subviews) {
        if ([mybutton isKindOfClass:[UIButton class]] && mybutton.tag > 100) {
            mybutton.enabled = NO;
        }
    }
}

// check number already to use
-(void)checkNumber:(int) pos{
    int arr[10][10];
    BOOL mark[10];
    int row, col;
    
    // get value current array
    for (UIButton * button in self.view.subviews) {
        if ([button isKindOfClass:[UIButton class]] && button.tag < 100) {
            
            col = button.tag % 9;
            if (!col)
            {
                col = 9;
                row = button.tag / 9;
            }
            else
                row = button.tag / 9 + 1;
            arr[row][col] = [button.titleLabel.text intValue];
            //NSLog(@"%d %d",row,col);
        }
    }
    
    // get position when touch up inside button
    col = pos % 9;
    if (!col)
    {
        col = 9;
        row = pos / 9;
    }
    else
        row = pos / 9 + 1;
    
    // reset mark array
    for (int i=0; i < 10; i++)
        mark[i] = 0;
    
    // mark number horizal & vertical
    for (int i = 1; i < 10; i++) {
        mark[arr[row][i]] = 1;
        mark[arr[i][col]] = 1;
    }
    
    
    for (int i=1; i<9; i+=3)
        if (row >= i && row < i + 3) {
            for (int j=1; j<9; j+=3) {
                if (col >= j && col < j+3) {
                    for (int r=i; r<i+3; r++) {
                        for (int c=j; c<j+3; c++) {
                            mark[arr[r][c]] = 1;
                        }
                    }
                    for (UIButton *button in self.view.subviews) {
                        if ([button isKindOfClass:[UIButton class]] && button.tag > 100) {
                            if (!mark[button.tag-100]) {
                                button.enabled = YES;
                            }
                        }
                    }
                    return;
                }
            }
        }
}

-(void)myButtonIsPressed:(UIButton *) button{
    
    for (UIButton * mybutton in self.view.subviews) {
        if ([mybutton isKindOfClass:[UIButton class]] && mybutton.tag > 100) {
            mybutton.enabled = NO;
        }
    }
    
    _id = button.tag;
    [self checkNumber:button.tag];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goThird{
    thirdViewController *thirdView = [[thirdViewController alloc] initWithNibName:@"thirdViewController" bundle:nil];
    
    // log view frame size
    NSLog(@"%2.1f %2.1f",thirdView.view.frame.size.width,thirdView.view.frame.size.height);
    
    UIViewAnimationTransition animation = UIViewAnimationOptionTransitionCurlUp;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:animation forView:self.view cache:YES];
    [self presentViewController:thirdView animated:NO completion:nil];
    [UIView commitAnimations];
}

- (IBAction)solve{
    
    int array[82];
    
    for (UIButton * button in self.view.subviews) {
        if ([button isKindOfClass:[UIButton class]] && button.tag < 100) {
            array[button.tag] = [button.titleLabel.text integerValue];
        }
    }
    
    NSArray *arr = [[NSArray alloc] initWithArray:[self.tmp getResult:array]];
    
    for (UIButton * button in self.view.subviews) {
        if ([button isKindOfClass:[UIButton class]] && button.tag && button.tag < 100) {
            // NSLog(@"%d",button.tag);
            [button setTitle:[NSString stringWithFormat:@"%@",[arr objectAtIndex:button.tag-1]] forState:UIControlStateNormal];
        }
    }
    
    [self performSelector:@selector(goThird) withObject:nil afterDelay:1];
}
@end
