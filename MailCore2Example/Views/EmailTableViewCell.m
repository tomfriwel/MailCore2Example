//
//  EmailTableViewCell.m
//  MailCore2Example
//
//  Created by tomfriwel on 14/11/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "EmailTableViewCell.h"

@interface EmailTableViewCell()

@end

@implementation EmailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)cellHeight {
    return 123;
}

@end
