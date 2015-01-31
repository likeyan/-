//
//  RootViewController.m
//  MediaStreamPlayAndDownload
//
//  Created by yang on 21/11/13.
//  Copyright (c) 2013 北京千锋互联科技有限公司. All rights reserved.
//

#import "RootViewController.h"
#import "NSString+Hashing.h"
#import "QFHttpServer.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playButton.frame = CGRectMake(100, 100, 100, 40);
    [playButton setTitle:@"播放视频" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
}

- (void) playVideo:(id)arg {
    // 这是一个真正的服务器的网址.
    NSString *m3u8String = @"http://pchlsws3.imgo.tv/e4f08a535ff2dda33914924062abaf4a/54c9d8bb/c1/2014/dianshiju/wumeiniangchuanqi/2015012812a7177e-f84f-4e0f-bf71-4ac9db6d1822.fhv/playlist.m3u8";
    NSURL *m3u8Url = [NSURL URLWithString:m3u8String];

    // 1. http://192.168.88.10/html/ms/friends/0101/0101.m3u8-->md5 (A4CB20C4C3BCDE1834DFA408EAF75749)
    // 2. 在sandbox/Documents/Web/A4CB20C4C3BCDE1834DFA408EAF75749/0101.m3u8
    // localM3U8Url是一个本地的视频网址
    // getLocalM3U8Url把一个真正的网址转化成iOS内部的一个网址
    NSURL *localM3U8Url = [[QFHttpServer sharedInstance] getLocalM3U8Url:m3u8Url];
    NSLog(@"real is %@", localM3U8Url);
    // real is http://127.0.0.1:12345/A4CB20C4C3BCDE1834DFA408EAF75749/0101.m3u8
    
    MPMoviePlayerViewController *mpc = [[MPMoviePlayerViewController alloc] initWithContentURL:localM3U8Url];
    [self presentViewController:mpc animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
