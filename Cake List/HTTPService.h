//
//  HTTPService.h
//  Cake List
//
//  Created by Diego Caridei on 27/02/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void  (^onComplete)(NSArray*__nullable dataArray, NSString *__nullable errMessage);
typedef void (^onCompleteHandlerImage)(UIImage *__nullable image );
@interface HTTPService : NSObject
+(id _Nullable ) instance;
-(void) getCakes :(nullable onComplete)completionHandler;
-(void) getImageForCellWith:(NSURL*_Nullable)url :(nullable onCompleteHandlerImage)completionHandler;
@end


