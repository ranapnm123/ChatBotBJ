//
//  Utility.h
//  ChatBot
//
//  Created by PULP on 24/07/18.
//  Copyright © 2018 Ashish Kr Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Utility : NSObject
+(NSData *)getFileInDocDir:(NSString *)strUrl;
+(void)saveFile:(NSString *)strUrl;
+(UIWindow *)getWindow;
+(NSBundle *)getBundleForChatBotPro;
@end

NS_ASSUME_NONNULL_END
