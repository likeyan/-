//
//  QFHttpServer.h
//  MediaStreamPlayAndDownload
//
//  Created by yang on 21/11/13.
//  Copyright (c) 2013 北京千锋互联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

@interface QFHttpServer : NSObject {
    HTTPServer *httpServer;
}

+ (id) sharedInstance;
- (void) startHttpService;
- (NSString *) getWebRoot;

- (NSURL *) getLocalM3U8Url:(NSURL *)realUrl;

@end
