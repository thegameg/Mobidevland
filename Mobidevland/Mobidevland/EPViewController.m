//
//  EPViewController.m
//  Mobidevland
//
//  Created by Francis Visoiu Mistrih on 23/11/2013.
//  Copyright (c) 2013 EpiPortal. All rights reserved.
//

#import "EPViewController.h"

@interface EPViewController ()

@end

@implementation EPViewController {
    NSMutableArray *linkArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    PFQuery *query = [PFQuery queryWithClassName:@"BannerURL"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            linkArray = [self objectArrayToLinkArray:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    currentUser = [PFUser currentUser];
    if (currentUser){
        [accountButton setTitle:@"Mon Compte" forState:UIControlStateNormal];
        [accountButton setImage:[UIImage imageNamed:@"LedOn"] forState:UIControlStateNormal];
    }
    else {
        [accountButton setTitle:@"Se Connecter" forState:UIControlStateNormal];
        [accountButton setImage:[UIImage imageNamed:@"LedOff"] forState:UIControlStateNormal];
    }
}

- (IBAction)accountButtonPressed:(id)sender {
    if (currentUser)
        [self performSegueWithIdentifier:@"MyAccount" sender:self];
    else
        [self performSegueWithIdentifier:@"GoToSignIn" sender:self];
}

- (BOOL)isConnectedAlert{
    if (currentUser)
        return true;
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Pour accéder à cette rubrique, vous devez être connecté" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Me connecter", nil];
        [alert show];
        return false;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Cancel Tapped.");
    }
    else if (buttonIndex == 1) {
        NSLog(@"Ok Tapped");
        [self performSegueWithIdentifier:@"GoToSignIn" sender:self];
    }
}

- (NSMutableArray *) objectArrayToLinkArray:(NSArray *)objectArray {
    NSMutableArray *linkConvertedArray;
    linkConvertedArray = [NSMutableArray arrayWithCapacity:[objectArray count]];
    
    for (PFObject *object in objectArray) {
        NSURL *url = [NSURL URLWithString:object[@"url"]];
        [linkConvertedArray addObject:url];
    }
    
    return linkConvertedArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myAccountPressed:(id)sender {
    if (currentUser)
        [self performSegueWithIdentifier:@"MyAccount" sender:self];
    else
        [self performSegueWithIdentifier:@"GoToSignIn" sender:self];
}

- (IBAction)jobsPressed:(id)sender {
    if ([self isConnectedAlert])
        [self performSegueWithIdentifier:@"Jobs" sender:self];
}

- (IBAction)appelAProjetsPressed:(id)sender {
    if ([self isConnectedAlert])
        [self performSegueWithIdentifier:@"AppelAProjets" sender:self];
}

- (IBAction)favorisPressed:(id)sender {
    if ([self isConnectedAlert])
        [self performSegueWithIdentifier:@"Favoris" sender:self];
}

- (IBAction)chatPressed:(id)sender {
    if ([self isConnectedAlert])
        [self performSegueWithIdentifier:@"Chat" sender:self];
}

- (IBAction)touchPressed:(id)sender {
    if ([self isConnectedAlert])
        [self performSegueWithIdentifier:@"Touch" sender:self];
}

- (IBAction)wikiPressed:(id)sender {
    [self performSegueWithIdentifier:@"Wiki" sender:self];
}

- (IBAction)qrCodePressed:(id)sender {
    [self performSegueWithIdentifier:@"QRCode" sender:self];
}

- (IBAction)projetsPressed:(id)sender {
    if ([self isConnectedAlert])
        [self performSegueWithIdentifier:@"Projets" sender:self];
}

- (IBAction)eventsPressed:(id)sender {
    if ([self isConnectedAlert])
        [self performSegueWithIdentifier:@"Events" sender:self];
}
@end
