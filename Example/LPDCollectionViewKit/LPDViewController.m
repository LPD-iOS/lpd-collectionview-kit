//
//  LPDViewController.m
//  LPDCollectionViewKit
//
//  Created by foxsofter on 12/04/2016.
//  Copyright (c) 2016 foxsofter. All rights reserved.
//

#import <LPDCollectionViewKit/LPDCollectionViewKit.h>
#import <LPDNetworkingKit/LPDNetworkingKit.h>
#import <LPDAdditionsKit/LPDAdditionsKit.h>
#import <Masonry/Masonry.h>
#import "LPDViewController.h"
#import "LPDPhotoModel.h"
#import "LPDCollectionPhotoCellViewModel.h"
#import "LPDCollectionViewPhotoCell.h"

@interface LPDViewController ()

@property (nonatomic, strong) LPDCollectionView *collectionView;
@property (nonatomic, strong) LPDCollectionViewModel *collectionViewModel;
@property (nonatomic, strong) LPDApiClient *apiClient;

@end

@implementation LPDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
  collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  collectionViewFlowLayout.itemSize = CGSizeMake((UIScreen.width - 30) / 2, (UIScreen.width - 30) / 2);
  collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
  collectionViewFlowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 1);
  collectionViewFlowLayout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 1);
  
  self.collectionView =
  [[LPDCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewFlowLayout];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionViewModel = [[LPDCollectionViewModel alloc] init];
  [self.collectionView bindingTo:self.collectionViewModel];
  [self.view addSubview:self.collectionView];
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(UIEdgeInsetsZero);
  }];

  UIBarButtonItem *addCellBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"ac" style:UIBarButtonItemStylePlain target:self action:@selector(addCell)];
  
  UIBarButtonItem *addCellsBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"acs" style:UIBarButtonItemStylePlain target:self action:@selector(addCells)];
  
  UIBarButtonItem *insertCellBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"ic" style:UIBarButtonItemStylePlain target:self action:@selector(insertCell)];
  
  UIBarButtonItem *insertCellsBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"ics" style:UIBarButtonItemStylePlain target:self action:@selector(insertCells)];
  
  UIBarButtonItem *removeCellBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"rc" style:UIBarButtonItemStylePlain target:self action:@selector(removeCell)];
  
  UIBarButtonItem *removeCellsBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"rcs" style:UIBarButtonItemStylePlain target:self action:@selector(removeCells)];
  
  UIBarButtonItem *replaceCellsBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:@"rpcs" style:UIBarButtonItemStylePlain target:self action:@selector(replaceCells)];
  
  self.navigationController.toolbarHidden = NO;
  [self setToolbarItems:@[addCellBarButtonItem,
                          addCellsBarButtonItem,
                          insertCellBarButtonItem,
                          insertCellsBarButtonItem,
                          removeCellBarButtonItem,
                          removeCellsBarButtonItem,
                          replaceCellsBarButtonItem,]
               animated:YES];

  @weakify(self);
  LPDApiServer *apiSever = [[LPDApiServer alloc]init];
  [apiSever setServerUrl:@"https://jsonplaceholder.typicode.com" forServerType:LPDApiServerTypeAlpha];
  [apiSever setServerType:LPDApiServerTypeAlpha];
  _apiClient = [[LPDApiClient alloc] initWithServer:apiSever];
  [[_apiClient rac_GET:kLPDApiEndpointPhotos parameters:nil] subscribeNext:^(RACTuple *tuple){
    @strongify(self);
    NSMutableArray *datas = [NSMutableArray arrayWithArray:tuple.first];
    [datas removeObjectsInRange:NSMakeRange(200, datas.count - 200)];
    [self reloadCollection:datas];
  } error:^(NSError *error) {
    
  } completed:^{
    
  }];
}

-(void)reloadCollection:(NSArray *)datas {
  if (datas && datas.count > 0) {
    NSMutableArray *cellViewModels = [NSMutableArray array];
    for (LPDPhotoModel *model in datas) {
      LPDCollectionPhotoCellViewModel *cellViewModel = [[LPDCollectionPhotoCellViewModel alloc]initWithViewModel:self.collectionViewModel];
      cellViewModel.model = model;
      [cellViewModels addObject:cellViewModel];
    }
    [self.collectionViewModel replaceSectionWithCellViewModels:cellViewModels];
  }else{
    [self.collectionViewModel removeAllSections];
  }
}

#pragma mark - operations

- (void)addCell {
  LPDPhotoModel *model = [[LPDPhotoModel alloc]init];
  model.albumId = 111;
  model.identifier = 131;
  model.title = @"officia porro iure quia iusto qui ipsa ut modi";
  model.thumbnailUrl = @"http://placehold.it/150/1941e9";
  model.url = @"http://placehold.it/600/24f355";
  
  LPDCollectionPhotoCellViewModel *cellViewModel =
  [[LPDCollectionPhotoCellViewModel alloc] initWithViewModel:self.collectionViewModel];
  cellViewModel.model = model;
  [self.collectionViewModel addCellViewModel:cellViewModel];
}

- (void)addCells {
  NSMutableArray *cellViewModels = [NSMutableArray array];
  for (NSInteger i = 0; i < 3; i++) {
    LPDPhotoModel *model = [[LPDPhotoModel alloc]init];
    model.albumId = 111111;
    model.identifier = 1003131;
    model.title = @"officia porro iure quia iusto qui ipsa ut modi";
    model.thumbnailUrl = @"http://placehold.it/150/1941e9";
    model.url = @"http://placehold.it/600/24f355";
    
    LPDCollectionPhotoCellViewModel *cellViewModel =
    [[LPDCollectionPhotoCellViewModel alloc] initWithViewModel:self.collectionViewModel];
    cellViewModel.model = model;
    [cellViewModels addObject:cellViewModel];
  }
  [self.collectionViewModel addCellViewModels:cellViewModels];
}

- (void)insertCell {
  LPDPhotoModel *model = [[LPDPhotoModel alloc]init];
  model.albumId = 111;
  model.identifier = 131;
  model.title = @"officia porro iure quia iusto qui ipsa ut modi";
  model.thumbnailUrl = @"http://placehold.it/150/1941e9";
  model.url = @"http://placehold.it/600/24f355";
  
  LPDCollectionPhotoCellViewModel *cellViewModel =
  [[LPDCollectionPhotoCellViewModel alloc] initWithViewModel:self.collectionViewModel];
  cellViewModel.model = model;
  [self.collectionViewModel insertCellViewModel:cellViewModel atIndex:0];
}

- (void)insertCells {
  NSMutableArray *cellViewModels = [NSMutableArray array];
  for (NSInteger i = 0; i < 3; i++) {
    LPDPhotoModel *model = [[LPDPhotoModel alloc]init];
    model.albumId = 111111;
    model.identifier = 1003131;
    model.title = @"officia porro iure quia iusto qui ipsa ut modi";
    model.thumbnailUrl = @"http://placehold.it/150/1941e9";
    model.url = @"http://placehold.it/600/24f355";
    
    LPDCollectionPhotoCellViewModel *cellViewModel =
    [[LPDCollectionPhotoCellViewModel alloc] initWithViewModel:self.collectionViewModel];
    cellViewModel.model = model;
    [cellViewModels addObject:cellViewModel];
  }
  [self.collectionViewModel insertCellViewModels:cellViewModels atIndex:0];
}

- (void)removeCell {
  [self.collectionViewModel removeLastCellViewModel];
}

- (void)removeCells {
  [self.collectionViewModel removeSectionAtIndex:0];
}

- (void)replaceCells {
//  LPDTableValue2CellViewModel *cellViewModel1 =
//  [[LPDTableValue2CellViewModel alloc] initWithViewModel:self.tableViewModel];
//  cellViewModel1.text = @"芬兰无法";
//  cellViewModel1.detail = @"蜂王浆发了";
//  LPDTableValue2CellViewModel *cellViewModel2 =
//  [[LPDTableValue2CellViewModel alloc] initWithViewModel:self.tableViewModel];
//  cellViewModel2.text = @"分为两份绝望";
//  cellViewModel2.detail = @"分为来访将为浪费金额未来房价未来房价来我房间来我房间额外福利晚饭";
//  [self.tableViewModel replaceCellViewModels:@[ cellViewModel1, cellViewModel2 ] fromIndex:0 withRowAnimation:UITableViewRowAnimationLeft];
}



@end
