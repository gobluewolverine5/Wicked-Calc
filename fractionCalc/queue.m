//
//  queue.m
//  Wicked Calc
//
//  Created by Evan Hsu on 2/11/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import "queue.h"

@implementation queue

- (id) init
{
    if(self = [super init])
	{
		queue_array = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) push:(id)element
{
    [queue_array addObject:element];
}

- (id) pop
{
    id value = [queue_array objectAtIndex:0];
    [queue_array removeObjectAtIndex:0];
    return value;
}

- (id) front
{
    return [queue_array objectAtIndex:0];
}

- (id) back
{
    return [queue_array objectAtIndex:queue_array.count - 1];
}

- (void) clearQueue
{
    [queue_array removeAllObjects];
}

- (NSMutableArray*) values
{
    return queue_array;
}

- (BOOL) empty
{
    return (queue_array.count == 0);
}

- (int) size
{
    return queue_array.count;
}

- (id) index:(NSIndexPath*)at
{
    return [queue_array objectAtIndex:at];
}

@end
