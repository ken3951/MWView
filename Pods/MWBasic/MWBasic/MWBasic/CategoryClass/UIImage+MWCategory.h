//
//  UIImage+MWCategory.h
//  ShopManagerProgect
//
//  Created by mwk_pro on 2017/4/14.
//  Copyright © 2017年 mwk All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MWCategory)
- (UIImage *)mw_cutInRect:(CGRect)rect;
-(UIImage *)mw_watermarkImage:(UIImage *)img;
- (UIImage *)mw_fixOrientation;
- (UIImage *)mw_rotation:(UIImageOrientation)orientation;
@end
