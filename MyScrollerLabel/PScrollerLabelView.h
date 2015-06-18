//
//  PScrollerLabelView.h
//  
//
//  Created by crazypoo on 15/6/18.
//
//

#import <UIKit/UIKit.h>

@interface PScrollerLabelView : UIScrollView

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIColor *PTextColor;
@property (nonatomic, retain) UIColor *PBackgroundColor;
@property (nonatomic, retain) UIFont *PFont;
@property (nonatomic, retain) NSString *PText;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@end
