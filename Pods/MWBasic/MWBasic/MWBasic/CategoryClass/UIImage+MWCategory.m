//
//  UIImage+MWCategory.m
//  ShopManagerProgect
//
//  Created by mwk_pro on 2017/4/14.
//  Copyright © 2017年 mwk All rights reserved.
//

#import "UIImage+MWCategory.h"
#import "NSDate+MWCategory.h"
#import "NSString+MWCategory.h"

@implementation UIImage (MWCategory)

- (UIImage *)mw_cutInRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    UIImage *image = [self mw_rotation:UIImageOrientationRight];

    CGFloat scale = self.scale;
    CGFloat widthScale = image.size.width / [UIScreen mainScreen].bounds.size.width;
    CGFloat heightScale = image.size.height / [UIScreen mainScreen].bounds.size.height
    ;
    CGFloat x= rect.origin.x*scale * widthScale,
    y=rect.origin.y*scale*heightScale,
    w=rect.size.width*scale*widthScale,
    h=rect.size.height*scale*heightScale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:scale orientation:image.imageOrientation];
    newImage = [newImage mw_rotation:UIImageOrientationLeft];
    return newImage;
}

// 画水印
-(UIImage *)mw_watermarkImage:(UIImage *)img
{
    
    CGFloat value=0.6;
    CGFloat imageWidthValue=0.38;
    CGFloat imageWidth=self.size.width*value*imageWidthValue;
    CGFloat imageHeight=imageWidth*20/114.0;
    
    NSInteger textFontSize=50;
    CGSize textSize;
    NSDate *nowDate=[NSDate date];
    NSString *timeStr=[nowDate mw_stringWithFormat:@"YYYY-MM-dd HH:mm"];
    for (NSInteger i=150; i>0; i--) {
        CGSize size=[timeStr mw_sizeWithmaxSize:CGSizeMake(0, 0) font:[UIFont boldSystemFontOfSize:i]];
        if (ceil(size.height)<=imageHeight+5) {
            textFontSize=i;
            textSize=size;
            break;
        }
    }
    
    CGRect imageDrawInRect=CGRectMake(self.size.width-ceil(textSize.width)+(ceil(textSize.width)-imageWidth)/2.0-20, self.size.height-10-imageHeight, imageWidth, imageHeight);
    CGRect timeDrawInRect=CGRectMake(self.size.width-ceil(textSize.width)-20, self.size.height-10-ceil(textSize.height),ceil(textSize.width), ceil(textSize.height));
    imageDrawInRect.origin.y=self.size.height-20-ceil(textSize.height)-imageHeight;
    NSString* mark = timeStr;
    
    UIGraphicsBeginImageContextWithOptions([self size], NO, self.scale);
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    [img drawInRect:imageDrawInRect];
    
    NSDictionary *attr = @{
                           
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:textFontSize],  //设置字体
                           
                           NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4]   //设置字体颜色
                           
                           };
    
    [mark drawInRect:timeDrawInRect withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return aimg;
    
}

- (UIImage *)mw_rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

- (UIImage *)mw_fixOrientation{
    UIImage *aImage=self;
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to mwke the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
