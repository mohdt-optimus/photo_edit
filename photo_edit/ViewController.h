//
//  ViewController.h
//  photo_edit
//
//  Created by optimusmac-12 on 24/07/15.
//  Copyright (c) 2015 mdtaha.optimus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)camera:(id)sender;
- (IBAction)gallery:(id)sender;
- (IBAction)addText:(id)sender;
- (IBAction)save:(id)sender;

@end

