//
//  ViewController.h
//  Forecast
//
//  Created by lu liu on 15/11/11.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate> {
	UITextField *street;
	UITextField *city;
	UILabel *warnm;
	
	NSArray *statesAll;
	Boolean weatherTag; //true: fa, false: ce
	Boolean streetTag,cityTag,stateTag;
}

@property (weak, nonatomic) IBOutlet UIButton *logoBtn;
	
	@property(nonatomic,retain)IBOutlet UITextField *street;
	@property(nonatomic,retain)IBOutlet UITextField *city;
	@property(nonatomic,retain)IBOutlet UILabel *warn;
	@property(nonatomic,retain)IBOutlet UIButton *search;
	@property(nonatomic,retain)IBOutlet UIButton *clear;
	@property(nonatomic,retain)IBOutlet UIButton *about;
	@property(nonatomic,retain)IBOutlet UIPickerView *states;
	@property(nonatomic,retain)IBOutlet UIButton *pickState;
	@property(nonatomic,retain)IBOutlet UIButton *sureState;
	@property(nonatomic,retain)IBOutlet UIButton *fa;
	@property(nonatomic,retain)IBOutlet UIButton *ce;
@property(nonatomic,retain)IBOutlet UIButton *cancel;
@property(nonatomic,retain)IBOutlet UIView *bg;


- (IBAction)clickLogo:(id)sender;
-(IBAction)selectFa:(id)sender;
-(IBAction)selectCe:(id)sender;
-(IBAction)pickState:(id)sender;
-(IBAction)clickSearch:(id)sender;
-(IBAction)clickClear:(id)sender;
@end

