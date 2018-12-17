//
//  QSSelectView.m
//  MyCommunity
//
//  Created by JosQiao on 16/8/12.
//  Copyright © 2016年 WenJim. All rights reserved.
//

#import "QSForumSelectView.h"



@interface QSForumSelectView ()
{
    NSInteger _currentTag;
    
    UIButton *_lastSelectedBtn;
    
    //    UIView *_lineView;
}


/** 保存按钮 */
@property(nonatomic,strong)NSMutableArray *btnArray;

@end

@implementation QSForumSelectView

static const CGFloat kQSSelectViewLeft = 27.0f;
static const CGFloat kQSSelectViewSliderWidth = 34.0f;
static const CGFloat kQSSelectViewbtnHeigth = 28.0f;



- (void)awakeFromNib
{
    [super awakeFromNib];
    _currentTag = 0;
    [self setUpUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentTag = 0;
        
        [self setUpUI];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    BOOL isFirst = NO;
    if (self.bounds.size.width == 0.0) {
        isFirst = YES;
    }
    
    [super setFrame:frame];
    
    if (isFirst) {
        
        CGFloat btnWidth  = (self.bounds.size.width - 2 * kQSSelectViewLeft) / self.btnArray.count;
        CGFloat x  = kQSSelectViewLeft + ((btnWidth - kQSSelectViewSliderWidth) / 2.0);
        self.sliderView.frame = CGRectMake(x, self.bounds.size.height - 3.0, kQSSelectViewSliderWidth, 3);
    }
}

- (instancetype)initWithItemTitles:(NSArray<NSString *> *)titles
{
    self = [super init];
    if (self) {
        
        for (NSString *title in titles) {
            
            _currentTag ++;
            UIButton *btn =[self selectItemWithTitle:title];
            btn.tag = _currentTag;
            
            [self addSubview:btn];
            [self.btnArray addObject:btn];
            
            // 设置第一个选中的按钮
            if (_currentTag == 1) {
                btn.selected = YES;
                [self resetBtnTitleColorWithBtn:btn];
                _lastSelectedBtn = btn;
            }
        }
        
    }
    return self;
}

#pragma mark - Life cycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat left = kQSSelectViewLeft;
    CGFloat btnHeigth = kQSSelectViewbtnHeigth;
    CGFloat btnWidth  = (self.bounds.size.width - 2 * left) / self.btnArray.count;
    CGFloat btnDistance = (self.bounds.size.width - 2 * left - btnWidth * self.btnArray.count) / (self.btnArray.count - 1);
    
    for (int i = 0 ; i < self.btnArray.count; i ++) {
        
        UIView *view = self.btnArray[i];
        
        
        view.frame = CGRectMake(left + i * (btnWidth + btnDistance), (self.bounds.size.height - btnHeigth ) / 2.0, btnWidth, btnHeigth);
    }
    
    CGRect rect = self.sliderView.frame;
    rect.origin.y = self.bounds.size.height - 3;
    self.sliderView.frame = rect;
    
    
    //    _lineView.frame = CGRectMake(0, self.bounds.size.height - 1.0, KScreenWidth, 1);
    
    
    
}


- (void)slideViewAnimationWithContentOffset:(CGPoint)contentOffSet{
    
    NSInteger currentIndex = (contentOffSet.x/KScreenWidth + 0.5);
    
    
    
    UIButton *btn = [self viewWithTag:currentIndex+1];
    CGFloat btnWidth  = (self.bounds.size.width - 2 * kQSSelectViewLeft) / self.btnArray.count;
    
    
    CGFloat doubleSlideViewWidth =  btnWidth * 2 - (btnWidth - kQSSelectViewSliderWidth);
    
    
    if (btn != _lastSelectedBtn) {
        
        btn.selected = YES;
        [self resetBtnTitleColorWithBtn:btn];
        
        _lastSelectedBtn.selected = NO;
        [self resetBtnTitleColorWithBtn:_lastSelectedBtn];
        
        _lastSelectedBtn = btn;
    }
    NSInteger contentOffsetX = contentOffSet.x;
    
    
    NSLog(@"%ld",(long)contentOffsetX);
    //TODO:根据scrollView的偏移量来决定滑块的动画
    
    NSLog(@"%.2ld",contentOffsetX % 375);
    
    
    //TODO: fix
    if (contentOffsetX < 0 || contentOffsetX > (self.btnArray.count - 1) * KScreenWidth){
        //
        
        return;
        
    }
    
    
    
    //相对屏幕宽度偏移量
    CGFloat contentOffSetRatio = contentOffsetX % (NSInteger)KScreenWidth;
    
    
    
    
    //动画参照偏移量
    CGFloat halfContentOffset = KScreenWidth / 2;
    
    
    if (contentOffSetRatio < halfContentOffset) {
        //偏移量 < sw/2 滑块增加宽度
        
        //偏移比例 以屏宽/2 为准数
        CGFloat ration = contentOffSetRatio / halfContentOffset;
        NSLog(@"小于一半  按偏移比例增加滑块宽度");
        
        CGFloat x = btn.frame.origin.x + ((btnWidth - kQSSelectViewSliderWidth) / 2.0);
        
        
        CGFloat width = (doubleSlideViewWidth - kQSSelectViewSliderWidth) *ration + kQSSelectViewSliderWidth;
        
        self.sliderView.frame = CGRectMake(x, self.bounds.size.height - 12, width, 3);
        
        //        self.sliderView.width = width;
        
        
    }else{
        
        NSLog(@"超过一半  缩小宽度和x");
        
        //偏移量 > SW/ 2    宽度根据比例减小到正常 60  X变大  width减小
        
        CGFloat ration1 = (contentOffSetRatio - halfContentOffset) / halfContentOffset;
        
        CGFloat width = doubleSlideViewWidth - ((doubleSlideViewWidth - kQSSelectViewSliderWidth) *ration1);
        
        
        self.sliderView.frame = CGRectMake(btn.right - width -(btnWidth - kQSSelectViewSliderWidth) / 2.0, self.bounds.size.height - 12, width , 3);
        
    }
    
    
    
    
    
    
    
}

#pragma mark - UITableViewDelegate

#pragma mark - CustomDelegate

#pragma mark - Event response

- (void)btnSelected:(UIButton *)btn
{
    
    
    if (btn != _lastSelectedBtn) {
        
        [self selectButtonItem:btn];
        
        // 调用代理
        if (self.delegate && [self.delegate respondsToSelector:@selector(seletedItemAtIndex:)]) {
            [self.delegate seletedItemAtIndex:btn.tag - 1];
        }
    }
}


- (void)addSelectedItemWithTitle:(NSString *)title
{
    _currentTag ++;
    UIButton *btn = [self selectItemWithTitle:title];
    btn.tag = _currentTag;
    
    [self addSubview:btn];
    [self.btnArray addObject:btn];
    
    // 设置第一个选中的按钮
    if (_currentTag == 1) {
        btn.selected = YES;
        _lastSelectedBtn = btn;
    }
}

- (void)selectToItemAtIndex:(NSInteger)index
{
    UIButton *btn = [self viewWithTag:index+1];
    
    if (btn != _lastSelectedBtn) {
        
        [self selectButtonItem:btn];
    }
}

#pragma mark - private methods

- (void)selectButtonItem:(UIButton *)btn
{
    btn.selected = YES;
    [self resetBtnTitleColorWithBtn:btn];
    
    _lastSelectedBtn.selected = NO;
    [self resetBtnTitleColorWithBtn:_lastSelectedBtn];
    
    // 改变滑块的位置
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rect = self.sliderView.frame;
        CGFloat btnWidth  = (self.bounds.size.width - 2 * kQSSelectViewLeft) / self.btnArray.count;
        rect.origin.x = btn.frame.origin.x + ((btnWidth - kQSSelectViewSliderWidth) / 2.0);
        self.sliderView.frame = rect;
    }];
    
    _lastSelectedBtn = btn;
}

- (UIButton *)selectItemWithTitle:(NSString *)itemTitle
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [btn setTitle:itemTitle forState:UIControlStateNormal];
    [btn setTitleColor:MCColor(74, 74, 74, 1) forState:UIControlStateNormal];
    
    //[btn setTitleColor:THEME_COLOR forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

// 重新设置按钮标题颜色
- (void)resetBtnTitleColorWithBtn:(UIButton *)btn
{
    if (btn.isSelected) {
        [btn setTitleColor:MainColor forState:UIControlStateNormal];
    }else {
        [btn setTitleColor:HexColor(@"484848") forState:UIControlStateNormal];
    }
}

#pragma mark - SetUpUI
- (void)setUpUI{
    
    [self addSubview:self.sliderView];
    
    //    _lineView = [[UIView alloc]init];
    //
    //    _lineView.backgroundColor = MCColor(241, 241, 241, 1);
    //
    //    [self addSubview:_lineView];
    //
    
}

#pragma mark - Getter/Setter
- (UIView *)sliderView
{
    if (!_sliderView) {
        
        CGFloat btnWidth  = (self.bounds.size.width - 2 * kQSSelectViewLeft) / self.btnArray.count;
        CGFloat x  = kQSSelectViewLeft + (btnWidth - kQSSelectViewSliderWidth) / 2.0;
        _sliderView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, kQSSelectViewSliderWidth, 3)];
        _sliderView.backgroundColor = MainColor; // THEME_COLOR;
        _sliderView.layer.cornerRadius = 1.8;
    }
    return _sliderView;
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

@end

