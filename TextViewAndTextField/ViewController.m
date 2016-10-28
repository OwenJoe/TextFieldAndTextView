//
//  ViewController.m
//  UITextField的监听输入
//
//  Created by owen on 16/5/19.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITextFieldDelegate>


@property (nonatomic,strong) UITextField *dTextField;

@property (nonatomic,strong) UITextView *kTextView;
@property (nonatomic,strong) UILabel *placeholderLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //UITextField
    [self initTextFieldMethod];
    
    //UITextView
    [self addTextViewMethod];
    
}

/********************************UITextField部分****************************************/

-(void)initTextFieldMethod{
    //只有初始化,才能写代理,东西都么有,哪里来的各种属性,很容易空指针,野指针,虽然不报错,但是非常危险
    self.dTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 250, self.view.frame.size.width/1.5, 50)];
    
    //代理不要忘了写
    self.dTextField.delegate = self;
    
    //删除的叉叉号
    self.dTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    //字符变成密码..
    self.dTextField.secureTextEntry = YES;
    
    //默认保持文本长度,文本太长会自动滚动
    self.dTextField.adjustsFontSizeToFitWidth = YES;
    
    //更改键盘return样式
    self.dTextField.returnKeyType =UIReturnKeySearch;
    
    
    self.dTextField.placeholder = @"请输入关键字";
    self.dTextField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_dTextField];
    
    
    //监听的动作是:UIControlEventEditingChanged
    [self.dTextField addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventEditingChanged];
}


/**
 *  监听文本框输入
 *
 */
-(void)textFieldClick:(UITextField *)sender{
    
    NSLog(@"正在输入的文字:%@",[sender text]);
    
}


/**
 *  监听键盘return按键
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"监听return:%@",textField.text);
    return YES;
}


/********************************UITextView部分****************************************/
-(void)addTextViewMethod{
    
    self.kTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-80, 100)];
    [self.view addSubview:self.kTextView];
    self.kTextView.delegate = self;
    
    //修复文本框是偏移（下移）
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //设置文本
    //    self.   kTextView.text = @"我是UI   kTextView，大家欢迎使用。";
    //设置文字对齐方式属性
    self.   kTextView.textAlignment = NSTextAlignmentLeft;
    //设置文字对齐方
    //设置文字颜色属性
    self.   kTextView.textColor = [UIColor purpleColor];
    //设置文字字体属性
    self.   kTextView.font = [UIFont systemFontOfSize:12.0f];
    //设置编辑使能属性,是否允许编辑（=NO时，只用来显示，依然可以使用选择和拷贝功能）
    self.   kTextView.editable = YES;
    //设置背景颜色属性
    self.   kTextView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //设置圆角、边框属性
    self.   kTextView.layer.cornerRadius = 6.0f;
    self.   kTextView.layer.borderWidth = 2;
    self.   kTextView.layer.borderColor = [[UIColor colorWithRed:200.0/255 green:50/255 blue:10/255 alpha:1] CGColor];
    
    
    //模仿UTextField的placeholder属性
    _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.   kTextView.frame), 20)];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.textColor = [UIColor grayColor];
    _placeholderLabel.text = @"请输入内容";
    _placeholderLabel.font = self.   kTextView.font;
    [self.   kTextView addSubview:_placeholderLabel];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //    NSLog(@"将要开始编辑？");
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    //    NSLog(@"将要结束编辑？");
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    //    NSLog(@"开始编辑。");
    _placeholderLabel.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    //    NSLog(@"结束编辑。");
    
    //模仿UTextField的placeholder属性
    if (self.kTextView.text.length == 0) {
        _placeholderLabel.text = @"请输入内容";
    }else{
        _placeholderLabel.text = @"";
    }
    //    if (textView.markedTextRange == nil) {
    //        NSLog(@"监听到输入%@",textView.text);
    //
    //    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //    NSLog(@"将要改变内容？");
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    //    NSLog(@"改变内容。");
    NSLog(@"监听到输入:%@",textView.text);
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    //    NSLog(@"选中内容。");
}



/*
 **监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}





@end
