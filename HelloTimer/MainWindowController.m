//
//  MainWindowController.m
//  HelloTimer
//
//  Created by Bear on 2014/3/7.
//  Copyright (c) 2014年 TakoBear. All rights reserved.
//

#import "MainWindowController.h"

// 內部宣告
// 在這區塊中宣告的特性是不想要給其他類別呼叫使用的
// 可以視為 private
@interface MainWindowController ()

@property (nonatomic, strong) NSDate *startTime;    // 記錄開始時間
@property (weak) NSTimer *timer;                    // 觸發計時器，用於定時更新畫面

@end

@implementation MainWindowController

/*
 * 視窗載入完成後，初始化計時器顯示的數字
 */
- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self initTimer];
}

/*
 * 當程式終止時要記得清除占用的資源
 */
- (void)dealloc
{
    [self stop];
}

#pragma mark MainWindowController

- (void)initTimer
{
    self.startTime = [NSDate date];
    [self update];
}

- (void)start
{
    [self initTimer];
    
    // 每隔一秒呼叫 update 方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1                  // 相隔一秒
                                                  target:self               // mainWindowController
                                                selector:@selector(update)  // 呼叫 update 方法
                                                userInfo:nil                // 不傳入參數
                                                 repeats:YES];              // 重複執行
}

/*
 * 停止計時，要移除觸發計時器
 */
- (void)stop
{
    // 移除觸發計時器時務必要先使用 isValid 方法確認是否可以移除
    // 再呼叫 invalidate 停止繼續觸發
    bool isValid = [self.timer isValid];
    
    if(isValid) {
        [self.timer invalidate];
    }
}

/*
 * 計算時間，並更新顯示時間
 */
- (void)update
{
    // timeIntervalSinceNow 方法會回傳  = (NSDate 物件的時間 - 現在時間)，基本上是負值，所以要再乘上 -1
    // dateWithTimeIntervalSinceReferenceDate 方法則是依傳入時間建立 NSDate 物件
    NSDate *nowTime = [NSDate dateWithTimeIntervalSinceReferenceDate: [self.startTime timeIntervalSinceNow] * -1];
    
    [self.timerTextField setObjectValue:nowTime];   // 改成使用 setObjectValue 方法傳入
}

#pragma mark -


/*
 * 透過 Bevel Button 的 state 判斷目前計時器是否正在計時
 * 呼叫相對應的方法執行
 */
- (IBAction)handleClick:(id)sender
{
    // 播放音效
    [self playSystemSound];
    
    NSButton *btn = sender;
    
    if([btn state] == NSOnState) {
        [self start];
    }
    else {
        [self stop];
    }
}

/*
 * 使用 soundNamed: 方法自動搜尋並播放音效檔
 * 首先會在 APP 的 Main Bundle 中尋找是否有符合名稱的音效檔
 * 如果沒有再從以下路徑尋找：
 * ~/Library/Sounds
 * /Library/Sounds
 * /Network/Library/Sounds
 * /System/Library/Sounds
 * 如果都沒有，則會回傳 nil
 */
- (void) playSystemSound
{
    NSSound *systemSound = [NSSound soundNamed:@"Glass"];
    if(systemSound) {
        [systemSound play];
    }
}

@end

