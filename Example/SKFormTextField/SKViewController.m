//
//  SKViewController.m
//  SKFormTextField
//
//  Created by Shyngys Kassymov on 01/12/2016.
//  Copyright (c) 2016 Shyngys Kassymov. All rights reserved.
//

#import "SKViewController.h"
#import <SKFormTextField/SKFormTextField.h>

@interface SKViewController () <UITextFieldDelegate, SKFormTextFieldDataSource>
@property (weak, nonatomic) IBOutlet SKFormTextField *formField;
@property (weak, nonatomic) IBOutlet SKFormTextField *requiredFormField;
@property (weak, nonatomic) IBOutlet SKFormTextField *customValidationFormField;
@property (weak, nonatomic) IBOutlet SKFormTextField *textViewFormField;
@property (weak, nonatomic) IBOutlet SKFormTextField *dateField;
@end

@implementation SKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.formField.textField.delegate = self;
    [self.formField.rightButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    self.formField.textFieldDidEndEditingBlock = ^(NSString *text){
        NSLog(@"Text: %@", text);
    };
    
    self.requiredFormField.textField.delegate = self;
    
    self.customValidationFormField.textField.delegate = self;
    self.customValidationFormField.dataSource = self;
    
    [self.textViewFormField setType:SKFormTextFieldTypeTextView animated:false];
    [self setToolbar:self.textViewFormField toTextField:false];
    
    [self.dateField setType:SKFormTextFieldTypeTextFieldDate animated:false];
    [self setToolbar:self.dateField toTextField:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)showAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Action!" message:@"You can specify your actions to left/right button" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak UIAlertController *weakAlertControler = alertController;
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakAlertControler dismissViewControllerAnimated:true completion:nil];
    }]];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)hideKeyboard {
    [self.view endEditing:true];
}

#pragma mark - Helpers

- (void)setToolbar:(SKFormTextField *)field toTextField:(BOOL)toTextField {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(hideKeyboard)], nil];
    if (toTextField) {
        field.textField.inputAccessoryView = toolbar;
    } else {
        field.textView.inputAccessoryView = toolbar;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return false;
}

#pragma mark - SKFormTextFieldDataSource

- (BOOL)textFieldIsValid:(SKFormTextField *)textField {
    if ([[textField.textField.text lowercaseString] containsString:@"hello"]) {
        return true;
    }
    
    return false;
}

@end
