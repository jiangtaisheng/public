//
//  WaterViewLayout.h
//  pubuliu（瀑布流）
//
//  Created by apple2015 on 16/3/16.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterViewLayout;
@protocol WaterViewLayoutDelegate <NSObject>

-(CGFloat)ForwaterViewLayout:(WaterViewLayout *)water heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;



@end


@interface WaterViewLayout : UICollectionViewLayout
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<WaterViewLayoutDelegate> delegate;

@end
