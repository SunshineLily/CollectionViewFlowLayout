//
//  SecondWaterFlowLayout.h
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SecondWaterFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>



@end

@interface SecondWaterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<SecondWaterFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
