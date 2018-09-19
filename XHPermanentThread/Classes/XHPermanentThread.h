//
//  XHPermanentThread.h
//  Runloop_Thread_Package
//
//  Created by John on 2018/8/8.
//  Copyright © 2018年 UKU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHPermanentThread : NSObject
    
/**
 开启线程
 */
- (void)start;

/**
 停止线程
 */
- (void)stop;

/**
 执行Block任务

 @param taskBlock 任务
 */
- (void)doTask:(void(^)(void))taskBlock;
@end
