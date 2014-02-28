//
//  GameLogic.m
//  iHW1
//
//  Created by Kevin Qi on 2/27/14.
//  Copyright (c) 2014 Kevin Qi. All rights reserved.
//

#import "GameLogic.h"

@implementation GameLogic
- (id) init
{
    self = [super init];
    if (self) {
        wordGet = [[HangmanWords alloc] init];
        [self setCurWord: [wordGet getWord]];
        expiredWords = [[NSMutableArray alloc] init];
        _wrongGuess = 0;
    }
    return self;
}

- (BOOL) validInput:(NSString *)c
{
    if ([c length] < 1)
        return NO;
    
    if (![expiredWords containsObject: c] && [[NSCharacterSet letterCharacterSet] characterIsMember:[c characterAtIndex:0]]) {
        return YES;
    }
    return NO;
    
}


- (BOOL) makeGuess:(NSString*) guess {
    //add current guess to guessed list
    [expiredWords addObject:[guess uppercaseString]];
    if ([_curWord rangeOfString:[guess uppercaseString]].location == NSNotFound) {
        _wrongGuess = _wrongGuess+1;
        return NO;
    }
    return YES;    
}

- (void) resetGame {
    [self setCurWord:[wordGet getWord]];
    [expiredWords removeAllObjects];
    _wrongGuess = 0;
}

- (BOOL) isLost
{
    if (_wrongGuess >= 14) {
        return YES;
    }
    return NO;
}


- (BOOL) victory
{
    if ([[self generateOutput] rangeOfString: @"_"].location != NSNotFound)
        return NO;
    return YES;
}

- (NSString*) generateOutput
{
    NSMutableString* output = [NSMutableString stringWithString: @""];
    for (NSInteger i = 0; i < [_curWord length]; i++) {
        NSString* c = [NSString stringWithFormat: @"%C", [_curWord characterAtIndex:i]];
        if (![c isEqual: @" "]) {
            if ([expiredWords containsObject:c]) {
                [output appendFormat:@"%@ " , c];
            }
            else {
                [output appendString: @"_ "];
            }
        }
        else {
            [output appendString: @"  "];
        }
    }
    
    return output;
}

@end
