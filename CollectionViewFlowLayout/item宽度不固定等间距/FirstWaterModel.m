//
//  FirstWaterModel.m
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/25.
//

#import "FirstWaterModel.h"

@implementation FirstWaterModel

- (CGSize)textSize {
    NSString *string = [NSString stringWithFormat:@"%@",self.title];
    
    CGFloat width = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 28) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.width;
    if (width < 12) {
        width = 12;
    }
    return  CGSizeMake(width + 17, 28); //12里面有10个像素是uilabel居左右的边距
}

@end
