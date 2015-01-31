//
//  QFHttpServer.m
//  MediaStreamPlayAndDownload
//
//  Created by yang on 21/11/13.
//  Copyright (c) 2013 北京千锋互联科技有限公司. All rights reserved.
//

#import "QFHttpServer.h"
#import "NSString+Hashing.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation QFHttpServer

+ (id) sharedInstance {
    static id _s;
    if (_s == nil) {
        _s = [[[self class] alloc] init];
    }
    return _s;
}

- (NSString *) getWebRoot {
    NSString *webPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Web"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:webPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:webPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return webPath;
}

- (void) startHttpService {
    // Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	// Create server using our custom MyHTTPServer class
	httpServer = [[HTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
	[httpServer setPort:12345];
	
	// Serve files from our embedded Web folder
//	NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    NSString *webPath = [self getWebRoot];
	DDLogInfo(@"Setting document root: %@", webPath);
	
    // 设置http server主目录
	[httpServer setDocumentRoot:webPath];
	
	// Start the server (and check for problems)
	
	NSError *error;
	if([httpServer start:&error])
	{
		DDLogInfo(@"Started HTTP Server on port %hu", [httpServer listeningPort]);
	}
	else
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
	

}

- (NSURL *) getLocalM3U8Url:(NSURL *)realUrl {
    //     realUrl = @"http://192.168.88.10/html/ms/friends/0101/0101.m3u8";

    // m3u8File = 0101.m3u8
    NSString *m3u8File = [realUrl.absoluteString lastPathComponent];
    // m3u8Dir = A4CB20C4C3BCDE1834DFA408EAF75749
    NSString *m3u8Dir = [realUrl.absoluteString MD5Hash];
    // m3u8Content 就是取得服务器上m3u8文件的全部内容
    NSString *m3u8Content = [NSString stringWithContentsOfURL:realUrl encoding:NSUTF8StringEncoding error:nil];
    
    // webRoot = /Users/yang/Library/Application Support/iPhone Simulator/6.1/Applications/426D37A7-67CF-48A4-A660-0A59545255F1/Documents/Web
    // 取得CocoaHttpServer服务器的根目录
    NSString *webRoot = [self getWebRoot];
    // m3u8WebDir = /Users/yang/Library/Application Support/iPhone Simulator/6.1/Applications/426D37A7-67CF-48A4-A660-0A59545255F1/Documents/Web/A4CB20C4C3BCDE1834DFA408EAF75749
    // 创建一个视频文件夹
    NSString *m3u8WebDir = [webRoot stringByAppendingPathComponent:m3u8Dir];
    if (![[NSFileManager defaultManager] fileExistsAtPath:m3u8WebDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:m3u8WebDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"m3u8WebDir is %@", m3u8WebDir);
    // m3u8WebFile= /Users/yang/Library/Application Support/iPhone Simulator/6.1/Applications/426D37A7-67CF-48A4-A660-0A59545255F1/Documents/Web/A4CB20C4C3BCDE1834DFA408EAF75749/0101.m3u8
    NSString *m3u8WebFile = [m3u8WebDir stringByAppendingPathComponent:m3u8File];
    // 
    [m3u8Content writeToFile:m3u8WebFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    // http://127.0.0.1:12345/A4CB20C4C3BCDE1834DFA408EAF75749/0101.m3u8
    NSString *newUrlString = [NSString stringWithFormat:@"http://127.0.0.1:12345/%@/%@", m3u8Dir, m3u8File];
    // 127.0.0.1就是本地ip

    // 设置真正的网址和存放的地方
    [httpServer setRealM3U8Url:realUrl withLocalDir:m3u8WebDir];
    return [NSURL URLWithString:newUrlString];
}

@end
