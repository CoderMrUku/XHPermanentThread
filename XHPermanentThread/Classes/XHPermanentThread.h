//
//  XHPermanentThread.h
//  Runloop_Thread_Package
//
//  Created by John on 2018/8/8.
//  Copyright © 2018年 UKU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHPermanentThread : NSObject

- (void)excuteBlock:(void(^)(void))tasks;
- (void)stop;

@end
