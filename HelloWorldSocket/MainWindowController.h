//
//  MainWindowController.h
//  HelloWorldSocket
//
//  Created by Airatch on 10/7/15.
//  Copyright (c) 2015 AirWatch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainWindowController : NSViewController

-(int)getClientSocket;

-(IBAction) addPCToFav:(id)sender;

-(IBAction) removePCFromFav:(id)sender;

@end
