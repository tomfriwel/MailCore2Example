//
//  EmailListViewController.m
//  MailCore2Example
//
//  Created by tomfriwel on 24/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "EmailListViewController.h"

@interface EmailListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *messages;

@end

@implementation EmailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // fetch inbox messages
    __weak typeof(self) weakSelf = self;
    [self fetchMessages:^(NSArray *data) {
        NSLog(@"fetchMessages count:%ld", data.count);
        weakSelf.messages = [data mutableCopy];
        [weakSelf.tableView reloadData];
        [weakSelf.indicator stopAnimating];
    }];
}

-(NSMutableArray *)messages {
    if (!_messages) {
        _messages = [[NSMutableArray alloc] init];
    }
    return _messages;
}

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)fetchMessages:(void(^)(NSArray *data))callback {
    NSString *folder = @"INBOX";
    NSMutableArray *mailList = [[NSMutableArray alloc] init];
    
    MCOIMAPFolderInfoOperation *folderInfo = [self.imapSession folderInfoOperation:folder];
    
    [folderInfo start:^(NSError *error, MCOIMAPFolderInfo *info) {
        if (!error) {
            MCOIndexSet *numbers = [MCOIndexSet indexSetWithRange:MCORangeMake(1, [info messageCount] - 1)];
            
            MCOIMAPMessagesRequestKind requestKind = (MCOIMAPMessagesRequestKind)
            (MCOIMAPMessagesRequestKindHeaders | MCOIMAPMessagesRequestKindStructure |
             MCOIMAPMessagesRequestKindInternalDate | MCOIMAPMessagesRequestKindHeaderSubject |
             MCOIMAPMessagesRequestKindFlags);
            
            MCOIMAPFetchMessagesOperation *fetchOperation = [self.imapSession fetchMessagesByNumberOperationWithFolder:folder requestKind:requestKind numbers:numbers];
            
            [fetchOperation start:^(NSError *error, NSArray *messages, MCOIndexSet *vanishedMessages) {
                for (MCOIMAPMessage * message in messages) {
                    [mailList addObject:message];
                }
                callback(mailList);
            }];
        } else {
            NSLog(@"fetch message failure: %@", error);
        }
    }];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    MCOIMAPMessage *message = self.messages[row];
    
    cell.textLabel.text = message.header.subject;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
