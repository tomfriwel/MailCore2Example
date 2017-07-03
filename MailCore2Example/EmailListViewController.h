//
//  EmailListViewController.h
//  MailCore2Example
//
//  Created by tomfriwel on 24/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MailCore/MailCore.h>

@interface EmailListViewController : UIViewController

@property (strong, nonatomic) MCOIMAPSession *imapSession;

@end
