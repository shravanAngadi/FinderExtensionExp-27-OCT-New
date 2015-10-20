//
//  MainWindowController.m
//  HelloWorldSocket
//
//  Created by Airatch on 10/7/15.
//  Copyright (c) 2015 AirWatch. All rights reserved.
//

#import "MainWindowController.h"
#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <arpa/inet.h>
#import "SideBarMenuController.h"


@interface MainWindowController ()

@property (strong, nonatomic) SideBarMenuController *sideBarMenuController;

@end


static int count;

@implementation MainWindowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    count = 0;
    
    self.sideBarMenuController = [SideBarMenuController alloc];
    
}

-(IBAction) addPCToFav:(id)sender{
    NSString *absolutePath = @"/Users/airatch/PersonalContent-Sync";
    
    NSLog(@"User said add his PC to fav's %@ ", absolutePath);
    
    
    //printf("User said add his PC to fav's %@ ", absolutePath);
    
    
    
    
}

-(IBAction) removePCFromFav:(id)sender{
    NSString *absolutePath = @"/Users/airatch/PersonalContent-Sync";
    
    NSLog(@"Remove PC from fav's %@ ", absolutePath);
    
}


- (IBAction)onClick:(id)sender {
    
    printf("\n\nUser said connect to socket! %d", count);

    
    //write some code here to create a new socket and write something to it!
    
    count++;
    
    int clientSocket = 0;
    char buffer[1024];
    
    if (clientSocket == 0) {
        clientSocket = [self getClientSocket];
    }
    
    //send something to Xamarin
    send(clientSocket, "SYN" , 1024, 0);
    
    
    /*---- Read the message from the server into the buffer ----*/
    recv(clientSocket, buffer, 1024, 0);
    
    /*---- Print the received message ----*/
    printf("\nData received: %s",buffer);
    

    //NSString *receivedData = [NSString stringWithCString:buffer encoding:NSASCIIStringEncoding];
    
    //if([receivedData containsString:@"SYN/ACK"]){
        //clientSocket = [self getClientSocket];

        send(clientSocket, "ACK", 1024, 0);
        printf("\n Sending acknowledgement to CS!");
    //}
    
}

-(int)getClientSocket {
    int clientSocket;
    struct sockaddr_in serverAddr;
    socklen_t addr_size;
    
    /*---- Create the socket. The three arguments are: ----*/
    /* 1) Internet domain 2) Stream socket 3) Default protocol (TCP in this case) */
    clientSocket = socket(PF_INET, SOCK_STREAM, 0);
    
    /*---- Configure settings of the server address struct ----*/
    /* Address family = Internet */
    serverAddr.sin_family = AF_INET;
    /* Set port number, using htons function to use proper byte order */
    serverAddr.sin_port = htons(8888);
    /* Set IP address to localhost */
    serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    /* Set all bits of the padding field to 0 */
    memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);
    
    /*---- Connect the socket to the server using the address struct ----*/
    addr_size = sizeof serverAddr;
    connect(clientSocket, (struct sockaddr *) &serverAddr, addr_size);
    return clientSocket;
}

@end
