//
//  Created by Shyngys Kassymov on 02.10.15.
//  Copyright © 2015 Shyngys Kassymov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTextView.h"

#pragma mark - Enums
#pragma mark -

/**
 The SKFormTextFieldType ENUM defines available modes of SKFormTextField
 */
typedef enum SKFormTextFieldMode:NSInteger {
    SKFormTextFieldModeWrite,
    SKFormTextFieldModeRead
} SKFormTextFieldMode;

/**
 The SKFormTextFieldType ENUM defines available types of SKFormTextField
 */
typedef enum SKFormTextFieldType:NSInteger {
    SKFormTextFieldTypeTextField,
    SKFormTextFieldTypeTextFieldDate,
    SKFormTextFieldTypeTextView,
} SKFormTextFieldType;

/**
 The SKFormTextFieldSide ENUM defines available sides to configure
 */
typedef enum SKFormTextFieldSide:NSInteger {
    SKFormTextFieldSideLeft,
    SKFormTextFieldSideRight,
    SKFormTextFieldSideBoth
} SKFormTextFieldSide;

/**
 The SKFormTextFieldState ENUM defines states of text field
 */
typedef enum SKFormTextFieldState:NSInteger {
    SKFormTextFieldStateDefault,
    SKFormTextFieldStateActive,
    SKFormTextFieldStateValid,
    SKFormTextFieldStateInvalid
} SKFormTextFieldState;

#pragma mark - Protocols
#pragma mark -

@class SKFormTextField;

/**
 The SKFormTextFieldDelegate protocol provides methods to update other view on screen
 */
@protocol SKFormTextFieldDelegate <NSObject>

@optional
- (void)textFieldDidBeginUpdates:(SKFormTextField *)textField;
- (void)textFieldDidEndUpdates:(SKFormTextField *)textField;

@end

/**
 The SKFormTextFieldDataSource protocol provides methods to text field validation and customization
 */
@protocol SKFormTextFieldDataSource <NSObject>

@optional
- (BOOL)textFieldIsValid:(SKFormTextField *)textField;
- (void)configureTextField:(SKFormTextField *)textField forState:(SKFormTextFieldState)state;

@end

#pragma mark - SKFormTextField
#pragma mark -

/**
 The SKFormTextField is a subclass of UIControl which provides additional features to UITextField like:
 1) Text validation
 2) Buttons for extra actions
 3) Description label and icons to provide another useful information
 
 SKFormTextField supports Auto Layout and IBDesignable to easy use in Interface Builder.
 
 This class customizable in most parts and license free, so enjoy using it!
 */

typedef void (^TextFieldDidEndEditingBlock)(NSString*);

IB_DESIGNABLE

@interface SKFormTextField : UIControl

@property (nonatomic) IBInspectable SKFormTextFieldState textFieldState;
@property (nonatomic) IBInspectable SKFormTextFieldType type;
@property (nonatomic) IBInspectable SKFormTextFieldMode mode;
@property (nonatomic, strong) IBInspectable UIColor *lineNormalColor;
@property (nonatomic, strong) IBInspectable UIColor *lineActiveColor;
@property (nonatomic, strong) IBInspectable UIColor *lineValidColor;
@property (nonatomic, strong) IBInspectable UIColor *lineErrorColor;
@property (nonatomic, strong) IBInspectable UIColor *descriptionNormalColor;
@property (nonatomic, strong) IBInspectable UIColor *descriptionActiveColor;
@property (nonatomic, strong) IBInspectable UIColor *descriptionValidColor;
@property (nonatomic, strong) IBInspectable UIColor *descriptionErrorColor;
@property (nonatomic, strong) IBInspectable NSString *placeholderText;
@property (nonatomic, strong) IBInspectable NSString *descriptionText;
@property (nonatomic, strong) IBInspectable NSString *errorMessageText;
@property (nonatomic, strong) IBInspectable UIImage *leftButtonImage;
@property (nonatomic, strong) IBInspectable UIImage *rightButtonImage;
@property (nonatomic, strong) IBInspectable UIImage *leftIconImage;
@property (nonatomic, strong) IBInspectable UIImage *rightIconImage;
@property (nonatomic, strong) IBInspectable UIImage *errorImage;
@property (nonatomic) IBInspectable BOOL leftButtonHidden;
@property (nonatomic) IBInspectable BOOL rightButtonHidden;
@property (nonatomic) IBInspectable BOOL leftIconHidden;
@property (nonatomic) IBInspectable BOOL rightIconHidden;
@property (nonatomic) IBInspectable BOOL required;
@property (nonatomic) IBInspectable BOOL doNotHideLineWhenRead;
@property (nonatomic) IBInspectable BOOL hideLine;
@property (nonatomic) IBInspectable CGFloat textViewHeight;

@property (weak) id <SKFormTextFieldDelegate> delegate;
@property (weak) id <SKFormTextFieldDataSource> dataSource;
@property (readwrite, copy) TextFieldDidEndEditingBlock textFieldDidEndEditingBlock;
@property (readwrite, copy) TextFieldDidEndEditingBlock textViewDidEndEditingBlock;

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSLayoutConstraint *textFieldLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textFieldRightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textFieldHeightConstraint;

@property (strong, nonatomic) SKTextView *textView;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIDatePicker *datePicker;

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;

@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) NSLayoutConstraint *lineHeightConstraint;

@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) NSLayoutConstraint *descriptionToLineConstraint;
@property (strong, nonatomic) NSLayoutConstraint *descriptionLabelLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *descriptionLabelRightConstraint;

@property (strong, nonatomic) NSLayoutConstraint *leftButtonWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leftButtonHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightButtonWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightButtonHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leftImageWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leftImageHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightImageWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightImageHeightConstraint;

@property (strong, nonatomic) UIImageView *leftDescriptionIcon;
@property (strong, nonatomic) UIImageView *rightDescriptionIcon;

#pragma mark - Methods
#pragma mark -

/**
 Sets type for SKFormTextField
 @param type SKFormTextFieldType instance
 */
- (void)setType:(SKFormTextFieldType)type animated:(BOOL)animated;

/**
 Shows button at specified side of textField
 @param side SKFormTextFieldSide instance
 */
- (void)showButtonAtSide:(SKFormTextFieldSide)side;

/**
 Hides button at specified side of textField
 @param side SKFormTextFieldSide instance
 */
- (void)hideButtonAtSide:(SKFormTextFieldSide)side;

/**
 Shows icon at specified side of descriptionLabel
 @param side SKFormTextFieldSide instance
 */
- (void)showDescriptionIconAtSide:(SKFormTextFieldSide)side;

/**
 Hides icon at specified side of descriptionLabel
 @param side SKFormTextFieldSide instance
 */
- (void)hideDescriptionIconAtSide:(SKFormTextFieldSide)side;

/**
 Returns BOOL value showing if textField has text
 @param side SKFormTextFieldSide instance
 */
- (BOOL)isEmpty;

@end
