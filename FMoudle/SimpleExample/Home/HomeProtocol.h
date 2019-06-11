
//
//  HomeProtocol.h
//  FMoudle
//
//  Created by AoChen on 2019/6/11.
//  Copyright © 2019 Ac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMoudleProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HomeProtocol <FMoudleProtocol>

- (id)interfaceViewController;

@property (nonatomic, copy) NSString *paramterForHome;

@end

NS_ASSUME_NONNULL_END
