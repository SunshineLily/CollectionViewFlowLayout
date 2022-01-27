//
//  SecondWaterFlowLayout.m
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/25.
//

#import "SecondWaterFlowLayout.h"

@interface SecondWaterFlowLayout()
{
    CGFloat yOffSet;
}

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *itemAttributes;
@property (nonatomic,assign) NSInteger perLineCount;
@property (nonatomic,strong) NSMutableArray *yOffsetArray;
@end

@implementation SecondWaterFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    UIEdgeInsets sectionInset = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    
    CGFloat xOffSet = sectionInset.left;
    yOffSet = sectionInset.right;
    CGSize size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSInteger count = floor(self.collectionView.bounds.size.width - sectionInset.left - sectionInset.right + self.minimumInteritemSpacing)/(size.width + self.minimumInteritemSpacing);
    self.perLineCount = count;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    self.yOffsetArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < itemCount; i++) {
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (xOffSet + sectionInset.right + itemSize.width <= self.collectionView.bounds.size.width) {
            if (self.yOffsetArray.count == count) {
                yOffSet = [[self.yOffsetArray objectAtIndex:(i % count)] floatValue] + self.minimumLineSpacing;
            }
            attributes.frame = CGRectMake(xOffSet, yOffSet, itemSize.width, itemSize.height);
            [self.itemAttributes addObject:attributes];
            xOffSet = xOffSet + itemSize.width + self.minimumInteritemSpacing;
            if (self.yOffsetArray.count < count) {
                [self.yOffsetArray addObject:@(yOffSet + itemSize.height)];
            } else {
                float  currentOffSet = [[self.yOffsetArray objectAtIndex:(i%count)] floatValue];
                [self.yOffsetArray replaceObjectAtIndex:(i % count) withObject:@(currentOffSet + self.minimumLineSpacing + itemSize.height)];
            }
           ;
        } else {
            //换行
            xOffSet = sectionInset.left;
            yOffSet = [[self.yOffsetArray objectAtIndex:(i % count)] floatValue] + self.minimumLineSpacing;
            attributes.frame = CGRectMake(xOffSet, yOffSet, itemSize.width, itemSize.height);
            [self.itemAttributes addObject:attributes];
            xOffSet = xOffSet + itemSize.width + self.minimumInteritemSpacing;
            yOffSet = yOffSet + itemSize.height;
            [self.yOffsetArray replaceObjectAtIndex:(i%count) withObject:@(yOffSet)];
        }
    }

}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *updateAttributes = [NSMutableArray arrayWithArray:originalAttributes];
    for (UICollectionViewLayoutAttributes *attributes in originalAttributes) {
        if (!attributes.representedElementKind) {
            NSUInteger index = [updateAttributes indexOfObject:attributes];
            updateAttributes[index] = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
        }
    }
    return  self.itemAttributes;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
//}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)itemAttributes {
    if (!_itemAttributes) {
        _itemAttributes = [NSMutableArray array];
    }
    return  _itemAttributes;
}

- (CGSize)collectionViewContentSize {
    CGFloat maxOffset = 0;
    for (NSInteger i = 0; i < self.yOffsetArray.count; i++) {
        if (maxOffset <= [[self.yOffsetArray objectAtIndex:i] floatValue]) {
            maxOffset = [[self.yOffsetArray objectAtIndex:i] floatValue];
        }
    }
    return CGSizeMake(self.collectionView.bounds.size.width, maxOffset);
}
@end
