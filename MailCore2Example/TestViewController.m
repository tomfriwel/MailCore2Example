//
//  TestViewController.m
//  MailCore2Example
//
//  Created by tomfriwel on 16/11/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)keyboardDownHandler:(id)sender {
    [self.textView resignFirstResponder];
}

@end
