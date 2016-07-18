//
//  ViewController.m
//  imgBig
//
//  Created by  lichen on 16/5/12.
//  Copyright © 2016年  lichen. All rights reserved.
//

#import "ViewController.h"

#define SCREEN ([UIScreen mainScreen].bounds.size)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UIImageView *topView;
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *vi;
@property (strong,nonatomic)UIImageView *img;
@property (strong,nonatomic)UIVisualEffectView *effectView;

@end

#define  ZYT ([UIScreen mainScreen].bounds.size.height / 3)

const CGFloat ZYTopViewH = 350;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)initView
{
    self.tableView.contentInset = UIEdgeInsetsMake(ZYTopViewH * 0.5, 0, 0, 0);
    UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing5.jpg"]];
    topView.frame = CGRectMake(0, -ZYTopViewH, SCREEN.width, ZYTopViewH);
    
    topView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.tableView insertSubview:topView atIndex:0];
    
    self.topView = topView;
    
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN.width-120, self.topView.frame.size.height - 40, 80, 80)];
    _img.image = [UIImage imageNamed:@"top"];
    _img.layer.cornerRadius = 40.0f;
    _img.layer.masksToBounds = YES;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgAction:)];
    [_img addGestureRecognizer:tap];
    
    [self.topView addSubview:_img];
    
    
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //  毛玻璃view 视图
    _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    _effectView.frame = self.topView.bounds;
    
    [self.topView addSubview:_effectView];
    //设置模糊透明度
    _effectView.alpha = 0.0f;
    
    [self.view addSubview:self.tableView];

}

- (void)imgAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"1212121");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test---%zd",indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"%f",offsetY);
    
    CGFloat offsetH = -ZYTopViewH * 0.5 - offsetY;
    
    if (offsetH < 0) return;
    
    CGRect frame = self.topView.frame;
    frame.size.height = ZYTopViewH + offsetH;
    self.topView.frame = frame;
    CGRect imgF = _img.frame;
//    CGPoint cen = _img.center;
    imgF.size.height = 80 + offsetH;
    imgF.size.width = 80 + offsetH;
    _img.frame = imgF;
//    _img.center = cen;
    _img.layer.cornerRadius = imgF.size.height/2;
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
