//
//  imageViewController.m
//  BlueToothAbout
//
/**
 https://static.zihe8888.com/Files/Product/20180611/undefined/3c00f8a9a3244630abb2a6f3cf6c0d6b.jpg,
 https://static.zihe8888.com/Files/Product/20180611/undefined/7f45caad39304f5b8b93f65aa0f155c5.jpg,
 https://static.zihe8888.com/Files/Product/20180611/undefined/dc476f843c1f4287ab305a56584e7579.jpg,
 https://static.zihe8888.com/Files/Product/20180611/undefined/8cf31ec6fa8f4e4fb190a0eeb8df873f.jpg,
 https://static.zihe8888.com/Files/Product/20180611/undefined/2116edccc3f34bbeacb2b85fa261033e.jpg,
 https://static.zihe8888.com/Files/Product/20180611/undefined/a5b495c89b5c46ab8888bfa46f40cca4.jpg,
 https://static.zihe8888.com/Files/Product/20180611/undefined/6f4bbd2dcba64303876b6598e0a2e54b.jpg,
 https://static.zihe8888.com/Files/Product/20180611/undefined/0dda58c0fd7c4ffab88380401ba797a3.jpg,
 https://static.zihe8888.com/Files/Product/20180611/undefined/d1fc0b1d523f4592b10f3c6ad51f2563.jpg
 
 https://static.zihe8888.com/Files/Product/20180608/undefined/dbe3ed5bc74a4949aec48e546b20d797.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2191/5dda367215c54bbd813dc827f1cb5f50.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2191/2b92440fefb54d1fb124d9ed0d24baaa.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2191/34e8f4e913b34de8bc3c8c16c2a8ac19.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2191/64bae2a7a7814bb580a2052c3a335412.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2191/cab7576ca30a4a738207e9a2821c6fa6.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2191/7b9d2f8496b94d13baa788be46d720a0.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2191/02b452abf3784db89a8e164d162a5580.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2191/fb69fdfbf1fa495ba7d4cb0acab598a7.jpg
 
 https://static.zihe8888.com/Files/Product/20180608/undefined/61b5e116cb9b4b43ba738e9d94c1920a.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2193/aa582dc1062c4e978bb5b58b79f9f64b.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2193/1d4663c0b4ce4c8a8ad3e12ff07a6226.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2193/de6a40b7a8f74d16b1dfa5c4feab1971.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2193/2fbbcd632cd246cb84207a86b473b418.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2193/8613b712e46a499899b1f02d8c7d6245.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2193/126f6c2e24a44a639f3caa9249845694.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2193/910978b790d5464eafae193a86f97ac1.jpg,
 https://static.zihe8888.com/Files/Product/20180608/2193/1c36f8e9752f4fe3992879f0fa3da763.jpg
 
 */

//  Created by 知合金服-Mini on 2018/6/13.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "imageViewController.h"
#import "ImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageDownloaderOperation.h>
//#import <UIImageView+WebCache.h>
#import "LetterIndexView.h"
#import <ImageIO/ImageIO.h>
#import "PopItemView.h"
#import "BoomBoomBoomView.h"
#import "ListModel.h"
typedef void(^runloopBlock)(void);

typedef void(^imageBlock)(UIImageView *imageView);
@interface imageViewController ()<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
@property(strong,nonatomic)NSMutableArray *tasks;
@property (nonatomic, assign) NSInteger maxQueueLength;

@property(strong,nonatomic)UITableView *table;
@property(strong,nonatomic)NSArray *dataArr;

@end

static BOOL SDImageCacheOldShouldDecompressImages = YES;
static BOOL SDImagedownloderOldShouldDecompressImages = YES;

@implementation imageViewController

- (void)runrunrun
{
    NSLog(@"runrunrun");
}

-(void)loadView
{
    [super loadView];
    NSLog(@"loadView");
    SDImageCache *canche = [SDImageCache sharedImageCache];
    canche.config.shouldCacheImagesInMemory = NO;
    SDImageCacheOldShouldDecompressImages = canche.config.shouldDecompressImages;
    canche.config.shouldDecompressImages = NO;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.maxQueueLength = 5;
//    self.tasks = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Property List.plist" ofType:nil];
    self.dataArr =[NSArray arrayWithContentsOfFile:path];
//    [self addRunloop];
//    [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(runrunrun) userInfo:nil repeats:YES];
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    
    [self.view addSubview:self.table];

//    LetterIndexView * indexV = [[LetterIndexView alloc] initWithFrame:CGRectMake(ScreenWidth-20, 64, 20, ScreenHeight-64) Count:nil];
//    indexV.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:indexV];
//
//    PopItemView *pop = [[PopItemView alloc] initWithFrame:CGRectMake(0, 80, 355, 400)];
//    pop.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:pop];
//    
//    BoomBoomBoomView *boom = [[BoomBoomBoomView alloc] initWithFrame:CGRectMake(20, 500, 100, 100)];
//    boom.backgroundColor = [UIColor clearColor];
//    [boom animate:YES];
//    [self.view addSubview:boom];

    
//    [self caAuthent];
//    [self imageInfo:nil];
    
}
-(void)dealloc
{
    SDImageCache *canche = [SDImageCache sharedImageCache];
    canche.config.shouldDecompressImages = SDImageCacheOldShouldDecompressImages;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    downloder.shouldDecompressImages = SDImagedownloderOldShouldDecompressImages;
}

- (void)imageInfo:(UIImageView *)infoIm{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
////        NSURL *url = [NSURL URLWithString:@"https://static.zihe8888.com/Files/Product/20180611/undefined/3c00f8a9a3244630abb2a6f3cf6c0d6b.jpg"];
//        NSString * path = [[NSBundle mainBundle] pathForResource:@"Simulator Screen Shot - iPhone 8 - 2018-07-25 at 18.02.27" ofType:@"png"];
//
//        NSURL *url = [NSURL fileURLWithPath:path];
//
//        CGImageRef infoImage = NULL;
//        CGImageSourceRef infoSource;
//
//        infoSource = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
//        infoImage = CGImageSourceCreateImageAtIndex(infoSource, 0, NULL);
////        infoImage = CGImageSourceCreateThumbnailAtIndex(infoSource, 0, NULL);
//        NSDictionary *infoDic = (__bridge NSDictionary *) CGImageSourceCopyPropertiesAtIndex(infoSource, 0, NULL);
//        NSDictionary *infoDic1 = (__bridge NSDictionary *)CGImageSourceCopyProperties(infoSource, NULL);
//        NSLog(@"infoDic1:%@\n infoDic:%@",infoDic1,infoDic);
//
//        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//
//                                 [NSNumber numberWithBool:NO], (NSString *)kCGImageSourceShouldCache,
//
//                                 nil];
//
//        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(infoSource, 0, (__bridge CFDictionaryRef)options);
////        CFDictionaryRef imageProperties = CGImageSourceCopyProperties(infoSource, (__bridge CFDictionaryRef)options);
//
//        NSLog(@"%@",imageProperties);
////
//        CFRelease(infoSource);
//
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            infoIm.image = [UIImage imageWithCGImage:infoImage];
//        });
//    });
//
}



- (void)caAuthent{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task =  [session dataTaskWithURL:[NSURL URLWithString:@"https://static.zihe8888.com/Files/Product/20180611/undefined/3c00f8a9a3244630abb2a6f3cf6c0d6b.jpg"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    NSLog(@"调用了最外层");
    // 1.判断服务器返回的证书类型, 是否是服务器信任
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSLog(@"调用了里面这一层是服务器信任的证书");
        /*
         NSURLSessionAuthChallengeUseCredential = 0,                     使用证书
         NSURLSessionAuthChallengePerformDefaultHandling = 1,            忽略证书(默认的处理方式)
         NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2,     忽略书证, 并取消这次请求
         NSURLSessionAuthChallengeRejectProtectionSpace = 3,            拒绝当前这一次, 下一次再询问
         */
        //        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential , card);
    }
}


- (void)downloadImage:(UIImageView *)imageView
{
    
//    AFHTTPSessionManager*session = [AFHTTPSessionManager manager];
//    session.requestSerializer= [AFHTTPRequestSerializer serializer];
//    session.responseSerializer= [AFHTTPResponseSerializer serializer];
//
//    NSURLRequest*request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://static.zihe8888.com/Files/Product/20180608/2193/1c36f8e9752f4fe3992879f0fa3da763.jpg"]];
//
//
//
//    NSURLSessionDownloadTask*download = [session downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        NSLog(@"targetPath:%@",targetPath);
//        NSString *filePathfinal = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:response.suggestedFilename];
//        NSFileManager*fileManager = [NSFileManager defaultManager];
//        BOOL isFile = [fileManager fileExistsAtPath:filePathfinal];
//        if (!isFile) {
//            BOOL success = [fileManager moveItemAtURL:targetPath toURL:[NSURL fileURLWithPath:filePathfinal] error:nil];
//            if (success) {
//                NSLog(@"succ");
//            }else{
//                NSLog(@"fail");
//            }
//        }else{
//            NSLog(@"已存在");
//        }
//        return targetPath;
////        return[targetPath URLByAppendingPathComponent:[response suggestedFilename]isDirectory:NO];
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        NSLog(@"response:%@,filePath:%@,error%@",response,filePath,error.localizedDescription);
//
//        //判断目录里面是否存在这个图片
//        NSFileManager*fileManager = [NSFileManager defaultManager];
//        NSString *filePathfinal = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:response.suggestedFilename];
//
//        BOOL isFile = [fileManager fileExistsAtPath:filePathfinal];
//        if (isFile) {
//            //更新界面需要使用主线程
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置图片视图的的图片
//                imageView.image = [UIImage imageWithContentsOfFile:filePathfinal];
//                [self.table reloadData];
//            });
//        }
//    }];
//
//    [download resume];
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://static.zihe8888.com/Files/Product/20180608/2193/1c36f8e9752f4fe3992879f0fa3da763.jpg"]];
////
//    NSURLSessionDownloadTask *task =[[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//
//        NSLog(@"%lf",downloadProgress.completedUnitCount/downloadProgress.totalUnitCount * 1.0);
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        //下载地址
//        NSLog(@"默认下载地址:%@",targetPath);
//
//        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
//        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//
//        return [NSURL fileURLWithPath:filePath];
//
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        NSString *filePathfinal = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSFileManager *manager = [NSFileManager defaultManager];
//        NSError *errorrr;
//        [manager moveItemAtPath:filePath.absoluteString toPath:filePathfinal error:&errorrr];
//        if (error) {
//            NSLog(@"errorrr:%@",errorrr.localizedDescription);
//        }
//        NSLog(@"下载完成：");
//        NSLog(@"%@--%@",response,filePath);
//    }];
//    [task resume];
}

//- (UIImage *)ScaleImage:(UIImage *)image size:(CGSize )size
//{
//    UIImage *NewImage = image;
//    NSData *data = UIImageJPEGRepresentation(image, 1);
//    if (data.length > 1024*1024) {
//        UIGraphicsBeginImageContextWithOptions(size, YES, 1);
//        [NewImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//        UIGraphicsEndImageContext();
//    }
//    return NewImage;
//}

//- (void)downDataImage:(UIImage *)image
//{
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://static.zihe8888.com/Files/Product/20180608/2193/1c36f8e9752f4fe3992879f0fa3da763.jpg"]];
//
//    CGBitmapInfo bitInfo = CGImageGetBitmapInfo(image.CGImage);
//    size_t bitsPerComponent = CGImageGetBitsPerComponent(image.CGImage);
//    // CGImageGetBytesPerRow() calculates incorrectly in iOS 5.0, so defer to CGBitmapContextCreate
//    size_t bytesPerRow = 0;
//
////    CGContextRef context = CGBitmapContextCreate(NULL, ScreenWidth, 200, bitsPerComponent, bytesPerRow, <#CGColorSpaceRef  _Nullable space#>, <#uint32_t bitmapInfo#>)
//}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        static NSString *cellId = @"cellId";
        ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[ImageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        }
//        NSInteger index =  self.dataArr.count[indexPath.row];
    
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                cell.cellImageView.image = [UIImage imageWithData:data];
//            });
//        });
     NSString *url = self.dataArr[indexPath.row ];
    [cell configImageWithUrl:url];
        @autoreleasepool{
//            NSString *url = self.dataArr[indexPath.row ];
//            [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"head"]];
//            [self downloadImage:cell.cellImageView];
            

        }
    
//        [self addTask:indexPath block:^{
//
//
//
////            [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"head"]];
//        }];
//        [self addTask:^{
    
//            [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageProgressiveDownload];
            
//            [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//            }];
//
//        }];
    
        return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark - cfRunloop
//- (void)addRunloop{
//    CFRunLoopRef runloop = CFRunLoopGetCurrent();
//
//    //创建观察者
//    static CFRunLoopObserverRef myObserver;
//
//    CFRunLoopObserverContext context = {
//        0,
//        (__bridge void *)self,
//        &CFRetain,
//        &CFRelease,
//        NULL
//    };
//
//    myObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callBack, &context);
//
//    //添加观察
//    CFRunLoopAddObserver(runloop, myObserver, kCFRunLoopCommonModes);
//
//    CFRelease(myObserver);
//}
//
//static void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
//
//    imageViewController *vc = (__bridge imageViewController *)info;
//    if (vc.tasks.count == 0) {
//        return;
//    }
//    runloopBlock block = vc.tasks.firstObject;
//    block();
//    [vc.tasks removeObjectAtIndex:0];
//
//}
//
//
//- (void)addTask:(NSIndexPath *)path block:(runloopBlock)task{
//    [self.tasks addObject:task];
//    if (self.tasks.count > self.maxQueueLength) {
//        [self.tasks removeObjectAtIndex:0];
////        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:path.row - self.maxQueueLength inSection:path.section];
////        ImageCell *cell = [self.table cellForRowAtIndexPath:indexpath];
////        [cell.imageView sd_cancelCurrentAnimationImagesLoad];
//    }
//}


@end
