//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"
#import "HTTPService.h"
@implementation CakeCell

-(void)updateUI:( Cake*)cake {
  [[HTTPService instance]getImageForCellWith:[NSURL URLWithString:cake.image] :^(UIImage * _Nullable image) {
    dispatch_async(dispatch_get_main_queue(), ^{
      self.cakeImageView.image = image;
      self.titleLabel.text = cake.title;
      self.descriptionLabel.text  = cake.desc;
    });
  }];
}
@end

