//
//  Utility.m
//  ChatBot
//
//  Created by PULP on 24/07/18.
//  Copyright © 2018 Ashish Kr Singh. All rights reserved.
//

#import "Utility.h"
#import "AppManager.h"

@implementation Utility

+(NSData *)getFileInDocDir:(NSString *)strUrl{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    documentsPath = [documentsPath stringByAppendingString:@"/Images"];
    
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    
    
    NSString *fileName = [Utility getFileNameFromURL:strUrl];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName]; //Add the file name
    
    NSData *dataImage = [NSData dataWithContentsOfFile:filePath];
    
    return dataImage;
}

+(void)saveFile:(NSString *)strUrl{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    documentsPath = [documentsPath stringByAppendingString:@"/Images"];
    
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    
    
    NSString *fileName = [Utility getFileNameFromURL:strUrl];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName]; //Add the file name
    
        NSData *dataImage = [NSData dataWithContentsOfFile:filePath];
    
    // Image not saved in file system. Download and save image in file system
    if (dataImage == nil)
    {
        
        
        NSURL *urlImage = [NSURL URLWithString:strUrl];
        NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
        myQueue.name = @"DownloadQueue";
        myQueue.maxConcurrentOperationCount = 1;
        
        
        
        BOOL imageInQueue = [Utility urlImageInQueueForURLString:strUrl];
        
        if (!imageInQueue)
        {
            
            //Image in download queue
            [[[AppManager sharedManager] mDictImageForURL] setObject:[NSNumber numberWithBool:YES] forKey:strUrl];
            
            
            [myQueue addOperationWithBlock:^{
                
                NSError *error = nil;
                NSData *dataImageDownloaded = [NSData dataWithContentsOfURL:urlImage options:NSDataReadingMappedAlways error:&error];
                
                if (dataImageDownloaded) {
                    
                    
                    
                    @try
                    {
                        //Save Image in file system
                        [dataImageDownloaded writeToFile:filePath atomically:YES];
                        
                        //Set the image
//                        UIImage *image = [UIImage imageWithData:dataImageDownloaded];
//                        [self setImageWithEffect:image];
                        
                        
                        //Image no longer in download queue
                        [[[AppManager sharedManager] mDictImageForURL] setObject:[NSNumber numberWithBool:NO] forKey:strUrl];
//                        [_wcActivityIndicator stopAnimating];
//                        _completed = YES;
                        
                        
                        //Image Downloaded Successfully
//                        [self postNotificationWithString:strUrl];
                        
                    }
                    
                    @catch(NSException *e)
                    {
                        NSLog(@"Exception in saving image to filesystem");
                        //Image no longer in download queue
                        [[[AppManager sharedManager] mDictImageForURL] setObject:[NSNumber numberWithBool:NO] forKey:strUrl];
//                        [_wcActivityIndicator stopAnimating];
//                        _completed = YES;
                        
                    }
                    //                        });
                    //                    }
                }
                
                
                //Handle failure
                else
                {
                    //Image no longer in download queue
                    [[[AppManager sharedManager] mDictImageForURL] setObject:[NSNumber numberWithBool:NO] forKey:strUrl];
//                    [_wcActivityIndicator stopAnimating];
//                    _completed = YES;
                    
                }
            }];
        }
        
        else
        {
            
            NSLog(@"In Queue");
            
            @try
            {
                //Add Observer to listen for notification when the image has downloaded successfully
                
            }
            @catch(NSException *e)
            {
                NSLog(@"Exception while adding observer");
            }
            
            
        }
        
    }
    else
    {
        //Set the image
//        UIImage *image = [UIImage imageWithData:dataImage];
//        [self setImageWithEffect:image];
        //Image no longer in download queue
        [[[AppManager sharedManager] mDictImageForURL] setObject:[NSNumber numberWithBool:NO] forKey:strUrl];
//        [_wcActivityIndicator stopAnimating];
//        _completed = YES;
        
    }
}

+(BOOL)urlImageInQueueForURLString:(NSString*)strURL{
    BOOL bVal = [[[AppManager sharedManager] mDictImageForURL] valueForKey:strURL];
    return bVal;
}

+(NSString*)getFileNameFromURL :(NSString*) URL
{
    NSString* fileName=nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9_]+" options:0 error:nil];
    //Check if URL is empty string
    if(!URL.length){
        return @"";
    }
    else
    {
        NSString *extension = [self getExtensionOfFileInUrl:URL];
        fileName = [regex stringByReplacingMatchesInString:URL options:0 range:NSMakeRange(0, URL.length) withTemplate:@"_"];
        fileName = [fileName stringByAppendingString:@"."];
        fileName = [fileName stringByAppendingString:extension];
        
    }
    
    return fileName;
}

+ (NSString *)getExtensionOfFileInUrl:(NSString *)urlString
{
    NSString *fileExtension;
    
    if(urlString!=nil&&![urlString isEqualToString:@""])
    {
        NSArray *componentsArray = [urlString componentsSeparatedByString:@"."];
        fileExtension = [componentsArray lastObject];
    }
    
    return  fileExtension;
}

+(UIWindow *)getWindow{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    return window;
}

+(NSBundle *)getBundleForChatBotPro{
    NSBundle *bundle = [NSBundle bundleForClass:ViewController.classForCoder];
    NSURL *bundleURL = [[bundle resourceURL] URLByAppendingPathComponent:@"ChatBotPro.bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    return resourceBundle;
}
@end
