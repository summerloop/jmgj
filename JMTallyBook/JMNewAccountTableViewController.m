//
//  JMNewAccountTableViewController.m
//  JMTallyBook
//
//  Created by JM on 16/2/21.
//  Copyright © 2016年 JM. All rights reserved.
//

#import "JMNewAccountTableViewController.h"
#import "AppDelegate.h"
#import "JMAccountViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "VENCalculatorInputTextField.h"
#import "UIBarButtonItem+Extension.h"

@interface JMNewAccountTableViewController () <UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField; // 只是为了标记位置，真正使用的是下面自定义的textField

@property (strong, nonatomic) VENCalculatorInputTextField *customTextField; // 自定义textField，可弹出数字计算器键盘

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UITextView *detailTextView; //详细描述

@property (strong, nonatomic) UIDatePicker *datePicker; //日期选择器

@property (strong, nonatomic) UIPickerView *pickerView; // 类型选择器

@property (strong, nonatomic) NSString *incomeType; //收入(income)还是支出(expense)

@property (strong, nonatomic) UIView *shadowView; // 插入的灰色夹层

@property (strong, nonatomic) NSUserDefaults *userDefaults;

@property (strong, nonatomic) NSMutableArray *incomeArray; // 分别用来储存两种类型的种类

@property (strong, nonatomic) NSMutableArray *expenseArray;

@end

@implementation JMNewAccountTableViewController

#pragma mark - view did load

- (BOOL)isSegueFromTableView {
    if (!_isSegueFromTableView) {
        _isSegueFromTableView = NO; // 默认为NO
    }
    return _isSegueFromTableView;
}

// 在viewDidAppear中才能确定控件layout之后的位置
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 第三方库的自定义数字计算器键盘，将其frame设为moneyTextField的frame，将其完全覆盖
    // 如果是在viewdidload中为了弹出键盘而设置的customTextField，则移除并重设
    // 而如果中途从别的界面切过来，在customTextField已存在(width肯定不为0)的情况下，不再重复加入自定义textField
    if (self.customTextField.frame.size.width == 0) {
        // 这里将自定义的键盘覆盖原有的moneyTextField
        self.customTextField.frame = self.moneyTextField.frame;
        [[self.moneyTextField superview] bringSubviewToFront:self.customTextField];

        self.customTextField.textAlignment = NSTextAlignmentRight;
        self.customTextField.placeholder = @"输入金额";
        self.customTextField.textColor = [UIColor redColor];
        
    }
    
    
    // 如果是从tableView传来，根据类别选择字体颜色
    if (self.isSegueFromTableView) {
        self.customTextField.text = self.accountInSelectedRow.money;
        if ([self.incomeType isEqualToString:@"income"]) {
            self.customTextField.textColor = [UIColor blueColor];
        } else {
            self.customTextField.textColor = [UIColor redColor];
        }
    }
    
    //一进入界面即弹出键盘输入金额
    [self.customTextField becomeFirstResponder];
    
    // 给tableView加上一个Tap手势，使得点击空白处收回键盘，点击相应cell的位置时调用相应的method
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)]];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自定义"保存"按钮(右侧)
    [self customizeRightButton];
        
    
    // 判断是怎样转到这个界面的
    if (self.isSegueFromTableView) {
        // 如果是点击tableView而来，显示传递过来的各个属性
        self.dateLabel.text = self.accountInSelectedRow.date;
        self.detailTextView.text = self.accountInSelectedRow.detail;
        self.incomeType = self.accountInSelectedRow.incomeType;
        self.typeLabel.text = self.accountInSelectedRow.type;
        
        // money在Viewdidappear里设置
        
    } else {
        // 如果是点击记账按钮而来
        //日期显示默认为当前日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        self.dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
        
        //利用textView的delegate实现其placeholder
        self.detailTextView.delegate = self;
        self.detailTextView.text = @"详细描述(选填)";
        self.detailTextView.textColor = [UIColor lightGrayColor];
        
        // 类别默认为支出
        self.incomeType = @"expense";
    }
    
    // 判断是否第一次进入界面
    [self judgeFirstLoadThisView];
    
    // 进入界面先弹出键盘(此处只是为了弹出键盘而加入customTextField，在Viewdidappear中是要移除重新赋值的)
    self.customTextField = [[VENCalculatorInputTextField alloc] initWithFrame:CGRectZero];
    [[self.moneyTextField superview] addSubview:self.customTextField];
    [self.customTextField becomeFirstResponder];
    
}

- (void)judgeFirstLoadThisView {
    // 创建userDefault单例对象
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![self.userDefaults boolForKey:@"haveLoadedJMNewAccountTableViewController"]) {
        // 第一次进入此页面
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"教程" message:@"输入金额、类别、日期以及详细(选填)，点右上角按钮保存" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"知道了，不再提醒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.userDefaults setBool:YES forKey:@"haveLoadedJMNewAccountTableViewController"];
        }];
        
        [alert addAction:actionOK];
        
        
        [self.customTextField resignFirstResponder];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 视图消失时，判断是否有代理且实现了代理方法
    // 若实现了，将date传过去
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didPassDate:)]) {
        [self.delegate viewController:self didPassDate:self.dateLabel.text];
    }
    
}

#pragma mark - tap screen methods

- (void)tapScreen:(UITapGestureRecognizer *)gesture {
    // 根据点击的位置判断点击的cell在哪一个section和row
    // 因为此界面高度是写死的，所以通过点击位置的y坐标来判断点击的是哪一个位置(这里没用indexPathForRowAtPoint是因为这个方法判断不准...)
    // 坐标示意图:
    // section:0 row:0   y: 99 - 149
    // section:0 row:1   y: 149 - 199
    // section:0 row:2   y: 199 - 249
    // section:0 row:0   y: 285 - 369
    
    CGFloat touchY = [gesture locationInView:[self.tableView superview]].y;
    
    if (touchY < 99 || touchY > 149) {
        [self.customTextField resignFirstResponder];
        // 因为在大于三位数且存在小数点的情况下会默认每隔3位加一个逗号，将逗号都去掉
        self.customTextField.text = [self deleteDotsInString:self.customTextField.text];
    }
    if (touchY < 285 || touchY > 369) {
        [self.detailTextView resignFirstResponder];
    }
    
    
    
    // 根据indexPath的不同执行不同的方法
    if (touchY >= 99 && touchY <= 149) {
        //点击输入金额，弹出自定义键盘
        [self.customTextField becomeFirstResponder];
    } else if (touchY >= 149 && touchY <= 199) {
        // 点击类别选择，创建一个类别选择框
        [self setUpPickerView];
    } else if (touchY >= 199 && touchY <= 249) {
        // 点击选择日期，创建一个日期选择框
        [self setUpDatePicker];
    } else if (touchY >= 285 && touchY <= 369) {
        // 点击详细说明，弹出键盘
        [self.detailTextView becomeFirstResponder];
    }
}

- (void)setUpDatePicker {
    // 插入夹层
    [self insertShadowView];
    
    // 初始化一个datePicker并使其居中
    if (self.datePicker == nil) {
        self.datePicker = [[UIDatePicker alloc] init];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        self.datePicker.center = self.view.center;
        self.datePicker.backgroundColor = [UIColor whiteColor];
        //设为圆角矩形
        self.datePicker.layer.cornerRadius = 10;
        self.datePicker.layer.masksToBounds = YES;
        [self.view addSubview:self.datePicker];
    } else {
        [self.view addSubview:self.datePicker];
    }
    
    //添加监听事件
    [self.datePicker addTarget:self action:@selector(datePickerValueDidChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)setUpPickerView {
    // 第一次进入应用时，设置pickerView的默认数据
    [self setDefaultDataForPickerView];
    
    // 插入夹层
    [self insertShadowView];
    
    // 初始化一个pickerView并使其居中
    if (self.pickerView == nil) {
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 300, 180)];
        self.pickerView.center = self.view.center;
        self.pickerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.pickerView];
    } else {
        [self.view addSubview:self.pickerView];
    }
    
    // 设置delegate
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    // 默认显示第一个类别
    if ([self.incomeType isEqualToString:@"expense"]) {
        self.typeLabel.text = self.expenseArray[0];
    } else {
        self.typeLabel.text = self.incomeArray[0];
    }
}

#pragma mark - customize right button

// 自定义右侧保存按钮
- (void)customizeRightButton {
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(preserveButtonPressed:)];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(preserveButtonPressed:) Title:@"保存" Font:SYSTEMFONT(17) TextColor:HexColor(@"3e2af6")];
    
    
    
    
    
}


- (void)preserveButtonPressed:(UIButton *)sender {
    if ([self.typeLabel.text isEqualToString:@"点击输入"] || [self.customTextField.text isEqualToString:@""]) {
        // type和money都是必填的，如果有一个没填，则弹出AlertController提示
        [self presentAlertControllerWithMessage:@"金钱数额和类型都是必填的"];
    } else if ([self.customTextField.text componentsSeparatedByString:@"."].count > 2) {
        // 输入超过两个小数点
        [self presentAlertControllerWithMessage:@"输入金额不格式不符"];
    } else if ([self moneyTextContainsCharacterOtherThanNumber]) {
        // 输入纯数字以外的字符
        [self presentAlertControllerWithMessage:@"输入金额只能是数字"];
    } else {
        if (self.isSegueFromTableView) {
            // 若是从tableView传来的，则只需更新account就好
            self.accountInSelectedRow.type = self.typeLabel.text;
            self.accountInSelectedRow.detail = self.detailTextView.text;
            [self setMoneyToAccount:self.accountInSelectedRow];
            self.accountInSelectedRow.incomeType = self.incomeType;
            self.accountInSelectedRow.date = self.dateLabel.text;
        } else {
            // 若是必填项都已填好且要记新帐，则将属性保存在CoreData中
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            
            Account *account = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:appDelegate.managedObjectContext];
            
            account.type = self.typeLabel.text;
            // 截取money的小数点
            [self setMoneyToAccount:account];
            account.incomeType = self.incomeType;
            account.date = self.dateLabel.text;
            
            // 此处因为textView无法使用placeholder而将其文本默认为"详细描述(选填)"
            // 故通过判断其是否被修改来决定储存的内容
            if (![self.detailTextView.text isEqualToString:@"详细描述(选填)"]) {
                account.detail = self.detailTextView.text;
            } else {
                // 当用户未编辑详细描述时，将account的detail设为空
                account.detail = @"";
            }
        }
        
        // 跳转到前一界面
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setMoneyToAccount:(Account *)account {
    NSString *moneyInput = self.customTextField.text;
    if ([moneyInput containsString:@"."]) {
        NSString *dotString = [moneyInput substringFromIndex:[moneyInput rangeOfString:@"."].location]; // 截取小数点后(包括小数点)的string
        
        if (dotString.length == 1) {
            // 若只有一个小数点，去掉最后一个小数点
            account.money = [moneyInput substringToIndex:moneyInput.length - 1];
        } else if (dotString.length == moneyInput.length) {
            // 若小数点在首位
            account.money = [@"0" stringByAppendingString:dotString];
        } else {
            // 若小数点后大于一位，则保留一位(精确到角)
            account.money = [moneyInput substringToIndex:[moneyInput rangeOfString:@"."].location + 2];
        }
    } else {
        // 若为整数
        account.money = self.customTextField.text;
    }

}

- (void)presentAlertControllerWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alertController addAction:action];
    
    // 弹出alertController之前先将所有的键盘收回，否则会导致之后键盘不响应
    [self.customTextField resignFirstResponder];
    [self.detailTextView resignFirstResponder];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

- (BOOL)moneyTextContainsCharacterOtherThanNumber {
    if (!([self isPureInt:self.customTextField.text] || [self isPureFloat:self.customTextField.text])) {
        // 如果出现了纯数字以外的字符，返回YES
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)deleteDotsInString:(NSString *)string {
    NSArray *subStrings = [string componentsSeparatedByString:@","];
    
    NSString *newString = [NSString string];
    for (NSInteger i = 0; i < subStrings.count; i++) {
        newString = [newString stringByAppendingString:subStrings[i]];
    }
    
    return newString;
}

//判断是否为整形
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


// 借用一个开源的extension，点击系统的back按钮时，若内容都已输入，弹出弹框
- (BOOL)navigationShouldPopOnBackButton {
    if (self.isSegueFromTableView) {
        // 如果是从tableView传来查看详细的，那只在用户修改了数据后弹出对话框提示
        if (![self.customTextField.text isEqualToString:self.accountInSelectedRow.money] || ![self.typeLabel.text isEqualToString:self.accountInSelectedRow.type] || ![self.dateLabel.text isEqualToString:self.accountInSelectedRow.date] || ![self.detailTextView.text isEqualToString:self.accountInSelectedRow.detail]) {
            
            [self alertControllerAskWhetherStoreWithMessage:@"确定返回？修改将不会被保存"];
            
            return NO;
        }
    } else if (![self.customTextField.text isEqualToString:@""] && ![self.typeLabel.text isEqualToString:@"点击输入"]) {
        // 如果金额类别都填写了，弹出框询问是否保存
        [self alertControllerAskWhetherStoreWithMessage:@"确定返回？这笔账单将不会被保存"];
        
        return NO;
    }
    return YES;
}

- (void)alertControllerAskWhetherStoreWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 直接返回主界面并且不保存(更新)account
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不，留在页面" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
}

#pragma mark - insert shadow view and add button

- (void)insertShadowView {
    //插入一个浅灰色的夹层
    [self insertGrayView];
    
    //点击picker外的灰色夹层也视为确认
    [self.shadowView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerSelected)]];
    
    // 暂时隐藏右侧的保存按钮
    self.navigationItem.rightBarButtonItem = nil;
    
}

#pragma mark - set data for pickerView

- (void)setDefaultDataForPickerView {
    // 从userDefault中获取数据
    self.incomeArray = [self.userDefaults objectForKey:@"incomeJM"];
    self.expenseArray = [self.userDefaults objectForKey:@"expenseJM"];
    
    if (self.incomeArray.count == 0 || self.expenseArray.count == 0) {
        //若第一次进入应用，则为其设置默认的收入支出种类
        self.incomeArray = [NSMutableArray arrayWithArray:@[@"工资薪酬", @"奖金福利", @"生意经营", @"投资理财", @"彩票中奖", @"银行利息", @"其他收入"]];
        self.expenseArray = [NSMutableArray arrayWithArray:@[@"餐饮食品", @"交通路费", @"日常用品", @"服装首饰", @"学习教育", @"烟酒消费", @"房租水电", @"网上购物", @"运动健身", @"电子产品", @"化妆护理", @"医疗体检", @"游戏娱乐", @"外出旅游", @"油费维护", @"慈善捐赠", @"其他支出"]];
        
        // 保存至userDefaults中
        [self.userDefaults setObject:self.incomeArray forKey:@"incomeJM"];
        [self.userDefaults setObject:self.expenseArray forKey:@"expenseJM"];
        
        // 将type名当做key，将图片的名称当做object(这里暂时这两者是一样的，如果用户修改了类别的名称，则将新的type名当做key与图片的名称相关联)
        for (NSString *string in self.incomeArray) {
            [self.userDefaults setObject:string forKey:string];
        }
        for (NSString *string in self.expenseArray) {
            [self.userDefaults setObject:string forKey:string];
        }
    }
}

#pragma mark - date value changed

- (void)datePickerValueDidChanged:(UIDatePicker *)sender {
    // NSDate转NSString
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.dateLabel.text = [dateFormatter stringFromDate:sender.date];
}

#pragma mark - picker selected

- (void)pickerSelected {
    self.navigationItem.rightBarButtonItem = nil;
    
    [self.pickerView removeFromSuperview];
    [self.datePicker removeFromSuperview];
    
    //移除遮挡层并销毁
    [self.shadowView removeFromSuperview];
    self.shadowView = nil;

    //恢复右边的取消按钮
    [self customizeRightButton];
}

#pragma mark - detail text View delegate methods

//利用delegate方法实现textView的placeholder
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString: @"详细描述(选填)"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"详细描述(选填)";
        textView.textColor = [UIColor lightGrayColor];
    }
}

#pragma mark - insert a shadow view

//插入一个浅灰色的夹层
//此处不选择if (view == nil) {...} 是因为别的地方也要用shadowView，为了防止其上添加各种不同的方法使得复杂，所以每次退出就销毁，进来就用全新的
- (void)insertGrayView {
    self.shadowView = [[UIView alloc] initWithFrame:self.view.frame];
    self.shadowView.backgroundColor = [UIColor grayColor];
    self.shadowView.alpha = 0.5;
    [self.view addSubview:self.shadowView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath.row == 1) {
        [self.view bringSubviewToFront:self.pickerView];
    } else if (indexPath.row == 2) {
        [self.view bringSubviewToFront:self.datePicker];
    }
}

#pragma mark - UIPickerView dataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 2; // 左侧的需要收入与支出两行
    } else {
        // 根据类型不同提供不同的行数
        if ([self.incomeType isEqualToString:@"income"]) {
            return self.incomeArray.count;
        } else if ([self.incomeType isEqualToString:@"expense"]) {
            return self.expenseArray.count;
        } else {
            return 0;
        }
    }
}

#pragma mark - UIPickerView delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) { // 默认第一行为支出
        if (row == 0) {
            return @"支出";
        } else {
            return @"收入";
        }
    } else {
        // 根据收入支出类型不同分别返回不同的数据
        if ([self.incomeType isEqualToString:@"income"]) {
            return self.incomeArray[row];
        } else {
            return self.expenseArray[row];
        }
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        // 选择不同种类时改变incomeType值，以使得dataSource方法中得以判断右边需要多少行,并改变customTextField的字体颜色
        if (row == 0) {
            self.incomeType = @"expense";
            self.customTextField.textColor = [UIColor redColor];
            // 当切换到支出选项时，默认显示支出第一个类别的名称(不然的话还得要拉一下才可以)
            self.typeLabel.text = self.expenseArray[0];
        } else {
            self.incomeType = @"income";
            self.customTextField.textColor = [UIColor blueColor];
            // 当切换到收入选项时，默认显示收入第一个类别的名称
            self.typeLabel.text = self.incomeArray[0];
        }
        [self.pickerView reloadComponent:1];
    } else {
        if ([self.incomeType isEqualToString:@"income"]) {
            self.typeLabel.text = self.incomeArray[row];
        } else {
            self.typeLabel.text = self.expenseArray[row];
        }
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
