//
//  Network.m
//  Forecast
//
//  Created by lu liu on 15/11/13.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Network.h"

static NSString *server=@"http://localhost/hw9_extract.php?";

@implementation Network



-(void)getLocation:(NSDictionary *)para completion:(void(^)(NSDictionary *))callback{
	
	
	
	NSString *street = [para objectForKey:@"street"];
	NSString *city=[para objectForKey:@("city")];
	NSString *state=[para objectForKey:@("state")];
	NSString *degree=[para objectForKey:@("degree")];
	
	NSString *address=[[[[street stringByAppendingString:@(",")]stringByAppendingString:city]stringByAppendingString:@(",")]stringByAppendingString:state];
	
	
	NSString *queryString=[[address stringByAppendingString:@("&degree=")]stringByAppendingString:degree];
	NSString *formatUrl = [queryString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
	NSString *urlString=[[server stringByAppendingString:@("address=")]
						 stringByAppendingString:formatUrl];
	NSURL * url = [NSURL URLWithString:urlString];
	NSLog(@"getLocation: %@",url);
	NSURLSession *session=[NSURLSession sharedSession];
	[[session dataTaskWithURL:url completionHandler:^(NSData *data,NSURLResponse *response, NSError *error){
		if (data == nil)
		{
			NSLog(@"response data is nil");
			return ;
		}
		
		NSDictionary *result=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: 0];
		callback(result);
		
	}]resume];

	
}



@end