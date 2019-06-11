//
//  FMoudleRouter.m
//  FMoudle
//
//  Created by AoChen on 2019/6/11.
//  Copyright © 2019 Ac. All rights reserved.
//

#import "FMoudleRouter.h"
#import <objc/runtime.h>

@interface FMoudleRouter()

@property (nonatomic, strong)NSCache *classMapCache;

@property (nonatomic, strong)NSMutableDictionary *moduleMapCache;

@end

@implementation FMoudleRouter

static FMoudleRouter *_router;
#pragma mark - 单例
+ (instancetype)router {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _router = [[self alloc]init];
    });
    return _router;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.classMapCache = [[NSCache alloc] init];
        self.moduleMapCache = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.classMapCache.countLimit = 50;//限制缓存的数据数目,目的是控制内存占用
        [self loadClassesConfirmToProtocol:@protocol(FMoudleProtocol)];
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_router == nil) {
            _router = [super allocWithZone:zone];
        }
    });
    return _router;
}

- (id)copyWithZone:(NSZone *)zone {
    return _router;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _router;
}

#pragma mark - Public
- (id)interfaceForProtocol:(Protocol *)protocol {
    
    Class class = [self findClassForProtocol:protocol];
    return [[class alloc]init];
}

- (id)interfaceCacheModuleForProtocol:(Protocol *)protocol
{
    NSString *key = NSStringFromProtocol(protocol);
    id instance = [self.moduleMapCache objectForKey:key];
    if (instance) {
        return instance;
    }
    Class class = [self findClassForProtocol:protocol];
    instance = [[class alloc]init];
    [self.moduleMapCache setObject:instance forKey:key];
    return instance;
}
#pragma mark - Private
- (Class<FMoudleProtocol>)findClassForProtocol:(Protocol*)protocol {
    
    NSString *key = NSStringFromProtocol(protocol);
    Class cacheClass = [self.classMapCache objectForKey:key];
    if (cacheClass) {
        //已经缓存的协议实现类
        return cacheClass;
    } else {
        //未缓存的协议实现类
        Class<FMoudleProtocol> responseClass = [self assertForMoudleWithProtocol:protocol];
        return responseClass;
    }
    return nil;
}

- (Class)classForProtocol:(Protocol *)protocol {
    
    unsigned int classCount;
    Class* classList = objc_copyClassList(&classCount);
    int i;
    Class thisClass = nil;
    for (i=0; i<classCount; i++) {
        const char *className = class_getName(classList[i]);
        Class tempClass = objc_getClass(className);
        if (class_conformsToProtocol(tempClass, protocol)) {
            thisClass = tempClass;
            break;
        }
    }
    free(classList);
    return thisClass;
}

- (Class)assertForMoudleWithProtocol:(Protocol *)p {
    
    Class thisClass = [self classForProtocol:p];
    if (!thisClass) {
        NSString *protocolName = NSStringFromProtocol(p);
        NSString *reason = [NSString stringWithFormat: @"找不到协议 %@ 对应的接口实现类", protocolName];
        NSLog(@"组件异常⚠️:%@",reason);
        return nil;
    }
    return thisClass;
}

- (void)loadClassesConfirmToProtocol:(Protocol *)protocol {
    unsigned int classCount;
    Class* classList = objc_copyClassList(&classCount);
    int i;
    for (i=0; i<classCount; i++) {
        const char *className = class_getName(classList[i]);
        Class thisClass = objc_getClass(className);
        if (class_conformsToProtocol(thisClass, protocol)) {
            const char *protocolName = protocol_getName([self protroclForClass:thisClass]);
            NSString *pn = [NSString stringWithUTF8String:protocolName];
            [self.classMapCache setObject:thisClass forKey:pn];
        }
    }
    free(classList);
}
//取实现类的协议列表的第一个协议为路由协议
- (Protocol*)protroclForClass:(Class)cs
{
    unsigned int protocalCount;
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(cs, &protocalCount);
    Protocol *myProtocal = protocolList[0];
    free(protocolList);
    return myProtocal;
}
@end
