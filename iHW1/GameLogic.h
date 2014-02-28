//
//  GameLogic.h
//  iHW1
//
//  Created by Kevin Qi on 2/27/14.
//  Copyright (c) 2014 Kevin Qi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HangmanWords.h"

@interface GameLogic : NSObject {
    HangmanWords *wordGet;
    NSMutableArray *expiredWords;
}

@property NSString* curWord;
@property NSInteger wrongGuess;

- (BOOL) validInput:(NSString*) inp;
- (BOOL) makeGuess:(NSString*) guess;
- (NSString*) generateOutput;
- (BOOL) isLost;
- (BOOL) victory;
- (void) resetGame;


@end
