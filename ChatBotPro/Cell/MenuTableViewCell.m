//
//  MenuTableViewCell.m
//  ChatBot
//
//  Created by Ashish Kr Singh on 14/07/18.
//  Copyright © 2018 Ashish Kr Singh. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageView.image = [UIImage imageNamed:@"round"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
