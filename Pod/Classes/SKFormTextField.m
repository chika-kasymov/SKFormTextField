//
//  Created by Shyngys Kassymov on 02.10.15.
//  Copyright © 2015 Shyngys Kassymov. All rights reserved.
//

#import "SKFormTextField.h"

#pragma mark - SKFormTextField
#pragma mark -

#define DEFAULT_TEXT_FIELD_HEIGHT 35
#define NORMAL_COLOR [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1.0]
#define ACTIVE_COLOR [UIColor colorWithRed:0/255.0 green:150/255.0 blue:136/255.0 alpha:1.0]
#define VALID_COLOR NORMAL_COLOR
#define ERROR_COLOR [UIColor colorWithRed:219/255.0 green:68/255.0 blue:55/255.0 alpha:1.0]

@interface SKFormTextField () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation SKFormTextField {
    BOOL hasSetuped;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initVars];
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initVars];
        [self setup];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Update UI elements
    [self updateUI];
}

- (void)initVars {
    // Initialize default values
    self.textFieldState = SKFormTextFieldStateDefault;
    self.mode = SKFormTextFieldModeWrite;
    self.lineNormalColor = [[UIColor blackColor] colorWithAlphaComponent:0.12];
    self.lineActiveColor = ACTIVE_COLOR;
    self.lineValidColor = [[UIColor blackColor] colorWithAlphaComponent:0.12];
    self.lineErrorColor = ERROR_COLOR;
    self.descriptionNormalColor = NORMAL_COLOR;
    self.descriptionActiveColor = NORMAL_COLOR;
    self.descriptionValidColor = VALID_COLOR;
    self.descriptionErrorColor = ERROR_COLOR;
    self.placeholderText = @"";
    self.descriptionText = @"";
    self.errorMessageText = @"";
    self.textViewHeight = DEFAULT_TEXT_FIELD_HEIGHT;
}

- (void)setup {
    // Check if view has already been setuped
    if (!hasSetuped) {
        // Create and add views to main view
        if (!self.leftButton) {
            self.leftButton = [UIButton new];
            self.leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
            if (self.leftButtonImage) {
                [self.leftButton setImage:self.leftButtonImage forState:UIControlStateNormal];
            }
            [self addSubview:self.leftButton];
        }
        if (!self.textField) {
            self.textField = [UITextField new];
            self.textField.delegate = self;
            self.textField.font = [UIFont fontWithName:@"Roboto-Regular" size:14];
            self.textField.placeholder = self.placeholderText;
            [self addSubview:self.textField];
        }
        if (!self.datePicker) {
            self.dateFormatter = [NSDateFormatter new];
            [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
        }
        if (!self.datePicker) {
            self.datePicker = [UIDatePicker new];
            self.datePicker.backgroundColor = [UIColor whiteColor];
            [self.datePicker addTarget:self action:@selector(datePickerDidChange:) forControlEvents:UIControlEventValueChanged];
            self.datePicker.datePickerMode = UIDatePickerModeDate;
        }
        if (!self.textView) {
            self.textView = [SKTextView new];
            self.textView.delegate = self;
            self.textView.font = [UIFont fontWithName:@"Roboto-Regular" size:14];
            self.textView.placeholderText = self.placeholderText;
            [self addSubview:self.textView];
            self.textView.hidden = YES;
        }
        if (!self.rightButton) {
            self.rightButton = [UIButton new];
            self.rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
            if (self.rightButtonImage) {
                [self.rightButton setImage:self.rightButtonImage forState:UIControlStateNormal];
            }
            [self addSubview:self.rightButton];
        }
        if (!self.line) {
            self.line = [UIView new];
            self.line.backgroundColor = self.lineNormalColor;
            [self addSubview:self.line];
        }
        if (!self.leftDescriptionIcon) {
            self.leftDescriptionIcon = [UIImageView new];
            self.leftDescriptionIcon.contentMode = UIViewContentModeScaleAspectFit;
            if (self.leftIconImage) {
                self.leftDescriptionIcon.image = self.leftIconImage;
            }
            [self addSubview:self.leftDescriptionIcon];
        }
        if (!self.descriptionLabel) {
            self.descriptionLabel = [UILabel new];
            self.descriptionLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
            self.descriptionLabel.textColor = self.descriptionNormalColor;
            self.descriptionLabel.numberOfLines = 0;
            self.descriptionLabel.preferredMaxLayoutWidth = self.descriptionLabel.frame.size.width;
            self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.descriptionLabel.text = self.descriptionText;
            [self addSubview:self.descriptionLabel];
        }
        if (!self.rightDescriptionIcon) {
            self.rightDescriptionIcon = [UIImageView new];
            self.rightDescriptionIcon.contentMode = UIViewContentModeScaleAspectFit;
            if (self.rightIconImage) {
                self.rightDescriptionIcon.image = self.rightIconImage;
            }
            [self addSubview:self.rightDescriptionIcon];
        }
        
        // Add constraints
        
        // left button
        self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leftButtonHeightConstaint =
        [NSLayoutConstraint constraintWithItem:self.leftButton
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:24];
        NSLayoutConstraint *leftButtonWidthConstaint =
        [NSLayoutConstraint constraintWithItem:self.leftButton
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:24];
        NSLayoutConstraint *leftButtonLeftConstaint =
        [NSLayoutConstraint constraintWithItem:self.leftButton
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:0];
        NSLayoutConstraint *leftButtonVerticalCenterConstaint =
        [NSLayoutConstraint constraintWithItem:self.leftButton
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textField
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.0
                                      constant:0];
        [self addConstraints:@[leftButtonHeightConstaint, leftButtonWidthConstaint, leftButtonLeftConstaint, leftButtonVerticalCenterConstaint]];
        
        // text field
        self.textField.translatesAutoresizingMaskIntoConstraints = NO;
        self.textFieldHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.textField
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:self.textViewHeight];
        NSLayoutConstraint *textFieldTopConstaint =
        [NSLayoutConstraint constraintWithItem:self.textField
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:0];
        NSLayoutConstraint *textFieldBottomConstaint =
        [NSLayoutConstraint constraintWithItem:self.textField
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.line
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:0];
        if (self.textFieldLeftConstraint) {
            [self removeConstraint:self.textFieldLeftConstraint];
        }
        self.textFieldLeftConstraint =
        [NSLayoutConstraint constraintWithItem:self.textField
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.leftButton
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:8];
        if (self.textFieldRightConstraint) {
            [self removeConstraint:self.textFieldRightConstraint];
        }
        self.textFieldRightConstraint =
        [NSLayoutConstraint constraintWithItem:self.textField
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.rightButton
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:-8];
        [self addConstraints:@[self.textFieldHeightConstraint, textFieldTopConstaint, textFieldBottomConstaint, self.textFieldLeftConstraint, self.textFieldRightConstraint]];
        
        // textView
        self.textView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *textViewTopConstraint =
        [NSLayoutConstraint constraintWithItem:self.textView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textField
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:0];
        NSLayoutConstraint *textViewLeftConstraint =
        [NSLayoutConstraint constraintWithItem:self.textView
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textField
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:0];
        NSLayoutConstraint *textViewBottomConstraint =
        [NSLayoutConstraint constraintWithItem:self.textView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textField
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0];
        NSLayoutConstraint *textViewRightConstraint =
        [NSLayoutConstraint constraintWithItem:self.textView
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textField
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:0];
        [self addConstraints:@[textViewTopConstraint, textViewLeftConstraint, textViewBottomConstraint, textViewRightConstraint]];
        
        // right button
        self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *rightButtonHeightConstaint =
        [NSLayoutConstraint constraintWithItem:self.rightButton
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:24];
        NSLayoutConstraint *rightButtonWidthConstaint =
        [NSLayoutConstraint constraintWithItem:self.rightButton
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:24];
        NSLayoutConstraint *rightButtonLeftConstaint =
        [NSLayoutConstraint constraintWithItem:self.rightButton
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:0];
        NSLayoutConstraint *rightButtonVerticalCenterConstaint =
        [NSLayoutConstraint constraintWithItem:self.rightButton
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.textField
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.0
                                      constant:0];
        [self addConstraints:@[rightButtonHeightConstaint, rightButtonWidthConstaint, rightButtonLeftConstaint, rightButtonVerticalCenterConstaint]];
        
        // line
        self.line.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *lineLeftConstraint =
        [NSLayoutConstraint constraintWithItem:self.line
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:0];
        NSLayoutConstraint *lineRightConstraint =
        [NSLayoutConstraint constraintWithItem:self.line
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:0];
        if (self.lineHeightConstraint) {
            [self removeConstraint:self.lineHeightConstraint];
        }
        self.lineHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.line
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:1];
        [self addConstraints:@[lineLeftConstraint, lineRightConstraint, self.lineHeightConstraint]];
        
        // left icon
        self.leftDescriptionIcon.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leftDescriptionIconHeightConstaint =
        [NSLayoutConstraint constraintWithItem:self.leftDescriptionIcon
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:18];
        NSLayoutConstraint *leftDescriptionIconWidthConstaint =
        [NSLayoutConstraint constraintWithItem:self.leftDescriptionIcon
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:18];
        NSLayoutConstraint *leftDescriptionIconLeftConstaint =
        [NSLayoutConstraint constraintWithItem:self.leftDescriptionIcon
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:0];
        NSLayoutConstraint *leftDescriptionIconVerticalCenterConstaint =
        [NSLayoutConstraint constraintWithItem:self.leftDescriptionIcon
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.descriptionLabel
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.0
                                      constant:0];
        [self addConstraints:@[leftDescriptionIconHeightConstaint, leftDescriptionIconWidthConstaint, leftDescriptionIconLeftConstaint, leftDescriptionIconVerticalCenterConstaint]];
        
        // description label
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.descriptionToLineConstraint =
        [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.line
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:4];
        NSLayoutConstraint *descriptionLabelBottomConstaint =
        [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0];
        if (self.descriptionLabelLeftConstraint) {
            [self removeConstraint:self.descriptionLabelLeftConstraint];
        }
        self.descriptionLabelLeftConstraint =
        [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.leftDescriptionIcon
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:8];
        if (self.descriptionLabelRightConstraint) {
            [self removeConstraint:self.descriptionLabelRightConstraint];
        }
        self.descriptionLabelRightConstraint =
        [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.rightDescriptionIcon
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:-8];
        [self addConstraints:@[self.descriptionToLineConstraint, descriptionLabelBottomConstaint, self.descriptionLabelLeftConstraint, self.descriptionLabelRightConstraint]];
        
        // right icon
        self.rightDescriptionIcon.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *rightDescriptionIconHeightConstaint =
        [NSLayoutConstraint constraintWithItem:self.rightDescriptionIcon
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:18];
        NSLayoutConstraint *rightDescriptionIconWidthConstaint =
        [NSLayoutConstraint constraintWithItem:self.rightDescriptionIcon
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:18];
        NSLayoutConstraint *rightDescriptionIconLeftConstaint =
        [NSLayoutConstraint constraintWithItem:self.rightDescriptionIcon
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:0];
        NSLayoutConstraint *rightDescriptionIconVerticalCenterConstaint =
        [NSLayoutConstraint constraintWithItem:self.rightDescriptionIcon
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.descriptionLabel
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.0
                                      constant:0];
        [self addConstraints:@[rightDescriptionIconHeightConstaint, rightDescriptionIconWidthConstaint, rightDescriptionIconLeftConstaint, rightDescriptionIconVerticalCenterConstaint]];
        
        hasSetuped = YES;
    }
}

- (void)updateUI {
    if (self.textFieldState == SKFormTextFieldStateDefault) {
        self.line.backgroundColor = self.lineNormalColor;
    } else if (self.textFieldState == SKFormTextFieldStateActive) {
        self.line.backgroundColor = self.lineActiveColor;
    }
    
    self.textField.placeholder = self.placeholderText;
    self.textView.placeholderText = self.placeholderText;
    
    if (self.leftButtonImage) {
        [self.leftButton setImage:self.leftButtonImage forState:UIControlStateNormal];
    }
    if (self.rightButtonImage) {
        [self.rightButton setImage:self.rightButtonImage forState:UIControlStateNormal];
    }
    
    if (self.leftIconImage) {
        self.leftDescriptionIcon.image = self.leftIconImage;
    }
    if (self.rightIconImage) {
        self.rightDescriptionIcon.image = self.rightIconImage;
    }
    
    if (self.leftButtonHidden) {
        [self hideButtonAtSide:SKFormTextFieldSideLeft];
    } else {
        [self showButtonAtSide:SKFormTextFieldSideLeft];
    }
    if (self.rightButtonHidden) {
        [self hideButtonAtSide:SKFormTextFieldSideRight];
    } else {
        [self showButtonAtSide:SKFormTextFieldSideRight];
    }
    if (self.leftIconHidden) {
        [self hideDescriptionIconAtSide:SKFormTextFieldSideLeft];
    } else {
        [self showDescriptionIconAtSide:SKFormTextFieldSideLeft];
    }
    if (self.rightIconHidden) {
        [self hideDescriptionIconAtSide:SKFormTextFieldSideRight];
    } else {
        [self showDescriptionIconAtSide:SKFormTextFieldSideRight];
    }
    
    if (self.textFieldHeightConstraint) {
        [self removeConstraint:self.textFieldHeightConstraint];
    }
    self.textFieldHeightConstraint =
    [NSLayoutConstraint constraintWithItem:self.textField
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:self.textViewHeight];
    [self addConstraint:self.textFieldHeightConstraint];
    
    [self checkTextFieldState];
    
    if (self.mode == SKFormTextFieldModeRead) {
        if (self.type == SKFormTextFieldTypeTextField) {
            self.textField.userInteractionEnabled = false;
        } else if (self.type == SKFormTextFieldTypeTextFieldDate) {
            self.textField.userInteractionEnabled = false;
        } else if (self.type == SKFormTextFieldTypeTextView) {
            self.textView.userInteractionEnabled = false;
        }
        
        if (!self.doNotHideLineWhenRead) {
            if (self.textFieldHeightConstraint) {
                [self removeConstraint:self.textFieldHeightConstraint];
            }
            
            if (self.lineHeightConstraint) {
                [self removeConstraint:self.lineHeightConstraint];
            }
            self.lineHeightConstraint =
            [NSLayoutConstraint constraintWithItem:self.line
                                         attribute:NSLayoutAttributeHeight
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1.0
                                          constant:0];
            [self addConstraint:self.lineHeightConstraint];
        }
        
        self.line.hidden = !self.doNotHideLineWhenRead;
    } else {
        if (self.type == SKFormTextFieldTypeTextField) {
            self.textField.userInteractionEnabled = true;
        } else if (self.type == SKFormTextFieldTypeTextFieldDate) {
            self.textField.userInteractionEnabled = true;
        } else if (self.type == SKFormTextFieldTypeTextView) {
            self.textView.userInteractionEnabled = true;
        }
    }
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    
    [self updateUI];
}

- (void)checkTextFieldState {
    if (self.textFieldState == SKFormTextFieldStateActive) {
        // set description text to normal
        self.descriptionLabel.textColor = self.descriptionActiveColor;
        self.descriptionLabel.text = self.descriptionText;
        
        // set line to active state
        self.line.backgroundColor = self.lineActiveColor;
        if (self.lineHeightConstraint) {
            [self removeConstraint:self.lineHeightConstraint];
        }
        self.lineHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.line
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:2];
        
        // reduce margin between line and description to prevent description text from hiding
        if (self.descriptionToLineConstraint) {
            [self removeConstraint:self.descriptionToLineConstraint];
        }
        self.descriptionToLineConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3];
        
        [self addConstraints:@[self.descriptionToLineConstraint, self.lineHeightConstraint]];
        
        // show normal icon if available
        if (self.rightDescriptionIcon) {
            self.rightDescriptionIcon.image = self.rightIconImage;
            if (!self.rightIconHidden) {
                [self showDescriptionIconAtSide:SKFormTextFieldSideRight];
            } else {
                [self hideDescriptionIconAtSide:SKFormTextFieldSideRight];
            }
        }
    } else if (self.textFieldState == SKFormTextFieldStateValid) {
        // set description text to normal
        self.descriptionLabel.textColor = self.descriptionValidColor;
        self.descriptionLabel.text = self.descriptionText;
        
        // set line to normal state
        self.line.backgroundColor = self.lineNormalColor;
        if (self.lineHeightConstraint) {
            [self removeConstraint:self.lineHeightConstraint];
        }
        self.lineHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.line
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:1];
        
        // reduce margin between line and description to prevent description text from hiding
        if (self.descriptionToLineConstraint) {
            [self removeConstraint:self.descriptionToLineConstraint];
        }
        self.descriptionToLineConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:4];
        
        [self addConstraints:@[self.descriptionToLineConstraint, self.lineHeightConstraint]];
        
        // show normal icon if available
        if (self.rightDescriptionIcon) {
            self.rightDescriptionIcon.image = self.rightIconImage;
            if (!self.rightIconHidden) {
                [self showDescriptionIconAtSide:SKFormTextFieldSideRight];
            } else {
                [self hideDescriptionIconAtSide:SKFormTextFieldSideRight];
            }
        }
    } else if (self.textFieldState == SKFormTextFieldStateInvalid) {
        // set error message
        self.descriptionLabel.textColor = self.descriptionErrorColor;
        self.descriptionLabel.text = self.errorMessageText;
        
        // set line to normal state
        self.line.backgroundColor = self.lineErrorColor;
        if (self.lineHeightConstraint) {
            [self removeConstraint:self.lineHeightConstraint];
        }
        self.lineHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.line
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:2];
        
        // reduce margin between line and description to prevent description text from hiding
        if (self.descriptionToLineConstraint) {
            [self removeConstraint:self.descriptionToLineConstraint];
        }
        self.descriptionToLineConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3];
        
        [self addConstraints:@[self.descriptionToLineConstraint, self.lineHeightConstraint]];
        
        // show error icon
        if (self.errorImage) {
            self.rightDescriptionIcon.image = self.errorImage;
            [self showDescriptionIconAtSide:SKFormTextFieldSideRight];
        } else {
            [self hideDescriptionIconAtSide:SKFormTextFieldSideRight];
        }
    } else {
        // set description text to normal
        self.descriptionLabel.textColor = self.descriptionNormalColor;
        self.descriptionLabel.text = self.descriptionText;
        
        // set line to normal state
        self.line.backgroundColor = self.lineNormalColor;
        if (self.lineHeightConstraint) {
            [self removeConstraint:self.lineHeightConstraint];
        }
        self.lineHeightConstraint =
        [NSLayoutConstraint constraintWithItem:self.line
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:1];
        
        // reduce margin between line and description to prevent description text from hiding
        if (self.descriptionToLineConstraint) {
            [self removeConstraint:self.descriptionToLineConstraint];
        }
        self.descriptionToLineConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:4];
        
        [self addConstraints:@[self.descriptionToLineConstraint, self.lineHeightConstraint]];
        
        // show normal icon if available
        if (self.rightDescriptionIcon) {
            self.rightDescriptionIcon.image = self.rightIconImage;
            if (!self.rightIconHidden) {
                [self showDescriptionIconAtSide:SKFormTextFieldSideRight];
            } else {
                [self hideDescriptionIconAtSide:SKFormTextFieldSideRight];
            }
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.descriptionLabel.preferredMaxLayoutWidth = self.descriptionLabel.frame.size.width;
}

#pragma mark - Methods
#pragma mark -

- (void)setType:(SKFormTextFieldType)type animated:(BOOL)animated {
    self.type = type;
    
    if (animated) {
//        [UIView animateWithDuration:0.345 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.5 options:0 animations:^{
            if (type == SKFormTextFieldTypeTextField) {
                self.textView.hidden = YES;
                self.textField.hidden = NO;
                self.textField.inputView = nil;
            } else if (type == SKFormTextFieldTypeTextFieldDate) {
                self.textView.hidden = YES;
                self.textField.hidden = NO;
                self.textField.inputView = self.datePicker;
            } else if (type == SKFormTextFieldTypeTextView) {
                self.textField.hidden = YES;
                self.textView.hidden = NO;
            }
//        } completion:^(BOOL finished) {
//            
//        }];
    } else {
        if (type == SKFormTextFieldTypeTextField) {
            self.textView.hidden = YES;
            self.textField.hidden = NO;
        } else if (type == SKFormTextFieldTypeTextFieldDate) {
            self.textView.hidden = YES;
            self.textField.hidden = NO;
            self.textField.inputView = self.datePicker;
        } else if (type == SKFormTextFieldTypeTextView) {
            self.textField.hidden = YES;
            self.textView.hidden = NO;
        }
    }
}

- (void)showButtonAtSide:(SKFormTextFieldSide)side {
    if (side == SKFormTextFieldSideBoth) {
        self.leftButton.hidden = NO;
        self.rightButton.hidden = NO;
        
        if (self.textFieldLeftConstraint) {
            [self removeConstraint:self.textFieldLeftConstraint];
        }
        self.textFieldLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.leftButton
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:8];
        
        if (self.textFieldRightConstraint) {
            [self removeConstraint:self.textFieldRightConstraint];
        }
        self.textFieldRightConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.rightButton
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0
                                                                      constant:-8];
        
        [self addConstraints:@[self.textFieldLeftConstraint, self.textFieldRightConstraint]];
    } else if (side == SKFormTextFieldSideLeft) {
        self.leftButton.hidden = NO;
        
        if (self.textFieldLeftConstraint) {
            [self removeConstraint:self.textFieldLeftConstraint];
        }
        self.textFieldLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.leftButton
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:8];
        [self addConstraint:self.textFieldLeftConstraint];
    } else if (side == SKFormTextFieldSideRight) {
        self.rightButton.hidden = NO;
        
        if (self.textFieldRightConstraint) {
            [self removeConstraint:self.textFieldRightConstraint];
        }
        self.textFieldRightConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.rightButton
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0
                                                                      constant:-8];
        [self addConstraint:self.textFieldRightConstraint];
    }
}

- (void)hideButtonAtSide:(SKFormTextFieldSide)side {
    if (side == SKFormTextFieldSideBoth) {
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
        
        if (self.textFieldLeftConstraint) {
            [self removeConstraint:self.textFieldLeftConstraint];
        }
        self.textFieldLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeLeft
                                                                   multiplier:1.0
                                                                     constant:0];
        
        if (self.textFieldRightConstraint) {
            [self removeConstraint:self.textFieldRightConstraint];
        }
        self.textFieldRightConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                    attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:0];
        
        [self addConstraints:@[self.textFieldLeftConstraint, self.textFieldRightConstraint]];
    } else if (side == SKFormTextFieldSideLeft) {
        self.leftButton.hidden = YES;
        
        if (self.textFieldLeftConstraint) {
            [self removeConstraint:self.textFieldLeftConstraint];
        }
        self.textFieldLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeLeft
                                                                   multiplier:1.0
                                                                     constant:0];
        [self addConstraint:self.textFieldLeftConstraint];
    } else if (side == SKFormTextFieldSideRight) {
        self.rightButton.hidden = YES;
        
        if (self.textFieldRightConstraint) {
            [self removeConstraint:self.textFieldRightConstraint];
        }
        self.textFieldRightConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:0];
        [self addConstraint:self.textFieldRightConstraint];
    }
}

- (void)showDescriptionIconAtSide:(SKFormTextFieldSide)side {
    if (side == SKFormTextFieldSideBoth) {
        self.leftDescriptionIcon.hidden = NO;
        self.rightDescriptionIcon.hidden = NO;
        
        if (self.descriptionLabelLeftConstraint) {
            [self removeConstraint:self.descriptionLabelLeftConstraint];
        }
        self.descriptionLabelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.leftDescriptionIcon
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:8];
        
        if (self.descriptionLabelRightConstraint) {
            [self removeConstraint:self.descriptionLabelRightConstraint];
        }
        self.descriptionLabelRightConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.rightDescriptionIcon
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0
                                                                      constant:-8];
        
        [self addConstraints:@[self.descriptionLabelLeftConstraint, self.descriptionLabelRightConstraint]];
    } else if (side == SKFormTextFieldSideLeft) {
        self.leftDescriptionIcon.hidden = NO;
        
        if (self.descriptionLabelLeftConstraint) {
            [self removeConstraint:self.descriptionLabelLeftConstraint];
        }
        self.descriptionLabelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.leftDescriptionIcon
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:8];
        [self addConstraint:self.descriptionLabelLeftConstraint];
    } else if (side == SKFormTextFieldSideRight) {
        self.rightDescriptionIcon.hidden = NO;
        
        if (self.descriptionLabelRightConstraint) {
            [self removeConstraint:self.descriptionLabelRightConstraint];
        }
        self.descriptionLabelRightConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.rightDescriptionIcon
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0
                                                                      constant:-8];
        [self addConstraint:self.descriptionLabelRightConstraint];
    }
}

- (void)hideDescriptionIconAtSide:(SKFormTextFieldSide)side {
    if (side == SKFormTextFieldSideBoth) {
        self.leftDescriptionIcon.hidden = YES;
        self.rightDescriptionIcon.hidden = YES;
        
        if (self.descriptionLabelLeftConstraint) {
            [self removeConstraint:self.descriptionLabelLeftConstraint];
        }
        self.descriptionLabelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeLeft
                                                                   multiplier:1.0
                                                                     constant:0];
        
        if (self.descriptionLabelRightConstraint) {
            [self removeConstraint:self.descriptionLabelRightConstraint];
        }
        self.descriptionLabelRightConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:0];
        
        [self addConstraints:@[self.descriptionLabelLeftConstraint, self.descriptionLabelRightConstraint]];
    } else if (side == SKFormTextFieldSideLeft) {
        self.leftDescriptionIcon.hidden = YES;
        
        if (self.descriptionLabelLeftConstraint) {
            [self removeConstraint:self.descriptionLabelLeftConstraint];
        }
        self.descriptionLabelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeLeft
                                                                   multiplier:1.0
                                                                     constant:0];
        [self addConstraint:self.descriptionLabelLeftConstraint];
    } else if (side == SKFormTextFieldSideRight) {
        self.rightDescriptionIcon.hidden = YES;
        
        if (self.descriptionLabelRightConstraint) {
            [self removeConstraint:self.descriptionLabelRightConstraint];
        }
        self.descriptionLabelRightConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:0];
        [self addConstraint:self.descriptionLabelRightConstraint];
    }
}

- (BOOL)isEmpty {
    return !self.textField.text || self.textField.text.length == 0;
}

- (void)datePickerDidChange:(UIDatePicker *)datePicker {
    self.textField.text = [self.dateFormatter stringFromDate:datePicker.date];
}

#pragma mark - Protocols
#pragma mark -

- (BOOL)textFieldIsValid {
    if ([self.dataSource respondsToSelector:@selector(textFieldIsValid:)]) {
        if (self.required && (!self.textField.text || self.textField.text.length == 0)) {
            return NO;
        }
        return [self.dataSource textFieldIsValid:self];
    }
    if (self.required && (!self.textField.text || self.textField.text.length == 0)) {
        return NO;
    }
    
    return YES;
}

- (void)configureTextFieldForCurrentState {
    if ([self.dataSource respondsToSelector:@selector(configureTextField:forState:)]) {
        [self.dataSource configureTextField:self forState:self.textFieldState];
    }
    
    [self checkTextFieldState];
}

#pragma mark - UITextFieldDelegate
#pragma mark -

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if ([self.delegate respondsToSelector:@selector(skTextFieldWillBeginEditing:)]) {
//        [self.delegate skTextFieldWillBeginEditing:textField];
//    }
    
    self.textFieldState = SKFormTextFieldStateActive;
    [self configureTextFieldForCurrentState];
    
//    if ([self.delegate respondsToSelector:@selector(skTextFieldDidBeginEditing:)]) {
//        [self.delegate skTextFieldDidBeginEditing:textField];
//    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if ([self.delegate respondsToSelector:@selector(skTextFieldWillEndEditing:)]) {
//        [self.delegate skTextFieldWillEndEditing:textField];
//    }
    
    self.textFieldState = [self textFieldIsValid] ? SKFormTextFieldStateValid : SKFormTextFieldStateInvalid;
    [self configureTextFieldForCurrentState];
    
//    if ([self.delegate respondsToSelector:@selector(skTextFieldDidEndEditing:)]) {
//        [self.delegate skTextFieldDidEndEditing:textField];
//    }
    
    if (self.textFieldDidEndEditingBlock) {
        self.textFieldDidEndEditingBlock();
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return false;
}

#pragma mark - UITextViewDelegate
#pragma mark -

- (void)textViewDidChange:(UITextView *)textView {
//    // start to update superview if needed in delegate
//    if ([self.delegate respondsToSelector:@selector(willUpdateTextViewHeight:)]) {
//        [self.delegate willUpdateTextViewHeight:textView];
//    }
//    
//    // calculate height
//    CGFloat maxHeight = 100;
//    CGFloat fixedWidth = textView.frame.size.width;
//    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//    CGRect newFrame = textView.frame;
//    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), fminf(newSize.height, maxHeight));
//    
//    // update height constraint
//    if (self.textFieldHeightConstraint) {
//        [self removeConstraint:self.textFieldHeightConstraint];
//    }
//    self.textFieldHeightConstraint =
//    [NSLayoutConstraint constraintWithItem:self.textField
//                                 attribute:NSLayoutAttributeHeight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:nil
//                                 attribute:NSLayoutAttributeNotAnAttribute
//                                multiplier:1.0
//                                  constant:newFrame.size.height];
//    [self addConstraint:self.textFieldHeightConstraint];
//
//    // finish update superview if needed in delegate
//    if ([self.delegate respondsToSelector:@selector(didUpdateTextViewHeight:)]) {
//        [self.delegate didUpdateTextViewHeight:textView];
//    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.textViewDidEndEditingBlock) {
        self.textViewDidEndEditingBlock();
    }
}

#pragma mark - Getters/Setters

- (void)setLineNormalColor:(UIColor *)lineNormalColor {
    _lineNormalColor = lineNormalColor;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setLineActiveColor:(UIColor *)lineActiveColor {
    _lineActiveColor = lineActiveColor;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setLineValidColor:(UIColor *)lineValidColor {
    _lineValidColor = lineValidColor;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setLineErrorColor:(UIColor *)lineErrorColor {
    _lineErrorColor = lineErrorColor;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setDescriptionNormalColor:(UIColor *)descriptionNormalColor {
    _descriptionNormalColor = descriptionNormalColor;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setDescriptionActiveColor:(UIColor *)descriptionActiveColor {
    _descriptionActiveColor = descriptionActiveColor;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setDescriptionValidColor:(UIColor *)descriptionValidColor {
    _descriptionValidColor = descriptionValidColor;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setDescriptionErrorColor:(UIColor *)descriptionErrorColor {
    _descriptionErrorColor = descriptionErrorColor;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = placeholderText;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setDescriptionText:(NSString *)descriptionText {
    _descriptionText = descriptionText;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setErrorMessageText:(NSString *)errorMessageText {
    _errorMessageText = errorMessageText;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setLeftButtonImage:(UIImage *)leftButtonImage {
    _leftButtonImage = leftButtonImage;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setRightButtonImage:(UIImage *)rightButtonImage {
    _rightButtonImage = rightButtonImage;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setLeftIconImage:(UIImage *)leftIconImage {
    _leftIconImage = leftIconImage;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setRightIconImage:(UIImage *)rightIconImage {
    _rightIconImage = rightIconImage;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setErrorImage:(UIImage *)errorImage {
    _errorImage = errorImage;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setLeftButtonHidden:(BOOL)leftButtonHidden {
    _leftButtonHidden = leftButtonHidden;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setRightButtonHidden:(BOOL)rightButtonHidden {
    _rightButtonHidden = rightButtonHidden;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setLeftIconHidden:(BOOL)leftIconHidden {
    _leftIconHidden = leftIconHidden;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setRightIconHidden:(BOOL)rightIconHidden {
    _rightIconHidden = rightIconHidden;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setTextViewHeight:(CGFloat)textViewHeight {
    _textViewHeight = textViewHeight;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setTextFieldState:(SKFormTextFieldState)textFieldState {
    _textFieldState = textFieldState;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setType:(SKFormTextFieldType)type {
    _type = type;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setMode:(SKFormTextFieldMode)mode {
    _mode = mode;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

- (void)setDoNotHideLineWhenRead:(BOOL)doNotHideLineWhenRead {
    _doNotHideLineWhenRead = doNotHideLineWhenRead;
    
    if (hasSetuped) {
        [self updateUI];
    }
}

@end
