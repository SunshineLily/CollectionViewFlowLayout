//
//  FirstCollectionCell.m
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/25.
//

#import "FirstCollectionCell.h"

@interface FirstCollectionCell()
@property (weak, nonatomic) IBOutlet UIView *cornerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FirstCollectionCell

- (void)setModel:(FirstWaterModel *)model {
    self.titleLabel.text = model.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.frame = self.cornerView.bounds;
    CGRect bounds = CGRectMake(0, 0, self.cornerView.bounds.size.width, self.cornerView.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(7, 7)];
    layer.path = path.CGPath;
//    self.cornerView.layer.mask = layer;
    self.cornerView.layer.cornerRadius = 14;
    self.cornerView.layer.masksToBounds = YES;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    
//    layer.frame = self.cornerView.bounds;
//    CGRect bounds = CGRectMake(0, 0, self.cornerView.bounds.size.width, self.cornerView.bounds.size.height);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(7, 7)];
//    layer.path = path.CGPath;
//    self.cornerView.layer.mask = layer;
//
//}

@end
