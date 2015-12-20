//
//  UITableViewCell+DayTableCell.h
//  Forecast
//
//  Created by lu liu on 15/11/19.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayTableCell: UITableViewCell

@property(nonatomic,retain)IBOutlet UILabel*dayLB;
@property(nonatomic,retain)IBOutlet UILabel*monthLB;
@property(nonatomic,retain)IBOutlet UILabel*minTempLB;
@property(nonatomic,retain)IBOutlet UILabel*maxTempLB;
@property(nonatomic,retain)IBOutlet UIImageView*iconImageView;


@end
