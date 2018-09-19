//
//  XHViewController.m
//  XHPermanentThread
//
//  Created by CoderMrUku on 09/18/2018.
//  Copyright (c) 2018 CoderMrUku. All rights reserved.
//

#import "XHViewController.h"
#import "XHPermanentThread.h"

@interface XHViewController ()
@property(nonatomic, strong) XHPermanentThread *thread;
@end

@implementation XHViewController
    
- (void)dealloc {
    NSLog(@"%s", __func__);
    [self.thread stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.thread = [[XHPermanentThread alloc] init];
    [self.thread start];
}
    
- (IBAction)stop:(id)sender {
    [self.thread stop];
}
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread doTask:^{
        NSLog(@"im tasks-%@", [NSThread currentThread]);
    }];
}

@end
