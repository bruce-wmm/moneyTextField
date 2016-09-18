//
//  moneyTextField.m
//  TableViewDemo
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 Taoart. All rights reserved.
//

#import "moneyTextField.h"
#import "comm.h"
#define NumbersWithDot      @"0123456789.\n"
#define  NumbersWithoutDot         @"0123456789\n"
@implementation moneyTextField


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.keyboardType = UIKeyboardTypeDecimalPad;
        
        [self addRules];
        self.delegate = self;
    }

    return self;

}

- (void)addRules {

    [self addTarget:self action:@selector(checkInput:) forControlEvents:UIControlEventEditingChanged];

}



/****** 第二种写法 ******/

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //输入字符限制
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithDot]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (filtered.length == 0) {
        //支持删除键
        return [string isEqualToString:@""];
    }
    if (textField.text.length == 0) {
        return ![string isEqualToString:@"."];
    }
    //第一位为0，只能输入.
    else if (textField.text.length == 1){
        if ([textField.text isEqualToString:@"0"]) {
            return [string isEqualToString:@"."];
        }
    }
    else{//只能输入一个.
        if ([textField.text rangeOfString:@"."].length) {
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            //两位小数
            NSArray *ary =  [textField.text componentsSeparatedByString:@"."];
            if (ary.count == 2) {
                if ([ary[1] length] == 2) {
                    return NO;
                }
            }
        }
    }
    return YES;
}


- (void)checkInput:(UITextField *)textField {
    if (textField.text.length > 9) {
        textField.text = [textField.text substringToIndex:9];
    }
    
    if ([textField.text floatValue] > 99999999) {
        textField.text = [textField.text substringToIndex:9];
        
    }
    
    

}





@end
