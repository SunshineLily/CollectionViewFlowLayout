//
//  FirstViewController.m
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/25.
//

#import "FirstViewController.h"
#import "FirstWaterFlowLayout.h"
#import "FirstCollectionCell.h"
#import "FirstWaterViewModel.h"
#import "FirstWaterModel.h"
#import "FirstOtherWaterFlowLayout.h"
#import <Masonry.h>

@interface FirstViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FirstWaterViewModel *viewModel;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    self.title = @"瀑布";
    self.view.backgroundColor = [UIColor redColor];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.viewModel configData:^{
            [self.collectionView reloadData];
        }];
    });

    NSLog(@"111111");
//    [self.viewModel configData:^{
//        [self.collectionView reloadData];
//    }];
}

- (void)setUpUI {
    FirstWaterFlowLayout *layout = [[FirstWaterFlowLayout alloc] init];
//    FirstOtherWaterFlowLayout *layout = [[FirstOtherWaterFlowLayout alloc] init];

//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstCollectionCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([FirstCollectionCell class])];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FirstCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FirstCollectionCell class]) forIndexPath:indexPath];
    cell.model = [self.viewModel modelOfRow:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  [self.viewModel numberOfItemsInSection:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    FirstWaterModel *model = [self.viewModel modelOfRow:indexPath];
    
    NSLog(@"width ----%lf",model.textSize.width);
    return model.textSize;
}

- (FirstWaterViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FirstWaterViewModel alloc] init];
    }
    return _viewModel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
