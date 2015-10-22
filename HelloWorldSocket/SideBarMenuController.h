//
//  SideBarMenuController.h
//  
//
//  Created by Airatch on 10/20/15.
//
//

#import <Foundation/Foundation.h>

@interface SideBarMenuController : NSObject


-(void) addPathToFavourites:(NSString *)path;
-(void) removePathFromFavourites:(NSString *)path;

@end
