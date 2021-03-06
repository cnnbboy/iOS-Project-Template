
#import "MBRefreshFooterView.h"
#import "UIView+RFAnimate.h"

@implementation MBRefreshFooterView

- (void)awakeFromNib {
    [super awakeFromNib];

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.empty = NO;
}

- (void)setEmpty:(BOOL)empty {
    _empty = empty;
    self.backgroundImageView.hidden = !empty;
    self.emptyLabel.hidden = !empty;
    self.textLabel.hidden = empty;
    self.endLabel.hidden = empty;
}

- (void)updateStatus:(RFPullToFetchIndicatorStatus)status distance:(CGFloat)distance control:(RFTableViewPullToFetchPlugin *)control {

    if (self.empty) return;

    UILabel *label = self.textLabel;

    // 到底部了
    if (status == RFPullToFetchIndicatorStatusFrozen) {
        self.endLabel.hidden = NO;
        label.hidden = YES;
        return;
    }

    self.endLabel.hidden = YES;
    label.hidden = NO;
    switch (status) {
        case RFPullToFetchIndicatorStatusProcessing:
            label.text = @"正在加载...";
            return;

        case RFPullToFetchIndicatorStatusDragging: {
            BOOL isCompleteVisible = !!(distance >= self.height);
            label.text = isCompleteVisible? @"释放加载更多" : @"继续上拉以加载更多";

            return;
        }
        case RFPullToFetchIndicatorStatusDecelerating:
            label.text = @"上拉加载更多";
            return;

        default:
            break;
    }
}

@end
