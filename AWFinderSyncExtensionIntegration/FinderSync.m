//
//  FinderSync.m
//  AWFinderSyncExtensionIntegration
//
//  Created by Airatch on 26/10/15.
//  Copyright (c) 2015 AirWatch. All rights reserved.
//

#import "FinderSync.h"

@interface FinderSync ()

@property NSURL *myFolderURL;

@end

@implementation FinderSync

- (instancetype)init {
    self = [super init];
    

    NSLog(@"%s launched from %@ ; compiled at %s", __PRETTY_FUNCTION__, [[NSBundle mainBundle] bundlePath], __TIME__);

    // Set up the directory we are syncing.
    self.myFolderURL = [NSURL fileURLWithPath:@"/Users/airatch/PC-TEMP"];///Users/Shared/MySyncExtension Documents"];
    [FIFinderSyncController defaultController].directoryURLs = [NSSet setWithObject:self.myFolderURL];

    // Set up images for our badge identifiers. For demonstration purposes, this uses off-the-shelf images.
    [[FIFinderSyncController defaultController] setBadgeImage:[NSImage imageNamed: NSImageNameColorPanel] label:@"Status One" forBadgeIdentifier:@"One"];
    [[FIFinderSyncController defaultController] setBadgeImage:[NSImage imageNamed: NSImageNameCaution] label:@"Status Two" forBadgeIdentifier:@"Two"];
    
    return self;
}           

#pragma mark - Primary Finder Sync protocol methods

- (void)beginObservingDirectoryAtURL:(NSURL *)url {
    
    printf("User has opened the sync folder....11111");
    
    NSLog(@"User has opened the sync folder....");
    
    // The user is now seeing the container's contents.
    // If they see it in more than one view at a time, we're only told once.
    NSLog(@"\n beginObservingDirectoryAtURL:%@", url.filePathURL);
}


- (void)endObservingDirectoryAtURL:(NSURL *)url {
    // The user is no longer seeing the container's contents.
    NSLog(@"endObservingDirectoryAtURL:%@", url.filePathURL);
}

- (void)requestBadgeIdentifierForURL:(NSURL *)url {
    NSLog(@"requestBadgeIdentifierForURL:%@", url.filePathURL);
    
    // For demonstration purposes, this picks one of our two badges, or no badge at all, based on the filename.
//    NSInteger whichBadge = [url.filePathURL hash] % 3;
//    
//    
//    NSString* badgeIdentifier = @[@"", @"One", @"Two"][whichBadge];
//    [[FIFinderSyncController defaultController] setBadgeIdentifier:badgeIdentifier forURL:url];
    
    
    [[FIFinderSyncController defaultController] setBadgeImage:[NSImage imageNamed:@"sync-on.png"] label:NSLocalizedString(@"Custom", nil) forBadgeIdentifier:@"customStatusIcon"];
    
    
}

#pragma mark - Menu and toolbar item support

- (NSString *)toolbarItemName {
    return @"AWFinderSyncExtensionIntegration";
}

- (NSString *)toolbarItemToolTip {
    return @"AWFinderSyncExtensionIntegration: Click the toolbar item for a menu.";
}

- (NSImage *)toolbarItemImage {
    return [NSImage imageNamed: @"sidebar_16x16.png"];//NSImageNameCaution];
}

- (NSMenu *)menuForMenuKind:(FIMenuKind)whichMenu {
    // Produce a menu for the extension.
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@""];
    [menu addItemWithTitle:@"Copy link to share" action:@selector(sampleAction:) keyEquivalent:@""];

    return menu;
}

- (IBAction)sampleAction:(id)sender {
    NSURL* target = [[FIFinderSyncController defaultController] targetedURL];
    NSArray* items = [[FIFinderSyncController defaultController] selectedItemURLs];

    NSLog(@"sampleAction: menu item: %@, target = %@, items = ", [sender title], [target filePathURL]);
    [items enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"    %@", [obj filePathURL]);
    }];
}

@end

