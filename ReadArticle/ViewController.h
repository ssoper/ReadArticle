//
//  ViewController.h
//  ReadArticle
//
//  Created by Sean Soper on 8/9/13.
//  Copyright (c) 2013 The Washington Post. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSLabel;

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (weak) IBOutlet UIImageView *imageView, *blurredImageView;
@property (weak) IBOutlet UIScrollView *scrollView;
@property (weak) IBOutlet UITextView *textView;
@property (weak) IBOutlet UIView *gradientView;
@property (weak) IBOutlet MSLabel *titleLbl, *bylineLbl, *captionLbl;

@end
