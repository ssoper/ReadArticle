//
//  ViewController.m
//  ReadArticle
//
//  Created by Sean Soper on 8/9/13.
//  Copyright (c) 2013 The Washington Post. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageEffects.h"
#import "UIView+Extensions.h"
#import "MSLabel.h"
#import <QuartzCore/QuartzCore.h>

CGFloat const BlurOffset = 260;
CGFloat const BlurMaxAlpha = 0.86;
CGFloat const ParallaxRate = 0.4;

@interface ViewController ()

@property (nonatomic, strong) NSDictionary *article;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.titleLbl.font = [UIFont fontWithName: @"FranklinITCStd-Bold" size: 36];
  self.titleLbl.lineHeight = 38;

  self.bylineLbl.font = [UIFont fontWithName: @"FranklinITCStd-Light" size: 20];
  self.bylineLbl.lineHeight = 22;

  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
  gradientLayer.colors = @[(id)[UIColor colorWithWhite: 1 alpha: 1].CGColor, (id)[UIColor colorWithWhite: 1 alpha: 0.1].CGColor];
  gradientLayer.locations = @[@0.7, @1.0];
  gradientLayer.startPoint = CGPointMake(0.5, 1);
  gradientLayer.endPoint = CGPointMake(0.5, 0);
  gradientLayer.frame = self.gradientView.bounds;
  [self.gradientView.layer addSublayer: gradientLayer];

  self.captionLbl.font = [UIFont fontWithName: @"FranklinITCStd-LightItalic" size: 16];
  self.captionLbl.lineHeight = 18;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"data"
                                                   ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: data options: kNilOptions error: nil];
  self.article = json[@"article"];

  self.imageView.image = [UIImage imageNamed: self.article[@"photo"][@"name"]];
  self.blurredImageView.image = [[UIImage imageNamed: self.article[@"photo"][@"name"]] applyLightEffect];
}

- (void) viewDidAppear:(BOOL)animated {
  [super viewDidAppear: animated];

  self.titleLbl.text = self.article[@"title"];
  [self.titleLbl sizeToFit];

  self.bylineLbl.y = self.titleLbl.y + self.titleLbl.height + 10;
  self.bylineLbl.text = [NSString stringWithFormat: @"By %@", self.article[@"author"]];

  self.captionLbl.text = [NSString stringWithFormat: @"%@ (%@/%@)", self.article[@"photo"][@"caption"], self.article[@"photo"][@"photographer"], self.article[@"photo"][@"source"]];
  [self.captionLbl sizeToFit];
  self.captionLbl.y = self.titleLbl.y;

  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString: self.article[@"content"]];
  [text setAttributes: @{NSFontAttributeName: [UIFont fontWithName: @"FranklinITCStd-Light" size: 36]} range: NSMakeRange(0, 1)];
  [text setAttributes: @{NSFontAttributeName: [UIFont fontWithName: @"FranklinITCStd-Light" size: 24]} range: NSMakeRange(1, text.length-1)];
  self.textView.attributedText = text;
  self.textView.height = self.textView.contentSize.height;
  self.textView.y = self.bylineLbl.y + self.bylineLbl.height + 8;

  self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.textView.y + self.textView.contentSize.height + 60);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if(scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= BlurOffset) {
    float percent = (scrollView.contentOffset.y / 300);
    self.blurredImageView.alpha = percent;
    self.gradientView.alpha = percent;
  } else if (scrollView.contentOffset.y > BlurOffset){
    self.blurredImageView.alpha = BlurMaxAlpha;
    self.gradientView.alpha = 1;
  } else if (scrollView.contentOffset.y < 0) {
    self.blurredImageView.alpha = 0;
    self.gradientView.alpha = 0;
  }

  if (scrollView.contentOffset.y >= 0) {
    self.imageView.y = -floorf(scrollView.contentOffset.y*ParallaxRate);
    self.blurredImageView.y = -floorf(scrollView.contentOffset.y*ParallaxRate);
    self.gradientView.y = floorf(self.imageView.y + self.imageView.height - 2);
  } else if (scrollView.contentOffset.y < 0) {
    self.imageView.y = 0;
    self.blurredImageView.y = 0;
    self.gradientView.y = 295;
  }
}

@end
