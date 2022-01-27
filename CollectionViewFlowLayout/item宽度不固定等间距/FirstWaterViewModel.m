//
//  FirstWaterViewModel.m
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/25.
//

#import "FirstWaterViewModel.h"

@interface FirstWaterViewModel ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FirstWaterViewModel

- (void)configData:(void(^)(void))completion {
    for (int i = 0; i < 10; i++) {
        FirstWaterModel *model = [[FirstWaterModel alloc] init];
        NSString *title = @"";
        if (i == 0) {
            title = @"一起转圈圈，呜啦啦呜啦啦呜啦啦呜啦啦";
        } else if (i == 1) {
            title = @"一起转圈圈";
        } else if (i == 2) {
            title = @"呜啦啦";
        } else if (i == 3) {
            title = @"是";
        } else if (i == 4) {
            title = @"叮当当，哒哒哒哒哒哒";
        } else if (i == 5) {
            title = @"一起转圈圈";
        } else if (i == 6) {
            title = @"响叮当";
        } else if (i == 7) {
            title = @"叮当";
        } else if (i == 8) {
            title = @"hello World!";
        } else if (i == 9) {
            title = @"Hello SwiftUI!";
        }
        model.title = title;
        [self.dataArray addObject:model];
    }
    completion();
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (FirstWaterModel *)modelOfRow:(NSIndexPath *)indexPath {
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
