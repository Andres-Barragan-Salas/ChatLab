//
//  LoginViewController.m
//  ChatLab
//
//  Created by Andres Barragan on 06/07/20.
//  Copyright © 2020 Andres Barragan. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
//    newUser.email = self.emailField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    if(!([self.usernameTextField.text isEqual:@""] || [self.passwordTextField.text isEqual:@""])) {
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sign up failed"
                       message:@"Please review your the fields"
                preferredStyle:(UIAlertControllerStyleAlert)];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                  style:UIAlertActionStyleCancel
                handler:^(UIAlertAction * _Nonnull action) {}];
                
                [alert addAction:cancelAction];
                
                [self presentViewController:alert animated:YES completion:^{}];
            } else {
                NSLog(@"User registered successfully");
                
                // Logs in automatically
                [self loginUser];
            }
        }];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty fields"
               message:@"Please complete all the required fields"
        preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
          style:UIAlertActionStyleCancel
        handler:^(UIAlertAction * _Nonnull action) {}];
        
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:^{}];
    }
}

- (void)loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if(!([self.usernameTextField.text isEqual:@""] || [self.passwordTextField.text isEqual:@""])) {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Log in failed"
                       message:@"Please review your credentials"
                preferredStyle:(UIAlertControllerStyleAlert)];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                  style:UIAlertActionStyleCancel
                handler:^(UIAlertAction * _Nonnull action) {}];
                
                [alert addAction:cancelAction];
                
                [self presentViewController:alert animated:YES completion:^{}];
            } else {
                NSLog(@"User logged in successfully");
                
                // display view controller that needs to shown after successful login
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty fields"
               message:@"Please complete all the required fields"
        preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
          style:UIAlertActionStyleCancel
        handler:^(UIAlertAction * _Nonnull action) {}];
        
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:^{}];
    }
}

- (IBAction)tappedSignup:(id)sender {
    [self registerUser];
}

- (IBAction)tappedLogin:(id)sender {
    [self loginUser];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
