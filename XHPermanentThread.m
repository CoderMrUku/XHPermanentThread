//
//  XHPermanentThread.m
//  Runloop_Thread_Package
//
//  Created by John on 2018/8/8.
//  Copyright © 2018年 UKU. All rights reserved.
//

#import "XHPermanentThread.h"

@interface XHPermanentThread()
@property(nonatomic, strong) NSThread *thread;
@property(nonatomic, assign, getter=stopped) BOOL stop;
@end

@implementation XHPermanentThread

- (void)dealloc {
    [self stop];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        _thread = [[NSThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.stopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
    }
    return self;
}

#pragma mark - Public Methods

- (void)start {
    [_thread start];
}

- (void)excuteBlock:(void (^)(void))tasks {
    if (self.thread && tasks) {
        [self performSelector:@selector(_task:) onThread:_thread withObject:tasks waitUntilDone:NO];
    }
}

- (void)stop {
    if (self.thread) {
        [self performSelector:@selector(_stopRunLoop) onThread:_thread withObject:nil waitUntilDone:YES];
    }
}

#pragma mark - Private Methods

- (void)_stopRunLoop {
    self.stop = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)_task:(void(^)(void))task {
    task();
}

@end
