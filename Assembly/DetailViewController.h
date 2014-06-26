//
//  DetailViewController.h
//  Assembly
//
//  Created by Michael Stromer on 6/26/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
