//
//  FirstWaterViewModel.h
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import "FirstWaterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstWaterViewModel : NSObject

- (void)configData:(void(^)(void))completion;

- (NSInteger)numberOfItemsInSection:(NSInteger)section;

- (FirstWaterModel *)modelOfRow:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
