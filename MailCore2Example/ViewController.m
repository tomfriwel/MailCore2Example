//
//  ViewController.m
//  MailCore2Example
//
//  Created by tomfriwel on 22/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ViewController.h"
#import <MailCore/MailCore.h>

@interface ViewController ()

@property (strong, nonatomic) MCOIMAPSession *imapSession;

@property (weak, nonatomic) IBOutlet UITextField *imapHostNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailboxTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *imapPortTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginAction:(id)sender {
    NSString *imapHostName = self.imapHostNameTextField.text;
    NSString *imapPort = self.imapPortTextField.text;
    NSString *mailbox = self.mailboxTextField.text;
    NSString *password = self.passwordTextField.text;
    
    self.imapSession = [[MCOIMAPSession alloc] init];
    [self.imapSession setHostname:imapHostName];
    [self.imapSession setPort:[imapPort intValue]];
    [self.imapSession setUsername:mailbox];
    [self.imapSession setPassword:password];
    [self.imapSession setConnectionType:MCOConnectionTypeTLS];
    
    [[self.imapSession checkAccountOperation] start:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"check account success");
            
            id vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EmailListViewController"];
            [self presentViewController:vc animated:YES completion:nil];
        }
        else {
            NSLog(@"check account error:%@", error);
        }
    }];
}


@end
