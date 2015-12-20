//
//  UIViewController+MapViewController.h
//  Forecast
//
//  Created by lu liu on 15/11/22.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Aeris/Aeris.h>
#import <AerisUI/AerisUI.h>
#import <AerisMap/AerisMap.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController:UIViewController<AWFWeatherMapDelegate>{
	NSDictionary *result;
	NSDictionary *current;
	CLLocationDegrees lat;
	CLLocationDegrees lng;
	AWFWeatherMapLegendView *legendView;
	AWFWeatherMapViewController *weatherMapController;
}

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)returnToFirstPage:(id)sender;


@end
