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
        if (@available(iOS 10.0, *)) {
            _thread = [[NSThread alloc] initWithBlock:^{
                [weakSelf _keepThreadAlive];
            }];
        } else {
            _thread = [[NSThread alloc] initWithTarget:self selector:@selector(_threadInitialization) object:nil];
        }
    }
    return self;
}

#pragma mark - Public Methods
    
- (void)start {
    [_thread start];
}
    
- (void)stop {
    if (self.thread) {
        [self performSelector:@selector(_stopRunLoop) onThread:_thread withObject:nil waitUntilDone:YES];
    }
}

- (void)doTask:(void(^)(void))taskBlock {
    if (self.thread && taskBlock) {
        [self performSelector:@selector(_task:)
                     onThread:_thread
                   withObject:taskBlock
                waitUntilDone:NO];
    }
}
    
#pragma mark - Private Methods

- (void)_threadInitialization {
    [self _keepThreadAlive];
}

- (void)_keepThreadAlive {
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    while (self && !self.stopped) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)_stopRunLoop {
    self.stop = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)_task:(void(^)(void))task {
    task();
}

@end
