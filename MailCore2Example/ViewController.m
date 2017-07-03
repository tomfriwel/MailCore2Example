//
//  ViewController.m
//  MailCore2Example
//
//  Created by tomfriwel on 22/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ViewController.h"
#import <MailCore/MailCore.h>
#import "EmailListViewController.h"

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
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *imapHostName = [userDefaults valueForKey:@"imapHostName"];
    NSString *imapPort = [userDefaults valueForKey:@"imapPort"];
    NSString *mailbox = [userDefaults valueForKey:@"mailbox"];
    NSString *password = [userDefaults valueForKey:@"password"];
    
    if (imapHostName && imapPort && mailbox && password) {
        self.imapHostNameTextField.text = imapHostName;
        self.imapPortTextField.text = imapPort;
        self.mailboxTextField.text = mailbox;
        self.passwordTextField.text = password;
    }
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
    [userDefaults setValue:imapHostName forKey:@"imapHostName"];
    [userDefaults setValue:imapPort forKey:@"imapPort"];
    [userDefaults setValue:mailbox forKey:@"mailbox"];
    [userDefaults setValue:password forKey:@"password"];
    
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
