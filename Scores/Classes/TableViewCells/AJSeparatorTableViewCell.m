//
//  AJSeparatorTableViewCell.m
//  Scores
//
//  Created by Anca Calugar on 9/26/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJSeparatorTableViewCell.h"

@interface AJSeparatorTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *customSeparatorView;
@end

@implementation AJSeparatorTableViewCell

- (void)awakeFromNib {
    for(NSLayoutConstraint *cellConstraint in self.constraints){
        [self removeConstraint:cellConstraint];
        id firstItem = cellConstraint.firstItem == self ? self.contentView : cellConstraint.firstItem;
        id seccondItem = cellConstraint.secondItem == self ? self.contentView : cellConstraint.secondItem;
        NSLayoutConstraint* contentViewConstraint =
        [NSLayoutConstraint constraintWithItem:firstItem
                                     attribute:cellConstraint.firstAttribute
                                     relatedBy:cellConstraint.relation
                                        toItem:seccondItem
                                     attribute:cellConstraint.secondAttribute
                                    multiplier:cellConstraint.multiplier
                                      constant:cellConstraint.constant];
        [self.contentView addConstraint:contentViewConstraint];
    }

    
    self.customSeparatorView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"separator.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(2.0, 40.0, 0.0, 40.0)]];
    [self.contentView addSubview:self.customSeparatorView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.customSeparatorView sizeToFit];
    CGFloat separatorHeight = CGRectGetHeight(self.customSeparatorView.frame);
    CGSize contentViewSize = self.contentView.frame.size;
    [self.customSeparatorView setFrame:CGRectMake(0.0, contentViewSize.height - separatorHeight, contentViewSize.width, separatorHeight)];
}

@end
