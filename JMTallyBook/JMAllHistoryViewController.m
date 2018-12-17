//
//  JMAllHistoryViewController.m
//  JMTallyBook
//
//  Created by JM on 16/3/11.
//  Copyright © 2016年 JM. All rights reserved.
//

#import "JMAllHistoryViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Account.h"
#import "JMAllHistoryTableViewCell.h"
#import "JMMonthHIstoryViewController.h"

@interface JMAllHistoryViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *totoalIncomeLabel;

@property (weak, nonatomic) IBOutlet UILabel *totoalCostLabel;


@property (weak, nonatomic) IBOutlet UILabel *remainMoneyLabel;

@property (weak, nonatomic) IBOutlet UITableView *monthTableView;

@property (strong, nonatomic) NSArray *dataArray; // 储存fetch来的所有Account

@property (strong, nonatomic) NSMutableArray *monthIncome; // 每个月的收入金额

@property (strong, nonatomic) NSMutableArray *monthExpense; // 每个月的支出金额

@property (assign, nonatomic) double totalIncome; // 总收入

@property (assign, nonatomic) double totalExpense; // 总支出

@property (strong, nonatomic) NSMutableArray *uniqueDateArray; // 储存不重复月份的数组

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation JMAllHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.monthTableView.dataSource = self;
    self.monthTableView.tableFooterView = [UIView new];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    // 数组的初始化
    self.monthIncome = [NSMutableArray array];
    self.monthExpense = [NSMutableArray array];
    
    [self judgeFirstLoadThisView];
}

- (void)judgeFirstLoadThisView {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (![defaults boolForKey:@"haveLoadedJMAllHistoryViewController"]) {
        // 第一次进入此页面
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"教程" message:@"首页显示所有月份的账单总额，点击相应月份查看该月份所有天数的详细内容，手指左滑可删除相应行的记录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"知道了，不再提醒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [defaults setBool:YES forKey:@"haveLoadedJMAllHistoryViewController"];
        }];
        
        [alert addAction:actionOK];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchData];
    
    [self filterUniqueDate];
    
    [self calculateMonthsMoney];
    
    [self setTotalLabel];
    
    [self.monthTableView reloadData];
}

- (void)fetchData {
    // 得到所有account
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
    
    NSError *error = nil;
    self.dataArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:request error:&error]];
}

- (void)filterUniqueDate {
    NSMutableArray *dateArray = [NSMutableArray array];
    
    // 将月份组成一个数组
    for (Account *account in self.dataArray) {
        // 取前7位的年和月份
        [dateArray addObject:[account.date substringToIndex:7]];
    }
    
    // 用NSSet得到不重复的月份
    NSSet *set = [NSSet setWithArray:[dateArray copy]];
    
    // 再得到排序后的数组
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
    self.uniqueDateArray = [NSMutableArray arrayWithArray:[set sortedArrayUsingDescriptors:sortDesc]];
    
}

- (void)calculateMonthsMoney {
    // 先将数据取得添加到暂时数组中，防止每次调用这方法在没有数据改变的情况下金额显示增大
    double tmpTotalIncome = 0;
    double tmpTotalExpense = 0;
    NSMutableArray *tmpMonthIncome = [NSMutableArray array];
    NSMutableArray *tmpMonthExpense = [NSMutableArray array];
    
    
    for (NSInteger i = 0; i < self.uniqueDateArray.count; i++) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
        
        // 过滤月份
        [request setPredicate:[NSPredicate predicateWithFormat:@"date beginswith[c] %@", self.uniqueDateArray[i]]];
        
        NSError *error = nil;
        NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
        
        double income = 0;
        double expense = 0;
        for (Account *account in results) {
            if ([account.incomeType isEqualToString:@"income"]) {
                income += [account.money doubleValue];
            } else {
                expense += [account.money doubleValue];
            }
        }
        
        // 加到暂存总收入支出中
        tmpTotalIncome += income;
        tmpTotalExpense += expense;
        
        // 并将结果暂时储存在收入/支出数组相应月份在uniqueDateArray的位置
        // 方便到时候设置cell的各个属性
        [tmpMonthIncome addObject:[NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:income]]];
        [tmpMonthExpense addObject:[NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:expense]]];
        
    }
        
    // 将暂存值赋给属性以显示在UI上
    self.totalIncome = tmpTotalIncome;
    self.totalExpense = tmpTotalExpense;
    
    self.monthIncome = tmpMonthIncome;
    self.monthExpense = tmpMonthExpense;

    if (self.uniqueDateArray.count == 0) {
        [self showNoDataView];
    }else{
        
        [self removeNoDataView];
        
    }
}

- (void)setTotalLabel {
    // 示意图: 总收入: xxx(不限长度)  总支出: xxx(不限长度)
    NSString *incomeString = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:self.totalIncome]];
    NSString *expenseString = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:self.totalExpense]];
    self.totoalIncomeLabel.text = incomeString;
    self.totoalCostLabel.text = expenseString;
    
    
//    NSMutableAttributedString *mutString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总收入: %@  总支出: %@", incomeString, expenseString]];
//
//
//    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
//
//    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(5, incomeString.length)];
//
//    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(5 + incomeString.length + 2, 4)];
//
//    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5 + incomeString.length + 2 + 5, expenseString.length)];
//
//    [self.totalDetailLabel setAttributedText:mutString];
//
//
    // 计算结余
    double remainMoney = self.totalIncome - self.totalExpense;
    
    self.remainMoneyLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:remainMoney]];
    
}

#pragma UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.uniqueDateArray.count + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placeHolderCell" forIndexPath:indexPath];
        
        return cell;
        
    }else {
    JMAllHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthAccountCell" forIndexPath:indexPath];
    
    cell.date.text = self.uniqueDateArray[indexPath.row - 1];

    cell.inComeMoney.text =  self.monthIncome[indexPath.row - 1];
    cell.costMoney.text = [NSString stringWithFormat:@"%@ >",self.monthExpense[indexPath.row - 1]];
    
        
    return cell;
}
}

//- (NSMutableAttributedString *)configMoneyLabelWithIndexPath:(NSIndexPath *)indexPath {
//    // 收入金额
//    NSString  *income = self.monthIncome[indexPath.row - 1];
//
//    NSString *incomeString = [@"收入: " stringByAppendingString:income];
//
//    // 为了排版，固定金额数目为7位，不足补空格
//    for (NSInteger i = income.length; i < 7; i++) {
//        incomeString = [incomeString stringByAppendingString:@" "];
//    }
//
//    // 支出金额(前留一空格)
//    NSString *expense = self.monthExpense[indexPath.row - 1];
//    NSString *expenseString = [@" 支出: " stringByAppendingString:expense];
//
//    // 排版
//    for (NSInteger i = expense.length; i < 7; i++) {
//        expenseString = [expenseString stringByAppendingString:@" "];
//    }
//
//    // 合并两个字符串
//    NSString *moneyString = [incomeString stringByAppendingString:expenseString];
//
//    // 设置文本不同颜色
//    NSMutableAttributedString *mutString = [[NSMutableAttributedString alloc] initWithString:moneyString];
//
//    // 示意图: 收入: xxxxxxx 支出: xxxxxxx
//    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
//    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(4, 7)];
//    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(12, 3)];
//    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(16, 7)];
//
//    return mutString;
//}

#pragma mark - UITabelView Delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) {
        
        return YES;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 取得相应日期的数据
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
        [request setPredicate:[NSPredicate predicateWithFormat:@"date beginswith[c] %@", self.uniqueDateArray[indexPath.row - 1]]];
        NSError *error = nil;
        NSArray *accountToBeDeleted = [self.managedObjectContext executeFetchRequest:request error:&error];
        
        // 首先删除CoreData里的数据
        for (Account *account in accountToBeDeleted) {
            [self.managedObjectContext deleteObject:account];
        }
        // 然后移除提供数据源的数组
        [self.uniqueDateArray removeObjectAtIndex:indexPath.row - 1];
        // 删除tableView的行
        [self.monthTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        // 最后更新UI
        [self calculateMonthsMoney];
        
        [self setTotalLabel];
        
        [self.monthTableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 将detele改为删除
    return @" 删除 ";
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMonthDetail"]) {
        if ([[segue destinationViewController] isKindOfClass:[JMMonthHIstoryViewController class]]) {
            JMMonthHIstoryViewController *viewController = [segue destinationViewController];
            NSIndexPath *indexPath = [self.monthTableView indexPathForSelectedRow];
            
            // 将被点击cell的相应属性传过去
            viewController.date = self.uniqueDateArray[indexPath.row - 1];
        }
    }
}


@end
