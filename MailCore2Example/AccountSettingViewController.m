//
//  AccountSettingViewController.m
//  MailCore2Example
//
//  Created by tomfriwel on 14/11/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "AccountSettingViewController.h"
#import <MailCore/MailCore.h>
#import "EmailListViewController.h"

#define imapHostNameKey @"imapHostName"
#define imapPortKey @"imapPort"
#define mailboxKey @"mailbox"
#define passwordKey @"password"


@interface AccountSettingViewController ()

@property (strong, nonatomic) MCOIMAPSession *imapSession;

@property (weak, nonatomic) IBOutlet UITextField *imapHostNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailboxTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *imapPortTextField;
@end

@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAccountData];
}

-(void)loadAccountData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self.imapHostNameTextField setText: [userDefaults stringForKey:imapHostNameKey]];
    [self.imapPortTextField setText: [userDefaults stringForKey:imapPortKey]];
    [self.mailboxTextField setText: [userDefaults stringForKey:mailboxKey]];
    [self.passwordTextField setText: [userDefaults stringForKey:passwordKey]];
}

- (IBAction)loginAction:(id)sender {
    NSString *imapHostName = self.imapHostNameTextField.text;
    NSString *imapPort = self.imapPortTextField.text;
    NSString *mailbox = self.mailboxTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if ([imapHostName isEqual:@""] || [imapPort isEqual:@""] || [mailbox isEqual:@""] || [password isEqual:@""]) {
        return;
    }
    
    self.imapSession = [[MCOIMAPSession alloc] init];
    [self.imapSession setHostname:imapHostName];
    [self.imapSession setPort:[imapPort intValue]];
    [self.imapSession setUsername:mailbox];
    [self.imapSession setPassword:password];
    [self.imapSession setConnectionType:MCOConnectionTypeTLS]; // change this if need
    
    // save
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:imapHostName forKey:imapHostNameKey];
    [userDefaults setValue:imapPort forKey:imapPortKey];
    [userDefaults setValue:mailbox forKey:mailboxKey];
    [userDefaults setValue:password forKey:passwordKey];
    
    [[self.imapSession checkAccountOperation] start:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"check account success");
            
            EmailListViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EmailListViewController"];
            vc.imapSession = self.imapSession;
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
        else {
            NSLog(@"check account error:%@", error);
        }
    }];
}


@end
