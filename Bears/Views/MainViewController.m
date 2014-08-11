//
//  MainViewController.m
//  Bears
//
//  Created by Anthony Picciano on 8/11/14.
//  Copyright (c) 2014 Picciano. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateDisplay];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (![PFUser currentUser])
    {
        [self logInOrCreateAccount];
    }
}

- (void)updateDisplay
{
    if ([PFUser currentUser])
    {
        self.usernameLabel.text = [[[PFUser currentUser] username] uppercaseString];
    }
}

- (void)logInOrCreateAccount
{
    PFLogInViewController *viewController = [[PFLogInViewController alloc] init];
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"logo"];
    [logoView sizeToFit];
    viewController.logInView.logo = logoView;
    
    viewController.signUpController.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton;
    viewController.delegate = self;
    viewController.signUpController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateDisplay];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateDisplay];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateDisplay];
}

- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateDisplay];
}

@end
