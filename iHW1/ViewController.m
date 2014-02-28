//
//  ViewController.m
//  iHW1
//
//  Created by Kevin Qi on 2/25/14.
//  Copyright (c) 2014 Kevin Qi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userGuess;
@property (weak, nonatomic) IBOutlet UILabel *currentParticalWord;
@property (strong, nonatomic) IBOutlet UIImageView* imageView;

@end

@implementation ViewController



- (void)viewDidLoad
{
    //self.imageView = nil;
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    // generate a random word
    _userGuess.delegate = self;
    newGame = [[GameLogic alloc] init];
    [_currentParticalWord setText: [newGame generateOutput]];
    [self displayImage];
    self.userGuess.delegate = self;
    
}

- (void) displayImage {
    _imageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"Hangman%d.gif", [newGame wrongGuess]]];
}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guessTextFieldDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)guessButtonDidTouchUpInside:(id)sender {
    NSString* input = [[_userGuess text] uppercaseString];
    
    if ([newGame validInput:input]) { //check user input
        if ([newGame makeGuess: input]) {[self guessOK];}
        else {[self guessFail];}
    }
    else {
        UIAlertView* alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"Invalid Guess!"
                              delegate:nil
                              cancelButtonTitle:@"I know"
                              otherButtonTitles: nil];
        [alert show];
        
    }
    [_userGuess setText: @""];
    
}


- (void)guessFail
{

    [self displayImage];
    if ([newGame isLost]) { // check if lost
        NSString* alertMessage = [NSString stringWithFormat:@"Correct word: %@", [newGame curWord]];
        UIAlertView* alert = [[UIAlertView alloc]
                              initWithTitle:alertMessage
                              message:@"You Lost!"
                              delegate:self
                              cancelButtonTitle:@"Play Again!"
                              otherButtonTitles: nil];
        [alert show];
        [self restGame];
        
    }
    
}

- (void)guessOK
{
    NSString* newOutput = [newGame generateOutput];
    [_currentParticalWord setText: newOutput];

    if ([newGame victory]) {
        NSString* alertMessage = [NSString stringWithFormat:@"Game ended"];
        UIAlertView* alert = [[UIAlertView alloc]
                              initWithTitle:@"Victory!"
                              message: alertMessage
                              delegate:self
                              cancelButtonTitle:@"Play Again!"
                              otherButtonTitles: nil];
        [alert show];
        [self restGame];
    }
}

- (IBAction)restGame {
    [newGame resetGame];
    [_userGuess setText:@""];
    [self viewDidLoad];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if(newLength > 1)
    //if ([textField.text length] >1)
        return NO;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


@end
