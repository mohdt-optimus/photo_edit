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
    //There are the methods which will be used for gesture recognition.



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
    //This is for movement of image in the view with gesture.
    UIPanGestureRecognizer *moveTextGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveText:)];
    [self.textView addGestureRecognizer:moveTextGesture];
      //This is for movement of textField in the view with gesture.

    UIPinchGestureRecognizer *shrinkImageGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(shrinkInOutImage:)];
    [self.mainView addGestureRecognizer:shrinkImageGesture];
      //This is for zooming and shrinking of image in the view with gesture.
    UIPinchGestureRecognizer *shrinkTextGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(shrinkInOutText:)];
    [self.textView addGestureRecognizer:shrinkTextGesture];
      //This is for zooming and shrinking of textField in the view with gesture.
    UIRotationGestureRecognizer *rotateImageGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
    [self.mainView addGestureRecognizer:rotateImageGesture];
     //This is for rotating of image in the view with gesture.
    UIRotationGestureRecognizer *rotateTextGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateText:)];
    [self.textView addGestureRecognizer:rotateTextGesture];
    //This is for rotating of text field in the view with gesture.
    
    
    
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
{           //To select image from camera, this will open up the camera to take picture
    
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

- (IBAction)gallery:(id)sender
{       //To select image from gallery, this will open up the gallery to select picture
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
{               //This button action will save the image as it is in the view (Edited image)
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
{                           //If image is saved successfully then Success message will be shown otherwise unsuccess message will be displayed
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
{                          //This is for recognising and performing move gesture on image
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    self.mainView.center = touchLocation;
}

-(void)moveText:(UIPanGestureRecognizer *)panGestureRecognizer
{                           //This is for recognising and performing move gesture on text
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    self.textView.center = touchLocation;
}


-(void)shrinkInOutImage:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{                          //This is for recognising and performing shrink in and out gesture on image
    self.mainView.transform = CGAffineTransformScale(self.mainView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    
    pinchGestureRecognizer.scale = 1.0;
}
-(void)shrinkInOutText:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{                   //This is for recognising and performing shrink in and out gesture on text
    self.textView.transform = CGAffineTransformScale(self.textView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    
    pinchGestureRecognizer.scale = 1.0;
}


-(void)rotateImage:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{                   //This is for recognising and performing rotateion gesture on image
    self.mainView.transform = CGAffineTransformRotate(self.mainView.transform, rotationGestureRecognizer.rotation);
    
    rotationGestureRecognizer.rotation = 0.0;
}

-(void)rotateText:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{               //This is for recognising and performing rotation gesture on image
    self.textView.transform = CGAffineTransformRotate(self.textView.transform, rotationGestureRecognizer.rotation);
    
    rotationGestureRecognizer.rotation = 0.0;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{               //This will dismiss keyboard when user touches any where in the view
    [self.view endEditing:YES];
}


@end
