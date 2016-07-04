//
//  ShoppingCell.m
//  pubuliu（瀑布流）
//
//  Created by apple2015 on 16/3/16.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "ShoppingCell.h"
#import "UIImageView+WebCache.h"
#import "ShopModel.h"
@interface ShoppingCell ()
@property (strong, nonatomic) IBOutlet UIImageView *shopImage;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end


@implementation ShoppingCell

- (void)awakeFromNib {
    

//     [self.contentView bringSubviewToFront:self.priceLabel];
    
}

-(void)setModel:(ShopModel *)model
{

    _model = model;
    
    // 1.图片
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.priceLabel.text = model.price;

}

@end
