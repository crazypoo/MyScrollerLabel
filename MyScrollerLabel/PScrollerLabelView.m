//
//  PScrollerLabelView.m
//  
//
//  Created by crazypoo on 15/6/18.
//
//

#import "PScrollerLabelView.h"

@interface PScrollerLabelView ()
{
    int timeCount;
}
@end

@implementation PScrollerLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"PText" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"PTextColor" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"PBackgroundColor" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"PFont" options:NSKeyValueObservingOptionNew context:nil];
        self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        self.textLabel.font = [UIFont systemFontOfSize:14.0f];
        self.textLabel.textColor = [UIColor blackColor];
        [self addSubview:self.textLabel];
        
        timeCount = 0;
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"PText"])
    {
        NSString *labelTitle = [[change objectForKey:@"new"] isEqual:[NSNull null]] ? @"" : [change objectForKey:@"new"];
        CGSize textLabelSize = CGSizeZero;
        if (labelTitle && [labelTitle length])
        {
            textLabelSize = [labelTitle sizeWithAttributes:@{NSFontAttributeName:self.textLabel.font}];
        }
        self.textLabel.text = labelTitle;
        CGRect frame = self.textLabel.frame;
        CGSize newSize = CGSizeMake(textLabelSize.width, frame.size.height);
        frame.size = newSize;
        self.textLabel.frame = frame;
        [self setContentSize:textLabelSize];
    }
    else if ([keyPath isEqualToString:@"PTextColor"])
    {
        UIColor *color = [[change objectForKey:@"new"] isEqual:[NSNull null]] ? nil : [change objectForKey:@"new"];
        self.textLabel.textColor = color;
    }
    else if ([keyPath isEqualToString:@"PBackgroundColor"])
    {
        UIColor *backgroundColor = [[change objectForKey:@"new"] isEqual:[NSNull null]] ? nil : [change objectForKey:@"new"];
        [self setBackgroundColor:backgroundColor];
    }
    else if ([keyPath isEqualToString:@"PFont"])
    {
        UIFont *font = [[change objectForKey:@"new"] isEqual:[NSNull null]] ? nil : [change objectForKey:@"new"];
        self.textLabel.font = font;
    }
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    self.textLabel.textAlignment = textAlignment;
}

-(void)scrollTimer{
    timeCount ++;
    if (timeCount > self.textLabel.frame.size.width/self.frame.size.width) {
        timeCount = 0;
    }
    [self scrollRectToVisible:CGRectMake(timeCount *self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height) animated:YES];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"PText"];
    [self removeObserver:self forKeyPath:@"PTextColor"];
    [self removeObserver:self forKeyPath:@"PBackgroundColor"];
    [self removeObserver:self forKeyPath:@"PFont"];
    
    self.textLabel = nil;
    self.PText = nil;
    self.PTextColor = nil;
    self.backgroundColor = nil;
    self.PFont = nil;
}
@end
