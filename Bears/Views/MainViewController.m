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
    // log in
    PFLogInViewController *viewController = [[PFLogInViewController alloc] init];
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"logo"];
    [logoView sizeToFit];
    viewController.logInView.logo = logoView;
    viewController.logInView.backgroundColor = [UIColor colorWithRed:1.0/256.0 green:29.0/256.0 blue:68.0/256.0 alpha:1.0];
    viewController.logInView.usernameField.backgroundColor = [UIColor whiteColor];
    viewController.logInView.passwordField.backgroundColor = [UIColor whiteColor];
    
    // sign up
    viewController.signUpController.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton;
    viewController.delegate = self;
    viewController.signUpController.delegate = self;
    UIImageView *logoView2 = [[UIImageView alloc] init];
    logoView2.image = [UIImage imageNamed:@"logo"];
    [logoView2 sizeToFit];
    viewController.signUpController.signUpView.logo = logoView2;
    viewController.signUpController.signUpView.backgroundColor = [UIColor colorWithRed:1.0/256.0 green:29.0/256.0 blue:68.0/256.0 alpha:1.0];
    viewController.signUpController.signUpView.usernameField.backgroundColor = [UIColor whiteColor];
    viewController.signUpController.signUpView.passwordField.backgroundColor = [UIColor whiteColor];
    
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
