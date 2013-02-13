//
//  queue.h
//  Wicked Calc
//
//  Created by Evan Hsu on 2/11/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface queue : NSObject{
    NSMutableArray *queue_array;
}

- (void) push: (id) element;
//push an element onto queue

- (id) pop;
//popping or deleting element off the front
//of the queue and returning that value

- (id) front;
//Returns the object at the front of the queue

- (id) back;
//returns the object at the back of the queue

- (void) clearQueue;
//empties the queue, resetting the size to 0

- (NSMutableArray*) values;
//returns an array of the objects in the Queue

- (BOOL) empty;
//Tests whether or not the queue is empty

- (int) size;
//Returns the total size of the queue

- (id) index: (NSUInteger*) at;

@end
