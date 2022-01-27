//
//  FirstOtherWaterFlowLayout.m
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/26.
//

#import "FirstOtherWaterFlowLayout.h"

@interface UICollectionViewLayoutAttributes (LeftAligned)
- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset;

@end

@implementation UICollectionViewLayoutAttributes (LeftAligned)

- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset
{
    CGRect frame = self.frame;
    frame.origin.x = sectionInset.left;
    self.frame = frame;
}

@end

@implementation FirstOtherWaterFlowLayout
//获取指定位置的cell的布局
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *updatedAttributes = [NSMutableArray arrayWithArray:originAttributes];
    for (UICollectionViewLayoutAttributes *attributes in originAttributes) {
        if (!attributes.representedElementKind) {
            NSUInteger index = [updatedAttributes indexOfObject:attributes];
            updatedAttributes[index] = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
        }
    }
    return updatedAttributes ;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *currentAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    UIEdgeInsets sectionInset = self.sectionInset;
    
    BOOL isFirstItemInSection = indexPath.item == 0;
    CGFloat layoutWidth = CGRectGetWidth(self.collectionView.frame) - sectionInset.left - sectionInset.right;
    if (isFirstItemInSection) {
        [currentAttributes leftAlignFrameWithSectionInset:sectionInset];
        return  currentAttributes;
    }
    
    NSIndexPath *previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    CGRect currentFrame = currentAttributes.frame;
    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
    CGRect strecthedCurrentFrame = CGRectMake(sectionInset.left, currentFrame.origin.y, layoutWidth, currentFrame.size.height);
    //previousFrame和strecthedCurrentFrame不相交证明不在一行
    BOOL isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame);
    if (isFirstItemInRow) {
        [currentAttributes leftAlignFrameWithSectionInset:sectionInset];
        return  currentAttributes;
    }
    
    CGRect frame = currentAttributes.frame;
    frame.origin.x = previousFrameRightPoint + self.minimumInteritemSpacing;
    currentAttributes.frame = frame;
    return  currentAttributes;
}

@end
