//
//  SideBarMenuController.m
//  
//
//  Created by Airatch on 10/20/15.
//
//

#import "SideBarMenuController.h"

@implementation SideBarMenuController


LSSharedFileListRef
(*tunnelInit)(
              CFAllocatorRef   inAllocator,
              CFStringRef      inListType,
              CFTypeRef        listOptions);

-(void) addPathToFavourites:(NSString *)path{
    
    CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    
    // Create a reference to the shared file list
    CFStringRef yourFriendlyCFString = (__bridge CFStringRef)@"com.apple.LSSharedFileList.FavoriteItems";
    LSSharedFileListRef favoriteItems = LSSharedFileListCreate(NULL,
                                                               yourFriendlyCFString, NULL);
    if (favoriteItems) {
        //Insert an item to the list.
        LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(favoriteItems,
                                                                     kLSSharedFileListItemLast, NULL, NULL,
                                                                     url, NULL, NULL);
        if (item){
            CFRelease(item);
        }
    }
    
    CFRelease(favoriteItems);

}

-(void) removePathFromFavourites:(NSString *)path{
    
    // Create a reference to the shared file list.
    LSSharedFileListRef favoriteItems = LSSharedFileListCreate(NULL, kLSSharedFileListFavoriteItems, NULL);
    
    // Check Items
    if (favoriteItems)
    {
        // Get Login Items
        CFArrayRef favoriteItemsArray = LSSharedFileListCopySnapshot(favoriteItems, NULL);
        
        // Loop Through Items
        for (id item in (__bridge NSArray *)favoriteItemsArray)
        {
            // Get Item Ref
            LSSharedFileListItemRef itemRef = (__bridge LSSharedFileListItemRef)item;
            
            // Get Item URL
            CFURLRef itemURL = LSSharedFileListItemCopyResolvedURL(itemRef, kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes, NULL);
            if (itemURL != NULL)
            {
                // If Item Matches Remove It
                if ([[(__bridge NSURL *)itemURL path] hasPrefix:path])
                    LSSharedFileListItemRemove(favoriteItems, itemRef);
                
                // Release
                if (itemURL != NULL)
                    CFRelease(itemURL);
            }
        }
        
        // Release
        if (favoriteItemsArray != NULL)
            CFRelease(favoriteItemsArray);
    }
    
    // Release
    if (favoriteItems != NULL)
        CFRelease(favoriteItems);
}

@end
