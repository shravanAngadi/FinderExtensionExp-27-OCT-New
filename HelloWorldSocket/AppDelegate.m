//
//  AppDelegate.m
//  HelloWorldSocket
//
//  Created by Airatch on 10/6/15.
//  Copyright (c) 2015 AirWatch. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong, nonatomic) IBOutlet MainWindowController *mainWindowController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.mainWindowController = [[MainWindowController alloc] initWithNibName:@"MainWindowController" bundle:nil];
    
    [self.window.contentView addSubview:self.mainWindowController.view];
    self.mainWindowController.view.frame= ((NSView*)self.window.contentView).bounds;

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
