
#import <UIKit/UIKit.h>
//#import "BoxAccessoriesModel.h"
@interface AutoScrollCell : UITableViewCell

+(CGFloat)cellHeightWithModel:(id)model;
+(instancetype)cellWith:(UITableView*)tableView;
- (void)richElementsInCellWithModel:(id)model;
@end
