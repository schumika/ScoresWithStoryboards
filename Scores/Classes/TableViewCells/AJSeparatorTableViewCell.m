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
