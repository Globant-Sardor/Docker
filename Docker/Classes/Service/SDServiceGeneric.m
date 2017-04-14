//
//  ServiceGeneric.m
//  YooxNative
//
//  Created by Francesco Ceravolo on 26/06/14.
//  Copyright (c) 2014 Yoox Group. All rights reserved.
//

#import "SDServiceGeneric.h"
#import "SDDockerLogger.h"

@implementation MultipartBodyInfo

@end


@implementation SDServiceGeneric

- (NSString*) pathResource
{
    return nil;
}

- (AFHTTPRequestOperationManager*) requestOperationManager
{
    return nil;
}

- (SDHTTPMethod) requestMethodType
{
    return SDHTTPMethodGET;
}

- (NSDictionary*) parametersForRequest:(id<SDServiceGenericRequestProtocol>)request error:(NSError**)error
{
    return nil;
}

- (id<SDServiceGenericResponseProtocol>) responseForObject:(id)object error:(NSError**)error
{
    return nil;
}

- (id<SDServiceGenericErrorProtocol>) errorForObject:(id)object error:(NSError**)error
{
    return nil;
}

- (Class) responseClass
{
    return NULL;
}

- (Class) errorClass
{
    return NULL;
}

//// Parses a JSON file and retrieves the response object
//// ASYNCHRONOUS version of method
- (void) getResultFromJSONFileWithCompletion:(void (^) (id result))completion
{
    // read json from file asking at service the demo file name
    NSString* jsonFileName = NSStringFromClass([self class]);
    
    if ([self respondsToSelector:@selector(demoModeJsonFileName)])
    {
        jsonFileName = [self demoModeJsonFileName];
    }
    
    NSString* pathToFile = [[NSBundle mainBundle] pathForResource:jsonFileName ofType:@"json"];
    [self getResultFromJSONFileAtPath:pathToFile withCompletion:completion];
}

- (void) getResultFromJSONFileAtPath:(NSString*)pathToFile withCompletion:(void (^) (id result))completion
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:pathToFile])
    {
        // execution in separate thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                 (unsigned long)NULL), ^(void) {
            
            if([self respondsToSelector:@selector(demoWaitingTimeRange)])
            {
                NSRange range = [self demoWaitingTimeRange];
                float waitingTime = (arc4random_uniform(range.length*100.)/100.) + range.location;
                sleep(waitingTime);
            }
            
            NSString* jsonString = [[NSString alloc] initWithContentsOfFile:pathToFile encoding:NSUTF8StringEncoding error:NULL];
            NSError* jsonError;
            NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
            if (jsonError)
            {
                SDLogModuleError(kServiceManagerLogModuleName, @"Local file %@ doesn't contain a valid dictionary: %@", pathToFile, jsonError.localizedDescription);
                dictionary = nil;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(dictionary);
            });
        });
    }
    else
    {
        SDLogModuleError(kServiceManagerLogModuleName, @"Local file %@ doesn't exist", pathToFile);
        completion(nil);
    }
}

@end
