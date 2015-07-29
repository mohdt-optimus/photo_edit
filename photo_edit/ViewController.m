//
//  ViewController.m
//  photo_edit
//
//  Created by optimusmac-12 on 24/07/15.
//  Copyright (c) 2015 mdtaha.optimus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

-(void)moveImage:(UIPanGestureRecognizer *)panGestureRecognizer;
-(void)moveText:(UIPanGestureRecognizer *)panGestureRecognizer1;
-(void)shrinkInOutImage:(UIPinchGestureRecognizer *)pinchGestureRecognizer;
-(void)shrinkInOutText:(UIPinchGestureRecognizer *)pinchGestureRecognizer1;
-(void)rotateImage:(UIRotationGestureRecognizer *)rotationGestureRecognizer;
-(void)rotateText:(UIRotationGestureRecognizer *)rotationGestureRecognizer1;




@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIPanGestureRecognizer *moveImageGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    [self.mainView addGestureRecognizer:moveImageGesture];
    
    UIPanGestureRecognizer *moveTextGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveText:)];
    [self.textView addGestureRecognizer:moveTextGesture];
    

    UIPinchGestureRecognizer *shrinkImageGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(shrinkInOutImage:)];
    [self.mainView addGestureRecognizer:shrinkImageGesture];
    
    UIPinchGestureRecognizer *shrinkTextGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(shrinkInOutText:)];
    [self.textView addGestureRecognizer:shrinkTextGesture];
    
    UIRotationGestureRecognizer *rotateImageGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
    [self.mainView addGestureRecognizer:rotateImageGesture];
    
    UIRotationGestureRecognizer *rotateTextGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateText:)];
    [self.textView addGestureRecognizer:rotateTextGesture];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)imagePickerController:(UIImagePickerController *)photoPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageView setImage:selectedImage];
    
    [photoPicker dismissModalViewControllerAnimated:YES];
}

- (IBAction)camera:(id)sender
{
    
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

- (IBAction)gallery:(id)sender
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

- (IBAction)addText:(id)sender
{
    _textView.hidden=false;
}

- (IBAction)save:(id)sender
{
    UIGraphicsBeginImageContext(_viewScreen.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
}


- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *alertTitle;
    NSString *alertMessage;
    
    if(!error)
    {
        alertTitle   = @"Image Saved";
        alertMessage = @"Image saved to photo album successfully.";
    }
    else
    {
        alertTitle   = @"Error";
        alertMessage = @"Unable to save to photo album.";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                    message:alertMessage
                                                   delegate:self
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
}


-(void)moveImage:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    self.mainView.center = touchLocation;
}

-(void)moveText:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    self.textView.center = touchLocation;
}


-(void)shrinkInOutImage:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    self.mainView.transform = CGAffineTransformScale(self.mainView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    
    pinchGestureRecognizer.scale = 1.0;
}
-(void)shrinkInOutText:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    self.textView.transform = CGAffineTransformScale(self.textView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    
    pinchGestureRecognizer.scale = 1.0;
}


-(void)rotateImage:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    self.mainView.transform = CGAffineTransformRotate(self.mainView.transform, rotationGestureRecognizer.rotation);
    
    rotationGestureRecognizer.rotation = 0.0;
}

-(void)rotateText:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    self.textView.transform = CGAffineTransformRotate(self.textView.transform, rotationGestureRecognizer.rotation);
    
    rotationGestureRecognizer.rotation = 0.0;
}



@end
