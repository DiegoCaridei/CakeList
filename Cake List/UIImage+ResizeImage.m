//
//  UIImage+ResizeImage.m
//  Cake List
//
//  Created by Diego Caridei on 03/03/18.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "UIImage+ResizeImage.h"

@implementation UIImage (ResizeImage)
- (UIImage *)imageConvertToSize:(CGSize)size {
  UIGraphicsBeginImageContext(size);
  [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return destImage;
}

@end
