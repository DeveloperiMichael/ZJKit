//
//  ZJRefresh.h
//  ZJKit
//
//  Created by 张炯 on 2018/6/1.
//

#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>


@interface ZJRefresh : NSObject

+ (MJRefreshHeader *)zj_headerWithRefreshingBlock:(void (^)(void))refreshingBlock;

+ (MJRefreshFooter *)zj_footerWithRefreshingBlock:(void (^)(void))refreshingBlock;


/**
 分页加载数据  对footer header状态的设置
 
 @param scrollView tableView 或者 collectionView
 @param totalDataCount 总数据量
 @param currentDataCount 当前已请求到的数据量
 */
+ (void)zj_scrollView:(UIScrollView *)scrollView
header_footerStateWithTotalDataCount:(NSInteger)totalDataCount
     currentDataCount:(NSInteger)currentDataCount;


@end
