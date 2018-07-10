//
//  ZJRefresh.m
//  ZJKit
//
//  Created by 张炯 on 2018/6/1.
//

#import "ZJRefresh.h"
#import "ZJFont.h"
#import "ZJColor.h"
#import "ZJKitConstant.h"

static NSInteger kZJRequestSize = 20;
static NSInteger kZJShowFooterStandardDataCount = 10;

@implementation ZJRefresh

+ (MJRefreshHeader *)sa_headerWithRefreshingBlock:(void (^)(void))refreshingBlock {
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        if (refreshingBlock) {
            refreshingBlock();
        }
    }];
    
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:0];
    for (int i = 1; i < 13; i ++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i]];
        [arrayM addObject:image];
    }
    
    // 设置普通状态下的动画图片  -->  静止的一张图片
    NSArray * normalImagesArray = @[[UIImage imageNamed:@"loading1"]];
    [header setImages:normalImagesArray forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片
    [header setImages:normalImagesArray forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:arrayM duration:0.5 forState:MJRefreshStateRefreshing];
    
    header.automaticallyChangeAlpha = YES;
    
    /** 设置state状态下的文字 */
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [ZJFont zj_font24px:ZJFontTypeBold];
    header.stateLabel.textColor = [ZJColor zj_colorC7];
    //隐藏刷新日期
    header.lastUpdatedTimeLabel.hidden = YES;
    return header;
}

+ (MJRefreshFooter *)sa_footerWithRefreshingBlock:(void (^)(void))refreshingBlock {
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        if (refreshingBlock) {
            refreshingBlock();
        }
    }];
    [footer setTitle:@"加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"暂时没有更多数据了~" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [ZJFont zj_font24px:ZJFontTypeBold];
    footer.stateLabel.textColor = [ZJColor zj_colorC7];
    footer.triggerAutomaticallyRefreshPercent = 0.4f;
    footer.automaticallyChangeAlpha = YES;
    return footer;
}


+ (void)sa_scrollView:(UIScrollView *)scrollView
header_footerStateWithTotalDataCount:(NSInteger)totalDataCount
     currentDataCount:(NSInteger)currentDataCount {
    if (totalDataCount<=kZJShowFooterStandardDataCount) {
        scrollView.mj_footer.alpha = 0.0;
        scrollView.mj_insetB = 10*kScreenWidthRatio();
    } else if (totalDataCount>kZJShowFooterStandardDataCount) {
        scrollView.mj_footer.alpha = 1.0;
        scrollView.mj_insetB = MJRefreshFooterHeight;
    }
    
    if ([scrollView.mj_header isRefreshing]) {
        [scrollView.mj_header endRefreshing];
    }
    
    if (totalDataCount==currentDataCount) {
        [scrollView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [scrollView.mj_footer resetNoMoreData];
    }
    
}



@end
