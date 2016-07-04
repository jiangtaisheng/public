//
//  ViewController.m
//  pubuliu（瀑布流）
//
//  Created by apple2015 on 16/3/16.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "ViewController.h"
#import "ShopModel.h"
#import "ShoppingCell.h"
#import "MJExtension.h"
#import "WaterViewLayout.h"
#import "MJRefresh.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterViewLayoutDelegate>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * dataSource;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    NSArray * shopArr=[ShopModel objectArrayWithFilename:@"1.plist"];
    self.dataSource=[NSMutableArray  arrayWithArray:shopArr];
    
    WaterViewLayout * layout=[[WaterViewLayout alloc]init];
    layout.delegate=self;
    self.collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShoppingCell" bundle:nil] forCellWithReuseIdentifier:@"ID"];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;

    [self.view addSubview:self.collectionView];

    [self.collectionView addFooterWithTarget:self action:@selector(loadData)];
}

-(void)loadData
{
  
    NSArray * shopArr=[ShopModel objectArrayWithFilename:@"1.plist"];

    [self.dataSource addObjectsFromArray:shopArr];
    
    [self.collectionView reloadData];
    [self.collectionView footerEndRefreshing];
}



-(NSMutableArray *)dataSource
{
    
    if (_dataSource==nil) {
        
        
        
        _dataSource=[NSMutableArray array ];
        
    }
    return _dataSource;
    
    
}


//-(UICollectionView*)collectionView
//{
//    
//    if (_collectionView==nil) {
//        
//        WaterViewLayout * layout=[[WaterViewLayout alloc]init];
//        
//        _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
//        [_collectionView registerNib:[UINib nibWithNibName:@"ShoppingCell" bundle:nil] forCellWithReuseIdentifier:@"ID"];
//        
//        _collectionView.dataSource=self;
//        _collectionView.delegate=self;
//    }
//    
//    return _collectionView;
//    
//}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    ShopModel * model=self.dataSource[indexPath.row];
    
    cell.model=model;
    
    return cell;
    
}

-(CGFloat)ForwaterViewLayout:(WaterViewLayout *)water heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{

    ShopModel * model =self.dataSource[indexPath.row];
    CGFloat height=model.h/model.w *width;
    return height;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
