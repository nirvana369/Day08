//
//  sudoku.h
//  sudoku
//
//  Created by MAC on 10/9/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sudoku : NSObject
{
    @public
    int value[10][10];
}

-(NSMutableArray *)getData;
-(NSArray *)getResult:(int *)arr;
@end
