//
//  IDRandusService.h
//  objc.shoploan
//
//  Created by Андрей Бронников on 05.09.2018.
//  Copyright © 2018 sovcombank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDRandusPersonObject.h"

@interface IDRandusService : NSObject

+ (void)getRandomPersonWithCompletionBlock: (void (^)(IDRandusPersonObject *person))completionBlock
                                errorBlock: (void (^)(NSError *error))errorBlock;

@end
