//
//  MeProtocol.h
//  FMoudle
//
//  Created by AoChen on 2019/6/11.
//  Copyright © 2019 Ac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMoudleProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MeProtocol <FMoudleProtocol>

- (void)presentHomeViewController:(UIViewController*)vc;

- (id)interfaceViewController;

@end

NS_ASSUME_NONNULL_END
