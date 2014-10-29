//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by Isabel Gomez on 10/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
    
    CCNode *_levelNode;
}

-(void)didLoadFromCCB{
    self.userInteractionEnabled = TRUE;
    CCScene *level = [CCBReader load:@"Levels/Level1"];
    [_levelNode addChild:level];
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    [self launchPenguin];
}

-(void)launchPenguin{
    //load penguin ccb from spritebuilder
    CCNode* penguin = [CCBReader load:@"Penguin"];
    
    //position pengiun at bowl of catapult
    penguin.position = ccpAdd(_catapultArm.position, ccp(16, 50));
    
    //add penguin to physics Node
    [_physicsNode addChild:penguin];
    
    //manually create and apply force to launch penguin
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
    
    // ensure followed object is in visible are when starting
    self.position = ccp(0, 0);
    CCActionFollow *follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [self runAction:follow];
}

@end
