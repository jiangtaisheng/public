//
//  ShopModel.h
//  pubuliu（瀑布流）
//
//  Created by apple2015 on 16/3/16.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ShopModel : NSObject
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;

@end
