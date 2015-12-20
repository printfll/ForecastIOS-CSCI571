//
//  ViewController.m
//  Forecast
//
//  Created by lu liu on 15/11/11.
//  Copyright © 2015年 lu liu. All rights reserved.
//


/**
	'KY'=> 'Kentucky',	'LA'=> 'Louisiana',	'ME'=> 'Maine',	'MD'=> 'Maryland',	'MA'=> 'Massachusetts',
	'MI'=> 'Michigan',	'MN'=> 'Minnesota',	'MS'=> 'Mississippi',	'MO'=> 'Missouri',	'MT'=> 'Montana',
	'NE'=> 'Nebraska',	'NV'=> 'Nevada',	'NH'=> 'New Hampshire',	'NJ'=> 'New Jersey',
	'NM'=> 'New Mexico',	'NY'=> 'New York',	'NC'=> 'North Carolina',	'ND'=> 'North Dakota',
	'OH'=> 'Ohio',	'OK'=> 'Oklahoma',	'OR'=> 'Oregon',	'PA'=> 'Pennsylvania',	'RI'=> 'Rhode Island',
	'SC'=> 'South Carolina',	'SD'=> 'South Dakota',	'TN'=> 'Tennessee',	'TX'=> 'Texas',
	'UT'=> 'Utah',	'VT'=> 'Vermont',	'VA'=> 'Virginia',	'WA'=> 'Washington',	'WV'=> 'West Virginia',
	'WI'=> 'Wisconsin',	'WY'=> 'Wyoming',*/

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Aeris/Aeris.h>
#import <AerisUI/AerisUI.h>
#import <AerisMap/AerisMap.h>
#import "Network.h"

#import "ResultViewController.h"

@import GoogleMaps;

@interface ViewController ()

@end


@implementation ViewController
	@synthesize street;
	@synthesize city;
	@synthesize clear;
	@synthesize search;
	@synthesize about;
	@synthesize warn;
	@synthesize states;
	@synthesize pickState;
	@synthesize sureState;
	@synthesize fa;
	@synthesize ce;
@synthesize bg;
@synthesize logoBtn;
@synthesize cancel;

- (void)viewDidLoad {
    [super viewDidLoad];
	statesAll=[[NSArray alloc]initWithObjects:@("Alabama"),@("Alaska"),@("Arizona"),@("Arkansas"),@("California"),
		@("Colorado"),@("Connecticut"),@("Delaware"),@("District Of Columbia"),
		@("Florida"),@("Georgia"),@("Hawaii"),@("Idaho"),@("Illinois"),
		@("Indiana"),@("Iowa"),@("Kansas"),@("Kentucky"),@("Louisiana"),@("Maine"),@("Maryland"),
		@("Massachusetts"),@("Michigan"),@("Minnesota"),@("Mississippi"),@("Missouri"),@("Montana"),
		@("Nebraska"),@("Nevada"),@("New Hampshire"),@("New Jersey"),@("New Mexico"),@("New York"),
		@("North Carolina"),@("North Dakota"),@("Ohio"),@("Oklahoma"),@("Oregon"),@("Pennsylvania"),
		@("Rhode Island"),@("South Carolina"),@("South Dakota"),@("Tennessee"),@("Texas"),@("Utah"),
		@("Vermont"),@("Virginia"),@("Washington"),@("West Virginia"),@("Wisconsin"),@("Wyoming"),nil];
	
	states=nil;
	sureState=nil;
	UIView *background=[[UIView alloc]initWithFrame:CGRectMake(10, 98, 394, 169)];
	[background setBackgroundColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]];
	[self.view insertSubview:background atIndex:0];
	
	[logoBtn setBackgroundImage:[UIImage imageNamed:@"image/forecast_logo.png"] forState:UIControlStateNormal];
	UIGraphicsBeginImageContext(self.view.frame.size);
	[[UIImage imageNamed:@"image/background_2.jpg"] drawInRect:self.view.bounds];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	city.delegate=self;
	
    [street addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[city addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	street.delegate=self;
	self.view.backgroundColor = [UIColor colorWithPatternImage:image];
	
	bg=[[UIView alloc]initWithFrame:CGRectMake(10, 380, 394, 30)];
	[bg setBackgroundColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]];
	[self.view addSubview:bg];
	
	sureState=[[UIButton alloc]initWithFrame:CGRectMake(249, 380, 70, 30)];
	[sureState setTitle:@"sure" forState:UIControlStateNormal];
	[sureState setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[sureState addTarget:self action:@selector(getState:)forControlEvents:UIControlEventTouchDown ];
	[sureState setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:sureState];
	
	cancel=[[UIButton alloc]initWithFrame:CGRectMake(324, 380, 70, 30)];
	[cancel setTitle:@"cancel" forState:UIControlStateNormal];
	[cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[cancel addTarget:self action:@selector(cancelChoose:)forControlEvents:UIControlEventTouchDown ];
	[cancel setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:cancel];
	
	states = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 410, 394, 200)];
	states.delegate = self;
	states.dataSource = self;
	states.showsSelectionIndicator = YES;
	[states setBackgroundColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]];
	[self.view addSubview:states];
	
	[bg setHidden:YES];
	[sureState setHidden:YES];
	[cancel setHidden:YES];
	[states setHidden:YES];
	
	[self initDegree];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[street resignFirstResponder];
	[city resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initDegree{
	UIImage *btnImage = [UIImage imageNamed:@"image/check.png"];
	[fa setBackgroundImage:btnImage forState:UIControlStateNormal];
	UIImage *sebtnImage = [UIImage imageNamed:@"image/uncheck"];
	[ce setBackgroundImage:sebtnImage forState:UIControlStateNormal];
	weatherTag=true;
}
	

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}
	
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == 0) {
		return [statesAll count];
	}else{
		return [statesAll count];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	if (textField == street) {   //如果現是nameField
		[textField resignFirstResponder]; //不再注視nameField
		[city becomeFirstResponder]; //注視emailField
	} else if (textField == city) {
		[city resignFirstResponder];
	}
	return YES;
}
- (void) textFieldDidChange:(UITextField *) sender {
	if (sender==street&&[warn.text isEqualToString:@"Please enter a Street Address"]) {
		warn.text=@"";
	}
	if (sender==city&&[warn.text isEqualToString:@"Please enter a city"]) {
		warn.text=@"";
	}
}
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{// 返回该行标题
	
	if (component == 0) {
		return [statesAll objectAtIndex:row];
	}
	else{
	
		return [statesAll objectAtIndex:row];
	}
	
	
}


//click "select a state"
-(IBAction)pickState:(id)sender{
	[street resignFirstResponder];
	[city resignFirstResponder];
	[bg setHidden:NO];
	[sureState setHidden:NO];
	[cancel setHidden:NO];
	[states setHidden:NO];

	if ([pickState.currentTitle isEqualToString:@("select a state")]) {
		[states selectRow:0 inComponent:0 animated:YES];
	}else{
		NSInteger index=[statesAll indexOfObject:pickState.currentTitle];
		[states selectRow:index inComponent:0 animated:YES];
	}
	
	
}


-(IBAction)cancelChoose:(id)sender{
	[bg setHidden:YES];
	[sureState setHidden:YES];
	[cancel setHidden:YES];
	[states setHidden:YES];
}

//after click sure
-(IBAction)getState:(id)sender{
	if (states!=nil) {
		NSInteger row=[self.states selectedRowInComponent:0];
		NSString *content=[statesAll objectAtIndex:row];
		[pickState setTitle:content forState:UIControlStateNormal];
		[bg setHidden:YES];
		[sureState setHidden:YES];
		[cancel setHidden:YES];
		[states setHidden:YES];
		if([warn.text isEqualToString:@"Please select a state"]){
			warn.text=@"";
		}
	}
}

- (IBAction)clickLogo:(id)sender {
	NSURL *url = [NSURL URLWithString:@"http://forecast.io"];
	[[UIApplication sharedApplication] openURL:url];
}

-(IBAction)selectFa:(id)sender{
	UIImage *btnImage = [UIImage imageNamed:@"image/check.png"];
	[fa setBackgroundImage:btnImage forState:UIControlStateNormal];
	UIImage *sebtnImage = [UIImage imageNamed:@"image/uncheck.png"];
	[ce setBackgroundImage:sebtnImage forState:UIControlStateNormal];
	weatherTag=true;
	
}

-(IBAction)selectCe:(id)sender{
	UIImage *btnImage = [UIImage imageNamed:@"image/check.png"];
	[ce setBackgroundImage:btnImage forState:UIControlStateNormal];
	UIImage *sebtnImage = [UIImage imageNamed:@"image/uncheck.png"];
	[fa setBackgroundImage:sebtnImage forState:UIControlStateNormal];
	weatherTag=false;
	

}

-(IBAction)clickClear:(id)sender{
	street.text=@("");
	city.text=@("");
	warn.text=@("");
	[pickState setTitle:@("select a state") forState:UIControlStateNormal];
	[bg setHidden:YES];
	[sureState setHidden:YES];
	[cancel setHidden:YES];
	[states setHidden:YES];
	[self initDegree];
}

-(IBAction)clickSearch:(id)sender{
	Boolean tag=true;
	NSString *streetStr=street.text;
	NSString *cityStr=city.text;
	
	if (streetStr.length==0) {
		warn.text=@("Please enter a Street Address");
		tag=false;
		return;
	}
	if (cityStr.length==0) {
		warn.text=@("Please enter a city");
		tag=false;
		return;
	}
	
	if ([pickState.currentTitle isEqualToString:@("select a state")]) {
		warn.text=@("Please select a state");
		tag=false;
		return;
	}
	
	if (tag==true) {
		NSString *degreeStr;
		if(weatherTag==true){
			degreeStr=@"Fahrenheit";
		}else{
			degreeStr=@"Celsius";
		}
		
		NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:streetStr,@"street",cityStr,@"city",pickState.currentTitle,@"state",degreeStr,@"degree", nil];
		[[[Network alloc]init]getLocation:dict completion:^(NSDictionary *result) {
			[self dealWithResult:result];
		}];
		
		
	}
	
}

-(void)dealWithResult:(NSDictionary*)result{
	if (result==nil) {
		NSLog(@"result is nil at clickSearch");
		exit(-1);
	} else {
		
		NSString* status=[result objectForKey:@("status")];
		if ([status isEqualToString:@"ZERO_RESULTS"]) {
			NSLog(@"search is invalid");
			return;
		} else {
			
			dispatch_async(dispatch_get_main_queue(), ^{
				ResultViewController *resultView=[[UIStoryboard storyboardWithName:@"ResultView" bundle:nil]instantiateViewControllerWithIdentifier:@"dayResult"];
				NSDictionary *allResult=[[NSDictionary alloc]initWithObjectsAndKeys:result,@"result",city.text,@"city",pickState.currentTitle,@"state", nil];
				resultView.result=allResult;
				
				
				[self presentViewController:resultView animated:YES completion:nil];
				
			});
			
			
		}
	}
}



@end
