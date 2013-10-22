//
//  sudoku.m
//  sudoku
//
//  Created by MAC on 10/9/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import "sudoku.h"

struct pos{
    int prow,pcol;
};

@interface sudoku()
{
    @public
    int _result[10][10],_sumCol[10],_sumRow[10],_sumLand[10],_mCol[10][10],_mRow[10][10],_mLand[10][10];
    BOOL _find;
    struct pos _pos[81];
    int _count;
}
@end

@implementation sudoku

-(NSMutableArray *)getData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sudoku" ofType:@"txt"];
    
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:81];
    for (int i=0; i<[data length]; i++) {
        if ([data characterAtIndex:i] != ' ') {
            //if ([data characterAtIndex:i] == 'x')
            //    [array addObject:@0];
            //else
                [array addObject:[NSString stringWithFormat:@"%c",[data characterAtIndex:i]]];
        }
    }
    
    return array;
}

-(int)getLand:(int)row :(int)col{
    int land = 1;
    
    for (int i=1; i<9; i+=3)
            for (int j=1; j<9; j+=3) {
                if (row >= i && row < i+3 && col >= j && col < j+3) {
                    return land;
                }
                land++;
        }
    return 0;
}

-(void)backtracking:(int)level{
    
    int row,col,land;
    
    if (level == _count) {
        _find = YES;
        return;
    }
    row = _pos[level].prow;
    col = _pos[level].pcol;
    land = [self getLand:row :col];
    
    for (int val=1; val <10; val++) {
        if (_mRow[row][val] == 0 && _mCol[col][val] == 0 && _mLand[land][val] == 0) {
            if (_sumCol[col] - val >= 0 && _sumRow[row] - val >= 0 && _sumLand[land] - val >= 0) {
                _mRow[row][val] = 1;
                _mCol[col][val] = 1;
                _mLand[land][val] = 1;
                _sumCol[col] -= val;
                _sumRow[row] -= val;
                _sumLand[land] -= val;
                
                _result[row][col] = val;
                
                [self backtracking:level+1];
                if (_find)
                    return;
                _result[row][col] = 0;
                _mRow[row][val] = 0;
                _mCol[col][val] = 0;
                _mLand[land][val] = 0;
                _sumCol[col] += val;
                _sumRow[row] += val;
                _sumLand[land] += val;
            }
        }
    }
}

-(void)initArray{
    _find = NO;
    
    for (int i=1; i<10; i++) {
        _sumCol[i] = 45;
        _sumRow[i] = 45;
        _sumLand[i] = 45;

        for (int j=1; j<10; j++){
            _mLand[i][j] = 0;
            _mCol[i][j] = 0;
            _mRow[i][j] = 0;
        }
    }
    //
    int land = 1;
    for (int i=1; i<9; i+=3){
            for (int j=1; j<9; j+=3) {
                
                    for (int r=i; r<i+3; r++) {
                        for (int c=j; c<j+3; c++) {
                            _sumRow[r] -= _result[r][c];
                            _sumCol[c] -= _result[r][c];
                            _sumLand[land] -= _result[r][c];
                            _mRow[r][_result[r][c]] = 1; // mark row
                            _mCol[c][_result[r][c]] = 1; // mark col
                            _mLand[land][_result[r][c]] = 1; // mark land
                        }
                    }
                land++;
                
                }
        }

}

-(void)addData:(int *) arr{
    int index = 1;
    _count = 0;
    for (int i = 1; i<10; i++) {
        for (int j = 1; j<10; j++) {
            _result[i][j] = arr[index];
            index++;
            if (!_result[i][j]) {
                // count & save number cell not fill
                _pos[_count].prow = i;
                _pos[_count].pcol = j;
                _count++;
                ////
            }
        }
    }
}

-(NSMutableArray *)getResult:(int *) arr{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:82];
    
    [self addData:arr];
    
    [self initArray];
    
    [self backtracking:0];
    
   // NSLog(@"%d",_find);
    for (int i=0; i < 9; i++) {
        for (int j=1; j<10; j++) {
            [array addObject:[NSString stringWithFormat:@"%d",_result[i+1][j]]];
        }
    }
    
    return array;
}
@end
