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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.thread = [[XHPermanentThread alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread excuteBlock:^{
        NSLog(@"111-%@", [NSThread currentThread]);
    }];
}

@end
