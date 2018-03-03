//
//  HTTPService.m
//  Cake List
//
//  Created by Diego Caridei on 27/02/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "HTTPService.h"
#import "UIImage+ResizeImage.h"

#define URL_BASE "https://gist.githubusercontent.com"
#define URL_CAKES "/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"

@implementation HTTPService

+(id) instance {
  static HTTPService *sharedInstance = nil;
  @synchronized(self) {
    if(sharedInstance == nil) {
      sharedInstance = [[self alloc] init];
    }
  }
  return  sharedInstance;
}

-(void) getImageForCellWith:(NSURL*)url :(nullable onCompleteHandlerImage)completionHandler {
  dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      if (data) {
        UIImage *image = [UIImage imageWithData:data];
        CGSize size = CGSizeMake(60, 60);
        completionHandler([image imageConvertToSize:size]);
      }
    }]resume];
  });
}

-(void) getCakes :(nullable onComplete)completionHandler{
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s",URL_BASE,URL_CAKES]];
  NSURLSession *session = [NSURLSession sharedSession];
  [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if(data != nil) {
      NSError *err;
      NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
      if (err == nil) {
        completionHandler(json,nil);
      }
      else {
        completionHandler(nil,@"Data is corrupt");
      }
    }
    else {
      NSLog(@"Error %@", error.debugDescription);
      completionHandler(nil,@"Problem connectiong to the server");
      
    }
  }]resume];
}

@end
