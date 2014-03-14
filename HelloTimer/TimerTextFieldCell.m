//
//  TimerTextFieldCell.m
//  HelloTimer
//
//  Created by Bear on 2014/3/8.
//  Copyright (c) 2014年 TakoBear. All rights reserved.
//

#import "TimerTextFieldCell.h"

@implementation TimerTextFieldCell

/*
 * 由於此物件並非是從撰寫程式碼建立
 * 在 xib 建立的物件會呼叫 initWithCoder: 方法初始化
 * 所以覆寫此方法，在 TimerTextFieldCell 初始化的時候設定 NSDateFormatter
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 建立 NSDateFormatter 物件
        [formatter setDateFormat:@"mm:ss"];                          // 設定字串顯示格式
        [self setFormatter:formatter];                               // 設定 Formatter
    }
    return self;
}

@end
