//
//  FirstWaterFlowLayout.m
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/25.
//

#import "FirstWaterFlowLayout.h"

@interface FirstWaterFlowLayout()
@property (nonatomic, assign) CGRect lastFrame;//上一个item的布局
@property (nonatomic, strong) NSMutableArray *attributesArray;

@end

@implementation FirstWaterFlowLayout
//重写其布局方法
- (void)prepareLayout {
    [super prepareLayout];
    
    NSMutableArray *layoutInfoArr = [NSMutableArray array];
    //获取布局信息
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *subArr = [NSMutableArray arrayWithCapacity:numberOfItems];
        for (NSInteger item = 0; item < numberOfItems; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [subArr addObject:attributes];
        }
        [layoutInfoArr addObject:[subArr copy]];
    }
    
    self.attributesArray = [layoutInfoArr copy];
}

//指出了与指定区域有交接的UICollectionViewLayoutAttributes对象放到一个数组中，然后返回
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layoutAttributesArr = [NSMutableArray array];
    
    [self.attributesArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull array, NSUInteger idx, BOOL * _Nonnull stop) {
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (CGRectIntersectsRect(obj.frame, rect)) { //如果item在rect内
                [layoutAttributesArr addObject:obj];
            }
        }];
    }];
    return layoutAttributesArr;
}

//重写并调用layoutAttributesForItemAtIndexPath方法计算布局
//根据自己的需求，计算每一个item的布局，如果itemSize是动态的，可以配合代理拿到当前indexPath的大小
//这里只自定义了item的布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //拿到系统为我们计算的布局
    UICollectionViewLayoutAttributes *oldAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    //创建一个我们期望的布局
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat itemX = self.sectionInset.left;//默认X值
    CGFloat itemY = oldAttributes.frame.origin.y;//Y值直接用系统算的
    CGSize itemSize = oldAttributes.size; //大小代理直接返回的
    
    //同一行
    BOOL line = oldAttributes.frame.origin.y == self.lastFrame.origin.y;
    
    //无需换行&&indexpath.row != 0调整X值，(indexPath.row = 0)时self.lastFrame还未赋值
    if (oldAttributes.frame.origin.x != itemX && indexPath.row != 0 && line) {
        itemX = self.lastFrame.origin.x + self.lastFrame.size.width + self.minimumLineSpacing;
    }
    
    attributes.frame = CGRectMake(itemX, itemY, itemSize.width, itemSize.height);
    
    //更新上一个item的位置
    self.lastFrame = CGRectMake(itemX, itemY, itemSize.width, itemSize.height);
    
    return  attributes;
}

//- (CGSize)collectionViewContentSize {
//    return self.collectionViewContentSize;
//}

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return  _attributesArray;
}
@end
