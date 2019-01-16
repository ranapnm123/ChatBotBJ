//
//  ViewController.h
//  ChatBot
//
//  Created by Ashish Kr Singh on 13/07/18.
//  Copyright © 2018 Ashish Kr Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import <Vertigo/TGRImageViewController.h>
#import <Vertigo/TGRImageZoomAnimationController.h>
#import "AppManager.h"
@interface ViewController : UIViewController<UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) NSMutableArray *messageList;
@property(nonatomic,retain)UIPopoverPresentationController *dateTimePopover8;

@end

