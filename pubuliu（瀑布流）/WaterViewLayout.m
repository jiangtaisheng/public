//
//  WaterViewLayout.m
//  pubuliu（瀑布流）
//
//  Created by apple2015 on 16/3/16.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "WaterViewLayout.h"
@interface WaterViewLayout ()
@property (strong,nonatomic ) NSMutableArray *attrrs;

@property(nonatomic,strong)NSMutableDictionary * HeihtDic;


@end

@implementation WaterViewLayout

-(instancetype)init
{
    if (self==[super init]) {
    
        _rowMargin=10;
        _columnMargin=10;
        _columnsCount=3;
        _sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
        
        
    }


    return self;
    
}

-(NSMutableDictionary *)HeihtDic
{

    if (_HeihtDic==nil) {
        
        _HeihtDic=[NSMutableDictionary dictionary];

        
    }

    return _HeihtDic;
}



-(NSMutableArray *)attrrs
{

    if (!_attrrs) {
        _attrrs=[NSMutableArray array];
    }

    return _attrrs;
}

//准备工作
-(void)prepareLayout
{
    [super prepareLayout];
    for (int i=0; i<self.columnsCount; i++) {
        NSString * key=[NSString stringWithFormat:@"%d",i];
        self.HeihtDic[key]=@(self.sectionInset.top);
    }
    
     [self.attrrs removeAllObjects];
    
    NSInteger count=[self.collectionView numberOfItemsInSection:0 ];
   
    for (int i=0; i<count; i++) {
        
        UICollectionViewLayoutAttributes * attrs=[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [self.attrrs addObject:attrs];
    }
    


}
//移动就回重新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
 
    return YES;

}

//UIcollectionView 的 contentSize
-(CGSize)collectionViewContentSize
{



    __block NSString *maxColumn = @"0";
    [self.HeihtDic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.HeihtDic[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.HeihtDic[maxColumn] floatValue] + self.sectionInset.bottom);

    
}

//每个  Item 的 UICollectionViewLayoutAttributes
-(UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    __block  NSString *  minColumn=@"0";
    
    [self.HeihtDic enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSNumber* obj, BOOL * _Nonnull stop) {
        
        if ([obj floatValue]<[self.HeihtDic[minColumn]floatValue]) {
            
            minColumn=key;
        }
        
        
    }];
    
   
    
    CGFloat Width=(self.collectionView.frame.size.width-self.sectionInset.left-self.sectionInset.right-(self.columnsCount-1)*self.columnMargin)/self.columnsCount;
    CGFloat hight=[self.delegate ForwaterViewLayout:self heightForWidth:Width atIndexPath:indexPath];
    NSLog(@"----%f",hight);
    CGFloat x=self.sectionInset.left+[minColumn intValue]*(Width+self.columnMargin);
    CGFloat y=[self.HeihtDic[minColumn] floatValue]+self.rowMargin;
    
    self.HeihtDic[minColumn]=@(y+hight);
    
    NSLog(@"%f",y);
    UICollectionViewLayoutAttributes *attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    attrs.frame=CGRectMake(x, y, Width, hight);

    return attrs;
    
    
    
    
    
    
    
    
}

//返回所有item 的 UICollectionViewLayoutAttributes
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
  

   
    return self.attrrs;
   
}
@end
