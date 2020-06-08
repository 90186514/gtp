//
//  DraggableCVModel.h

#import <Foundation/Foundation.h>

@interface DraggableCVModel : NSObject
- (BOOL)compareOriginData:(NSMutableArray*)oldArr withNewData:(NSMutableArray*)newArr;
- (NSMutableDictionary*)getMazeDatasByX:(NSInteger)x byY:(NSInteger)y;
- (void)setDataIsForceInit:(BOOL)isForceInit;

@end
