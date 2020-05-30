//
//  TreasureBoxCell.m
//  SegmentController
//
//  Created by Aalto on 14-6-7.
//  Copyright (c) 2014年 Aalto. All rights reserved.
//

#import "ACell.h"

@implementation ACell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
            self.contentView.backgroundColor = RGBCOLOR(218, 240, 254);
            //self.backgroundColor = RGBCOLOR(218, 240, 254);
        }
}

@end
